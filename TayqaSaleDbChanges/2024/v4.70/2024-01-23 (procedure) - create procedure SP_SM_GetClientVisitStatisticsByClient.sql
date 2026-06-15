
create procedure [dbo].[SP_SM_GetClientVisitStatisticsByClient](
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
                     and Route.Firm = @firm and Route.Status=0  and Route.TigerClientId=@clientId
                   group by Route.TigerClientId, Route.Firm, Route.UserId, Route.Date),
     Visits as (select Ticket.Firm,
                       Ticket.ClientId,
                       Ticket.UserId,
					   Ticket.CreatedDate as Date
                from WPM_TaskTicket Ticket with (nolock)
                where Ticket.Firm = @firm
                  and Ticket.IsCompleted = 1
				  and Ticket.ClientId=@clientId
                  and cast(Ticket.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)

                union

                select Visit.Firm          as Firm,
                       Visit.ClientId      as ClientId,
                       Visit.CreatedUserId as UserId,
					   Visit.Date		   as Date
                from OP_ClientVisitLog Visit with (nolock)
                where Visit.Firm = @firm
				  and Visit.ClientId=@clientId
                  and cast(Visit.CreatedDate as date) between cast(@startDate as date) AND cast(@endDate as date)),
     Result as (select isnull(RouteData.TigerClientId, Visits.ClientId)                          as ClientId,
                       cast(isnull(RouteData.UserId, Visits.UserId) as int)                        as UserId,
                       isnull(RouteData.Firm, Visits.Firm)                                         as Firm,
                       isnull(RouteData.VisitCount,0)                                              as PlannedVisitCount,
                       sum(iif(RouteData.TigerClientId is not null and Visits.ClientId is not null, 1, 0))     as RouteVisitCount,
                       sum(iif(RouteData.TigerClientId is null and Visits.ClientId is not null, 1, 0)) as NonRouteVisitCount,
					   ISNULL( Visits.Date, RouteData.Date) as Date
              from RouteData
                       full join Visits on Visits.ClientId = RouteData.TigerClientId and RouteData.Firm = Visits.Firm and RouteData.UserId=Visits.UserId
              group by isnull(RouteData.TigerClientId, Visits.ClientId), cast(isnull(RouteData.UserId, Visits.UserId) as int),
                       isnull(RouteData.Firm, Visits.Firm),isnull(RouteData.VisitCount,0), ISNULL( Visits.Date, RouteData.Date))
	
				  select 
					   Result.PlannedVisitCount                 as PlannedCount,
					   sum(Result.RouteVisitCount )  +    sum( Result.NonRouteVisitCount  )          as VisitCount,
					   cast(result.date as date) 						        as Date
					from Result
					join AbpUsers Users with(nolock) on Result.UserId=Users.Id
					left join F_SplitList(@selectedUsers, ',') selectedUsers on Users.Id = LTRIM(selectedUsers.Value)
					where ( Users.Id = LTRIM(selectedUsers.Value)) 
					group by Result.PlannedVisitCount ,cast(result.date as date) 
	
End


