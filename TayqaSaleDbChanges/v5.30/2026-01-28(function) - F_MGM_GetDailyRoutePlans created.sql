CREATE OR ALTER function [dbo].[F_MGM_GetDailyRoutePlans](
    @beginDate datetime,
    @endDate datetime,
    @userId int = null,
    @currentUserId bigint
)
    returns @T table
               (
                   [Day]                tinyint,
                   Status               tinyint,
                   CompletionPercentage float
               )
as
begin
    ;
    with DayRange
             as (select top (datediff(day, @beginDate, @endDate) + 1) dateadd(day, v.number, cast(@beginDate as date)) as DayDate
                 from master..spt_values v
                 where v.type = 'P'
                 order by v.number),
         TreeUsers as (select UserId
                       from F_GetPermittedUsers(@currentuserId)),
         Routes as (select Routes.UserId, Routes.TigerClientId as ClientId, Routes.Date
                    from MD_Route Routes with (nolock)
                             join TreeUsers Permitted on Permitted.UserId = Routes.UserId
                    where Routes.Date between @begindate and @enddate
					and (@userId is null or Routes.UserId = @userId)
                      and Routes.Status = 0),

         Actions as (select Logs.UserId, Logs.ClientId, Logs.ProcessDate as Date
                     from OP_IncomingLog Logs with (nolock)
                              join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     where Logs.ProcessDate between @begindate and @enddate
					 and (@userId is null or Logs.UserId = @userId)


                     union
                     select Logs.CreatedUserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                     from OP_ClientVisitLog Logs with (nolock)
                              join TreeUsers Permitted on Permitted.UserId = Logs.CreatedUserId
                     where cast(Logs.CreatedDate as date) between @begindate and @enddate
					 and (@userId is null or Logs.CreatedUserId = @userId)


                     union
                     select Logs.CreatorUserId, Logs.ClientTigerId, cast(Logs.CreatedDate as date)
                     from IM_InventoryStateHistory Logs with (nolock)
                              join TreeUsers Permitted on Permitted.UserId = Logs.CreatorUserId
                     where cast(Logs.CreatedDate as date) between @begindate and @enddate
					 and (@userId is null or Logs.CreatorUserId = @userId)

                     union
                     select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                     from WPM_TaskTicket Logs with (nolock)
                              join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     where cast(Logs.CreatedDate as date) between @begindate and @enddate
					 and (@userId is null or Logs.UserId = @userId)


                     union
                     select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                     from CHL_UserSurveyResponse Logs with (nolock)
                              join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     where cast(Logs.CreatedDate as date) between @begindate and @enddate
					 and (@userId is null or Logs.UserId = @userId)),

         Combined as (select coalesce(route.UserId, action.UserId)     as UserId,
                             coalesce(route.ClientId, action.ClientId) as ClientId,
                             coalesce(route.Date, action.Date)         as WorkDate,
                             iif(route.UserId is not null, 1, 0)       as IsPlannedRoute,
                             iif(action.UserId is not null, 1, 0)      as IsVisited
                      from Routes route
                               full outer join Actions action
                                               on route.ClientId = action.ClientId
                                                   and route.UserId = action.UserId
                                                   and route.Date = action.Date),
         DailyStats as (select combined.WorkDate,
                               sum(IsPlannedRoute)                                  as PlannedRoutes,
                               sum(iif(IsPlannedRoute = 1 and IsVisited = 1, 1, 0)) as VisitsOnRoute,
                               sum(iif(IsPlannedRoute = 0 and IsVisited = 1, 1, 0)) as VisitsOffRoute
                        from Combined combined
                        group by combined.WorkDate),
         DailyCompletion as (select drange.DayDate,
                                    isnull(round(cast(
                                                         ((cast(stat.VisitsOnRoute + stat.VisitsOffRoute as float))
                                                             / iif(stat.PlannedRoutes = 0, 1, stat.PlannedRoutes)) * 100
                                                     as float), 2), 0) as CompletionPercentage
                             from DayRange drange
                                      left join DailyStats stat on stat.WorkDate = drange.DayDate)
    insert
    into @T
    select cast(day(DayDate) as tinyint) as [Day],
           cast(case
                    when CompletionPercentage = 0 then 0
                    when CompletionPercentage > 0 and CompletionPercentage < 50 then 1
                    when CompletionPercentage >= 50 and CompletionPercentage < 70 then 2
                    when CompletionPercentage >= 70 then 3
               end as tinyint)           as Status,
           CompletionPercentage
    from DailyCompletion;

    return;
end