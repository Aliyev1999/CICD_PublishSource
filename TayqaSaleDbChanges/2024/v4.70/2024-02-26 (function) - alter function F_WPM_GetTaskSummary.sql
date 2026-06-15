
ALTER FUNCTION [dbo].[F_WPM_GetTaskSummary](@startDate datetime, @endDate datetime, @userId int)
    Returns Table
        AS
        RETURN
        -- Author: TayqaTech for TayqaSale (Kanan Mammadov)
        -- Ticket: TSC-3560
        -- Date: 21.05.2022
        -- Description: The query returns task summary counts for users

        select TreeUsers.UserId                                                                      as UserId,
               sum(iif(Tickets.CreatedDate is null and Tickets.FinalizedDate is null, 1, 0))         as PendingTasks,
               sum(iif(Tickets.CreatedDate is not null and Tickets.FinalizedDate is null, 1, 0))     as InProgressTasks,
               sum(iif(Tickets.CreatedDate is not null and Tickets.FinalizedDate is not null, 1, 0)) as CompletedTasks
        from WPM_UserTask TaskUsers
                 join WPM_Task Tasks on Tasks.Id = TaskUsers.TaskId and Tasks.IsDeleted = 0 and Tasks.Type in (1,5) and Tasks.Status = 0
                 join WPM_TaskSchedule Schedule on Schedule.TaskId = Tasks.Id and Schedule.PeriodType = 1 and Schedule.Status = 0
                 join WPM_TaskClient Clients on Clients.TaskId = Tasks.Id
                 join F_GetAllPermittedClient() FN on FN.Firm = Tasks.Firm and FN.UserId = TaskUsers.UserId and FN.ClientId = Clients.ClientId
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TaskUsers.UserId
                 left join WPM_TaskTicket Tickets with (nolock)
                           on Tickets.Firm = Tasks.Firm and Tickets.TaskId = Tasks.Id and
                              Tickets.UserId = TreeUsers.UserId and
                              Tickets.ClientId = Clients.ClientId
        -- and Tickets.FinalizedDate is not null
        where cast(Schedule.StartDate as date) <= cast(@endDate as date)
          and cast(@startDate as date) <= cast(Schedule.EndDate as date)
          and TaskUsers.Status = 0
        group by TreeUsers.UserId