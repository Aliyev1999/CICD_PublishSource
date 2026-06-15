CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetRouteStatisticsEmployees](@beginDate datetime2, @endDate datetime2, @currentUserId bigint)
    RETURNS TABLE
        AS
        RETURN(with TreeUsers as (select UserId
                                  from F_GetPermittedUsers(@currentuserId)),
                    Routes as (select Routes.UserId, Routes.TigerClientId as ClientId, Routes.Date
                               from MD_Route Routes with (nolock)
                                        join TreeUsers Permitted on Permitted.UserId = Routes.UserId
                               where Routes.Date between @begindate and @enddate
                                 and Routes.Status = 0),

                    Actions as (select Logs.UserId, Logs.ClientId, Logs.ProcessDate as Date
                                from OP_IncomingLog Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where Logs.ProcessDate between @begindate and @enddate


                                union
                                select Logs.CreatedUserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from OP_ClientVisitLog Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.CreatedUserId
                                where Logs.CreatedDate between @begindate and @enddate


                                union
                                select Logs.CreatorUserId, Logs.ClientTigerId, cast(Logs.CreatedDate as date)
                                from IM_InventoryStateHistory Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.CreatorUserId
                                where Logs.CreatedDate between @begindate and @enddate


                                union
                                select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from WPM_TaskTicket Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where Logs.CreatedDate between @begindate and @enddate


                                union
                                select Logs.UserId, Logs.ClientId, cast(Logs.CreatedDate as date)
                                from CHL_UserSurveyResponse Logs with (nolock)
                                         join TreeUsers Permitted on Permitted.UserId = Logs.UserId
                                where Logs.CreatedDate between @begindate and @enddate),

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
                                          sum(iif(IsRoute = 0 and IsVisited = 1, 1, 0)) as NonRouteVisit,
                                          UserId
                                   from Combined
                                   group by UserId)

               select users.Id                               as UserId,
                      users.UserName                             as UserName,
                      concat(users.Name, ' ', users.Surname) as UserFullName,
                      Photo.SecureUrl                        as UserImage,
                      (Planned - InRouteVisit)               as WaitingCount,
                      InRouteVisit                           as OnRouteCount,
                      NonRouteVisit                          as OffRouteCount,
                        cast(
						case 
							 when Planned = 0 then 0
							 else (InRouteVisit * 100) / Planned
						end 
				   as int)                                   as PlanCompletion,
				 
				   cast(
						((InRouteVisit + NonRouteVisit) * 100) / iif(Planned = 0, 1, Planned)
				   as int)                                   as OverallCompletion
               from VisitTotal
                        join AbpUsers users on VisitTotal.UserId = users.Id
                        left join AbpUserProfilePhoto Photo with (nolock) on Photo.UserId = Users.Id)