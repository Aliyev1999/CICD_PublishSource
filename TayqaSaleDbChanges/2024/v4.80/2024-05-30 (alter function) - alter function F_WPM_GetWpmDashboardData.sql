

ALTER function [dbo].[F_WPM_GetWpmDashboardData](@startDate datetime, @endDate datetime, @currentUserId bigint)
    returns
        @T table
           (
               PlannedVisitCount           int,
               CompletedRouteVisitCount    int,
               CompletedNonRouteVisitCount int,
               NonCompletedTickets         int,
               TotalRouteTime              float,
               TotalNonRouteTime           float
           )
    as
    begin


        declare @NonCompletedTasks int = (select count(Tasks.Id)
                                          from WPM_UserTask UserTask with (nolock)
                                                   join WPM_Task Tasks with (nolock) on Tasks.Id = UserTask.TaskId and Tasks.IsDeleted = 0
                                                   join F_GetAllPermittedClient() PermittedClients
                                                        on PermittedClients.UserId = UserTask.UserId and PermittedClients.Firm = Tasks.Firm
                                                   join WPM_TaskClient TaskClient with (nolock)
                                                        on UserTask.TaskId = TaskClient.TaskId and TaskClient.ClientId = PermittedClients.ClientId
                                                   join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = UserTask.TaskId
                                                   join F_GetPermittedUsersIncludingInactive(@currentUserId) TreeUsers on TreeUsers.UserId = UserTask.UserId
                                                   left join WPM_TaskTicket TaskTickets with (nolock)
                                                             on TaskTickets.TaskId = Tasks.Id and UserTask.UserId = TaskTickets.UserId and
                                                                TaskClient.ClientId = TaskTickets.ClientId and TaskTickets.Firm = Tasks.Firm
                                                                 and TaskTickets.FinalizedDate is not null

                                          where UserTask.Status = 0
                                            and Tasks.Type in (1, 5)
                                            and cast(Schedule.StartDate as date) <= cast(@endDate as date)
                                            and cast(@startDate as date) <= cast(Schedule.EndDate as date)
                                            and TaskTickets.FinalizedDate is null);

        with Routes as (select Planned.UserId, TigerClientId as ClientId, Firm, cast(Date as date) as Date
                        from MD_Route Planned with (nolock)
                                 join F_GetPermittedUsers(@currentUserId) Users on Users.UserId = Planned.UserId
                                 join (select UserTask.UserId
                                       from WPM_UserTask UserTask with (nolock)
                                                join WPM_Task Tasks with (nolock) on Tasks.Id = UserTask.TaskId and Tasks.IsDeleted = 0
                                                join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = UserTask.TaskId
                                       where UserTask.Status = 0
                                         and Tasks.ClientListType = 4
                                         and cast(Schedule.StartDate as date) <= cast(@endDate as date)
                                         and cast(@startDate as date) <= cast(Schedule.EndDate as date)) TaskUser on TaskUser.UserId = Planned.UserId
                        where Planned.Date between cast(@startDate as date) and cast(@endDate as date)),

             Actions as (select Visits.CreatedUserId                                   as UserId,
                                ClientId                                               as ClientId,
                                Firm                                                   as Firm,
                                cast(Date as date)                                     as Date,
                                0                                                      as IsManual,
                                sum(datediff(SECOND, Visits.CreatedDate, Visits.Date)) as TimeSpent
                         from OP_ClientVisitLog Visits with (nolock)
                                  join F_GetPermittedUsers(@currentUserId) Users on Users.UserId = Visits.CreatedUserId
                         where cast(Visits.Date as date) between cast(@startDate as date) and cast(@endDate as date)
                         group by Visits.CreatedUserId, ClientId, Firm, cast(Date as date)

                         union 

                         select Tickets.UserId                                                    as UserId,
                                ClientId                                                          as ClientId,
                                Firm                                                              as Firm,
                                cast(CreatedDate as date)                                         as Date,
                                iif(ManualRouteClientId is not null, 1, 0)                        as IsManual,
                                sum(datediff(SECOND, Tickets.CreatedDate, Tickets.FinalizedDate)) as TimeSpent

                         from WPM_TaskTicket Tickets with (nolock)
                                  join F_GetPermittedUsers(@currentUserId) Users on Users.UserId = Tickets.UserId
                         where cast(Tickets.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
                         group by Tickets.UserId, ClientId, Firm, cast(CreatedDate as date), iif(ManualRouteClientId is not null, 1, 0)

                         union 

                         select IncLog.UserId                                       as UserId,
                                ClientId                                            as ClientId,
                                Firm                                                as Firm,
                                cast(DocCreatedTime as date)                        as Date,
                                0                                                   as IsManual,
                                sum(datediff(SECOND, DocCreatedTime, DocSavedTime)) as TimeSpent

                         from OP_IncomingLog IncLog with (nolock)
                                  join F_GetPermittedUsers(@currentUserId) Users on Users.UserId = IncLog.UserId
                         where cast(IncLog.DocCreatedTime as date) between cast(@startDate as date) and cast(@endDate as date)
                         group by IncLog.UserId, ClientId, Firm, cast(DocCreatedTime as date))

        insert
        into @T (PlannedVisitCount, CompletedRouteVisitCount, CompletedNonRouteVisitCount, NonCompletedTickets, TotalRouteTime, TotalNonRouteTime)
        select isnull(sum(iif(Routes.Firm is not null , 1, 0)), 0)                               as PlannedVisitCount,
               isnull(sum(iif(Routes.Firm is not null and Actions.Firm is not null and IsManual = 0, 1, 0)), 0)                        as CompletedRouteVisitCount,
               isnull(sum(iif((Routes.Firm is null and Actions.Firm is not null) or IsManual = 1, 1, 0)), 0)                           AS CompletedNonRouteVisitCount,
               isnull(@NonCompletedTasks, 0)                                                                                           AS NonCompletedTickets,
               isnull(CAST(sum(iif(Routes.Firm is not null and Actions.Firm is not null and IsManual = 0, TimeSpent, 0)) as float), 0) AS TotalRouteTime,
               isnull(CAST(sum(iif((Routes.Firm is null and Actions.Firm is not null) or IsManual = 1, Timespent, 0)) as float), 0)    AS TotalNonRouteTime
        from Routes
                 full outer join Actions
                                 on Routes.UserId = Actions.UserId and Routes.Firm = Actions.Firm and Routes.ClientId = Actions.ClientId and Routes.Date = Actions.Date

        return
    end