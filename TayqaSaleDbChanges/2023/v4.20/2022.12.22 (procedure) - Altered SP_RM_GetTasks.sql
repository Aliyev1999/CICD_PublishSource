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
                                                 join WPM_TaskClient TaskClients on PermitClients.ClientId = TaskClients.ClientId
                                                 join WPM_TaskSchedule TaskSchedules with (nolock) on TaskSchedules.TaskId = TaskClients.TaskId
                                                 inner join WPM_Task Tasks with (nolock) on TaskClients.TaskId = Tasks.Id
                                                 left join WPM_UserTask UserTasks with (nolock) on TaskClients.TaskId = UserTasks.TaskId
                                        where UserTasks.Id is null and Tasks.Type=5
                                          and Tasks.IsDeleted = 0
                                          and TaskSchedules.StartDate <= @endDate and @beginDate <= TaskSchedules.EndDate);


    with Data as (select Clients.Id,
                         IIF(count(Clients.Id) - count(TaskTickets.Id) = 0, 1, 0) as Finalized-- is finalized

                  from WPM_UserTask UserTask with (nolock)
                           join WPM_Task Tasks with (nolock)
                                on Tasks.Id = UserTask.TaskId and Tasks.IsDeleted = 0 and Tasks.Type = 1 and Tasks.Status = 0
                           join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Tasks.Id and PeriodType = 1 and Schedule.Status = 0
                           join WPM_TaskClient Clients with (nolock) on Clients.TaskId = Tasks.Id
                          join F_GetAllPermittedClient() PermittedClients
								on PermittedClients.ClientId = Clients.ClientId and PermittedClients.Firm = @firm and PermittedClients.UserId = UserTask.UserId
                           left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = UserTask.UserId
                           left join WPM_TaskTicket TaskTickets with (nolock)
                                     on TaskTickets.TaskId = Tasks.Id and UserTask.UserId = TaskTickets.UserId and
                                        Clients.ClientId = TaskTickets.ClientId and
                                        TaskTickets.FinalizedDate is not null

                  where ((@viewMode = 1 and UserTask.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                    and Tasks.Firm = @firm
					and Schedule.StartDate <= @endDate and @beginDate <= Schedule.EndDate
                  group by Clients.Id)

    select Isnull(sum(iif(Finalized = 1, 1, 0)), 0) as DoneTasks,
           Isnull(sum(iif(Finalized = 0, 1, 0)), 0) as PendingTasks,
           @UnAssignedTaskCount                     as UnAssignedTasks
    from Data

end