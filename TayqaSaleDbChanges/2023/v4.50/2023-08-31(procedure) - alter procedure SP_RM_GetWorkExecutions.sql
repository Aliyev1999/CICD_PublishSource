
ALTER procedure [dbo].[SP_RM_GetWorkExecutions](@userId int,
                                                @firm smallint,
                                                @beginDate datetime,
                                                @endDate datetime,
                                                @viewMode tinyint =1)
AS
BEGIN

    select sum(iif(TaskTickets.Id is not null, 1, 0))     as DoneExecutions,
           sum(iif(TaskTickets.Id is null, 1, 0)) as PendingExecutions

    from WPM_UserTask UserTask with (nolock)
             join WPM_Task Tasks with (nolock) on Tasks.Id = UserTask.TaskId and Tasks.IsDeleted = 0 and Tasks.Type = 5 and Tasks.Status = 0
             join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Tasks.Id and PeriodType = 1 and Schedule.Status = 0
             join WPM_TaskClient Clients with (nolock) on Clients.TaskId = Tasks.Id
             join F_GetAllPermittedClient() PermittedClients on PermittedClients.ClientId = Clients.ClientId and PermittedClients.Firm = @firm and PermittedClients.UserId = UserTask.UserId
             left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = UserTask.UserId
             left join WPM_TaskTicket TaskTickets with (nolock)
                       on TaskTickets.TaskId = Tasks.Id and UserTask.UserId = TaskTickets.UserId and
                          Clients.ClientId = TaskTickets.ClientId and
                          TaskTickets.FinalizedDate is not null

    where ((@viewMode is null or @viewMode = 1 and UserTask.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
      and Tasks.Firm = @firm and UserTask.Status=0
      and cast(Schedule.StartDate as date)<= cast(@endDate as date)and cast(@beginDate as date)<= cast(Schedule.EndDate as date)

end