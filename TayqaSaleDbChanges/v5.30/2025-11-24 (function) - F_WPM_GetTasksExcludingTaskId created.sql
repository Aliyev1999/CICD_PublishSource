
CREATE FUNCTION [dbo].[F_WPM_GetTasksExcludingTaskId](@taskId int, @clientId int, @currentUserId int)
    Returns @Result Table
                    (
                        TaskId   int,
                        TaskName nvarchar(100),
                        Priority smallint
                    )
AS
begin

    declare @TaskType tinyint = (select Type from WPM_Task where Id = @taskId)

    if @TaskType = 4
        insert into @Result (TaskId, TaskName, Priority)
        select Tasks.Id       as TaskId,
               Tasks.Name     as TaskName,
               Tasks.Priority as Priority

        from WPM_Task Tasks with (nolock)
                 join WPM_UserTask Users with (nolock) on Users.TaskId = Tasks.Id
                 join WPM_TaskClient Client with (nolock) on Client.TaskId = Tasks.Id
                 join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Tasks.Id
                 left join WPM_TaskTicket Ticket with (nolock) on Ticket.TaskId = Tasks.Id and Ticket.ClientId = Client.ClientId and
                                                                  Ticket.Firm = Tasks.Firm and Users.UserId = Ticket.UserId and Ticket.FinalizedDate is not null

        where Tasks.Id <> @taskId
          and Client.ClientId = @clientId
          and Users.UserId = @currentUserId
          and getdate() between Schedule.StartDate and Schedule.EndDate
          and Tasks.Status = 0
          and Tasks.IsDeleted = 0
          and Tasks.Type in (1, 5)
          and Users.Status = 0
          and Client.Status = 1
          and Ticket.Id is null

    return
end
go
