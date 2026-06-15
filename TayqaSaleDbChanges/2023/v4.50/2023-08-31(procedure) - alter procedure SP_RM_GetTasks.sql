ALTER procedure [dbo].[SP_RM_GetTasks](@userId int,
                                       @firm smallint,
                                       @beginDate datetime,
                                       @endDate datetime,
                                       @viewMode tinyInt=1)
AS
begin

-- Author: created by TayqaTech for TayqaSale (Kanan Mammadov)
-- Description: the query returns the task count for user profile KPI screen in app
-- Changed by Anar Farzaliyev on 05.11.2022 11:30 to add unassigned tasks count
-- Last modified by Kanan Mammadov to enable hierarchy of hybrid user

    declare @UnAssignedTaskCount int = (select count(distinct TaskClients.Id)
                                        from F_GetAllPermittedUsersPermittedClients(@userId) as PermitClients
                                                 join WPM_TaskClient TaskClients with(nolock) on PermitClients.ClientId = TaskClients.ClientId
                                                 join WPM_TaskSchedule TaskSchedules with (nolock) on TaskSchedules.TaskId = TaskClients.TaskId
                                                 inner join WPM_Task Tasks with (nolock) on TaskClients.TaskId = Tasks.Id
                                                 left join WPM_UserTask UserTasks with (nolock) on TaskClients.TaskId = UserTasks.TaskId
                                        where UserTasks.Id is null and Tasks.Type=5
                                          and Tasks.IsDeleted = 0
                                          and cast(TaskSchedules.StartDate as date)<=cast(@endDate as date) and cast(@beginDate as date)<=cast( TaskSchedules.EndDate as date));

		      with Data as (select TaskClient.Id as ClientId,
						 TaskTickets.Id as TicketId,
                         IIF(count(TaskClient.Id) - count( TaskTickets.Id) = 0, 1, 0) as Finalized-- is finalized
                  from WPM_UserTask UserTask with (nolock)
                           join WPM_Task Tasks with (nolock) on Tasks.Id = UserTask.TaskId and Tasks.Type = 1 and Tasks.IsDeleted = 0
						   join F_GetPermittedClientForUser(@userId) PermittedClients on PermittedClients.UserId = UserTask.UserId and PermittedClients.Firm = Tasks.Firm
					       join WPM_TaskClient TaskClient with (nolock) on TaskClient.TaskId = UserTask.TaskId and TaskClient.ClientId = PermittedClients.ClientId
                           join WPM_TaskSchedule Schedule with (nolock) on  Schedule.TaskId =UserTask.TaskId
                           left join WPM_TaskTicket TaskTickets with (nolock)
                                     on TaskTickets.TaskId = Tasks.Id and UserTask.UserId = TaskTickets.UserId and
                                        TaskClient.ClientId = TaskTickets.ClientId  and TaskTickets.Firm=@firm
                                       and TaskTickets.FinalizedDate is not null
						   left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = UserTask.UserId 
                  where Tasks.Firm = @firm and UserTask.Status=0 and Tasks.Type=1 and cast(Schedule.StartDate as date)<=cast(@endDate as date) and cast(@beginDate as date)<=cast(Schedule.EndDate as date) and
					((@viewMode = 1 and UserTask.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                  group by TaskClient.Id,TaskTickets.Id)
    select Isnull(sum(iif(Finalized = 1, 1, 0)), 0) as DoneTasks,
           Isnull(sum(iif(Finalized = 0, 1, 0)), 0) as PendingTasks,
		    @UnAssignedTaskCount                    as UnAssignedTasks
    from Data
end

