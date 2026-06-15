ALTER procedure [dbo].[SP_SM_GetClientVisitStatisticsByClient](
    @startDate datetime,
    @endDate datetime,
    @selectedUsers nvarchar(500),
    @firm smallint,
    @clientId int
)
AS
BEGIN


    with RouteData as (select Route.TigerClientId,
                              Route.Firm,
                              Count(*)     AS VisitCount,
                              Route.UserId AS UserId,
                              Route.Date
                       from MD_Route Route with (nolock)
                       where Route.Date between cast(@startDate as date) and cast(@endDate as date)
                         and Route.Firm = @firm
                         and Route.Status = 0
                         and Route.TigerClientId = @clientId
                       group by Route.TigerClientId, Route.Firm, Route.UserId, Route.Date),
         Visits as (
                   select Visit.Firm          as Firm,
                       Visit.ClientId      as ClientId,
                       Visit.CreatedUserId as UserId,
					   cast(Visit.Date as date)		   as Date
                from OP_ClientVisitLog Visit with (nolock)
                where Visit.Firm = @firm and ClientId=@clientId
                  and cast(Visit.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
				  
				  union 

				SELECT 
                       Ticket.Firm                                                      AS Firm,
				       ClientId                                                         AS ClientId,
					   cast(Ticket.UserId AS INT)                                       AS UserId,
					   cast(Ticket.CreatedDate as date)                                  AS Date
                FROM WPM_TaskTicket Ticket WITH (NOLOCK)
				join WPM_Task Task with(nolock) on Ticket.TaskId=Task.Id
                WHERE Ticket.Firm = @firm and Task.Type=1
                  AND Ticket.IsCompleted = 1 and @clientId=ClientId
                  AND CAST(Ticket.CreatedDate AS DATE) BETWEEN CAST(@startDate AS DATE) AND cast(@endDate as date))
            ,
         Result as (select isnull(RouteData.TigerClientId, Visits.ClientId)                                    as ClientId,
                           cast(isnull(RouteData.UserId, Visits.UserId) as int)                                as UserId,
                           isnull(RouteData.Firm, Visits.Firm)                                                 as Firm,
                           ISNULL(Visits.Date, RouteData.Date)                                                 as Date,
                           iif(RouteData.VisitCount is not null, 1, 0)                                         as PlannedVisitCount,
                           sum(iif(RouteData.TigerClientId is not null and Visits.ClientId is not null, 1, 0)) as RouteVisitCount,
                           sum(iif(RouteData.TigerClientId is null and Visits.ClientId is not null, 1, 0))     as NonRouteVisitCount
                    from RouteData
                             full join Visits on Visits.ClientId = RouteData.TigerClientId and RouteData.Date = cast(Visits.Date as date) and
                                                 RouteData.Firm = Visits.Firm and RouteData.UserId = Visits.UserId
                    group by RouteData.VisitCount, isnull(RouteData.TigerClientId, Visits.ClientId),
                             cast(isnull(RouteData.UserId, Visits.UserId) as int),
                             isnull(RouteData.Firm, Visits.Firm), isnull(RouteData.VisitCount, 0), ISNULL(Visits.Date, RouteData.Date)

                    union

                    SELECT ClientId                                           AS ClientId,
                           cast(Ticket.UserId AS INT)                         AS UserId,
                           Ticket.Firm                                        AS Firm,
                           Ticket.CreatedDate                                 AS Date,
                           iif(Ticket.ManualRouteClientId IS NULL, 1, 0)      as PlannedVisitCount,
                           sum(iif(Ticket.ManualRouteClientId IS NULL, 1, 0)) AS RouteVisitCount,
                           sum(iif(Ticket.ManualRouteClientId > 0, 1, 0))     AS NonRouteVisitCount
                    FROM WPM_TaskTicket Ticket WITH (NOLOCK)
                             join WPM_Task Task with (nolock) on Ticket.TaskId = Task.Id
                    WHERE Ticket.Firm = @firm
                      and Task.Type = 4
                      AND Ticket.IsCompleted = 1
                      And Ticket.ClientId = @ClientId
                      AND CAST(Ticket.CreatedDate AS DATE) BETWEEN CAST(@startDate AS DATE) AND cast(@endDate as date)
                    GROUP BY ClientId, CAST(Ticket.UserId AS INT), Ticket.Firm, Ticket.CreatedDate , Ticket.ManualRouteClientId),


         Last as (select isnull(Result.UserId, RouteData.UserId)          as UserId,
                         isnull(Result.ClientId, RouteData.TigerClientId) as ClientId,
                         isnull(Result.Firm, RouteData.Firm)              as Firm,
                         isnull(Result.Date, RouteData.Date)              as Date,
                         sum(RouteVisitCount)                             as RouteVisitCount,
                         sum(NonRouteVisitCount)                          as NonRouteVisitCount,
                         sum(PlannedVisitCount)                           as PlannedVisitCount
                  from RouteData
                           full outer join Result on Result.UserId = RouteData.UserId and Result.ClientId = RouteData.TigerClientId and
                                                     Result.Firm = RouteData.Firm and RouteData.Date = Result.Date
                  group by isnull(Result.UserId, RouteData.UserId), isnull(Result.ClientId, RouteData.TigerClientId),
                           isnull(Result.Firm, RouteData.Firm), isnull(Result.Date, RouteData.Date)),
		Condition as ( 
    select Last.PlannedVisitCount                                   as PlannedCount,
           sum(Last.RouteVisitCount) + sum(Last.NonRouteVisitCount) as VisitCount,
           cast(Last.Date as date)                                  as Date
    from Last
             join AbpUsers Users with (nolock) on Last.UserId = Users.Id
             left join F_SplitList(@selectedUsers, ',') selectedUsers on Users.Id = LTRIM(selectedUsers.Value)
    where (Users.Id = LTRIM(selectedUsers.Value))  
    group by Last.PlannedVisitCount, cast(Last.Date as date))

	select * from Condition where PlannedCount>0 or VisitCount>0
End


