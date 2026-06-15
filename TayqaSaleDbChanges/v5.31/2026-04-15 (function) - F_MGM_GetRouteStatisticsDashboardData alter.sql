create or ALTER function [dbo].[F_MGM_GetRouteStatisticsDashboardData]( @firm Smallint, @begindate datetime, @enddate datetime, @userId int = null, @currentuserId bigint)
    returns table
        as
        return(with TreeUsers as (select UserId
                                  from F_GetPermittedUsers(@currentuserId)),
                    Routes as (select Routes.UserId, Routes.TigerClientId as ClientId, Routes.Date
                               from MD_Route Routes with (nolock)
                                        join TreeUsers Permitted on Permitted.UserId = Routes.UserId
                               where Routes.Date between @begindate and @enddate
                                 and Routes.Status = 0
								 and  (@userId is null or Routes.UserId = @userId) and Firm=@firm
								 ),

                    Actions as (select Logs.UserId, Logs.ClientId, Logs.ProcessDate as Date
                                from OP_IncomingLog Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where Logs.ProcessDate between @begindate and @enddate
								and (@userId is null or Logs.UserId = @userId and Firm=@firm
								)


                                union
                                select Logs.CreatedUserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from OP_ClientVisitLog Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.CreatedUserId
                                where cast(Logs.CreatedDate as date) between @begindate and @enddate
								and (@userId is null or Logs.CreatedUserId = @userId and Firm=@firm)


                                union
                                select Logs.CreatorUserId, Logs.ClientTigerId, cast(Logs.CreatedDate as date)
                                from IM_InventoryStateHistory Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.CreatorUserId
                                where cast(Logs.CreatedDate as date) between @begindate and @enddate
								and (@userId is null or Logs.CreatorUserId = @userId and Firm=@firm)


                                union
                                select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from WPM_TaskTicket Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where cast(Logs.CreatedDate as date) between @begindate and @enddate
								and (@userId is null or Logs.UserId = @userId and Firm=@firm)


                                union
                                select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from CHL_UserSurveyResponse Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where cast(Logs.CreatedDate as date) between @begindate and @enddate
								and (@userId is null or Logs.UserId = @userId) and Firm=@firm),

                    Combined as (select coalesce(Routes.UserId, Actions.UserId)     as UserId,
                                        coalesce(Routes.ClientId, Actions.ClientId) as ClientId,
                                        coalesce(Routes.Date, Actions.Date)         as Date,
                                        iif(Routes.UserId is not null, 1, 0)        as IsRoute,
                                        iif(Actions.UserId is not null, 1, 0)       as IsVisited
                                 from Routes
                                          full outer join Actions
                                                          on Routes.ClientId = Actions.ClientId
                                                              and Routes.UserId = Actions.UserId
                                                              and Routes.Date = Actions.Date),

                    VisitTotal as (select sum(IsRoute)                                  as Planned,
                                          sum(iif(IsRoute = 1 and IsVisited = 1, 1, 0)) as InRouteVisit,
                                          sum(iif(IsRoute = 0 and IsVisited = 1, 1, 0)) as NonRouteVisit
                                   from Combined)

               select Planned       as TotalPlanned,
                      InRouteVisit  as TotalOnPlan,
                      NonRouteVisit as TotalOffPlan,
                      round(cast(
                                    case
                                        when Planned = 0 then 0
                                        else (cast(InRouteVisit as float) / Planned) * 100
                                        end as float
                            ), 2)   as PlanCompletionPercentage,

                      round(cast(
                                    ((cast(InRouteVisit + NonRouteVisit as float)) / iif(Planned = 0, 1, Planned) * 100)
                                as float
                            ), 2)   as TotalCompletionPercentage
               from VisitTotal)