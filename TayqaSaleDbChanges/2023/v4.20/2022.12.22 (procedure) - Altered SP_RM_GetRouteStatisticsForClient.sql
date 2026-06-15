ALTER   procedure [dbo].[SP_RM_GetRouteStatisticsForClient](
    @beginDate datetime,
    @endDate datetime,
    @userId bigint,
    @firm smallint)
AS
BEGIN
	-- Last modified by Kanan Mammadov to fix count issues

    with Routes as (
        select TigerClientId as ClientId, Date
        from MD_Route with (nolock)
        where UserId = @userId
          and Firm = @firm
          and Date between @beginDate and @endDate),

         Sales as (select distinct Firm, ClientId as ClientId, ProcessDate as Date
                     from OP_IncomingLog ILog with (nolock)
                              join OP_GeneralLog GLog with (nolock) on GLog.RequestId = ILog.Id and GLog.ImportResult = 0
                       where ILog.DocType < 20
					   and ILog.UserId = @userId
                       and ProcessDate between cast(@beginDate as date) and cast(@endDate as date)

                     union

                     select distinct Firm, ClientId, cast(CreatedDate as date) as Date
                     from OP_ClientVisitLog Visits with (nolock)
                       where CreatedUserId = @userId and cast(CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)),

         Results as (
             select coalesce(Routes.ClientId, Sales.ClientId)                                              as ClientId,
                    sum(iif(Routes.Date is not null, 1, 0))                                                                 as RouteCount,
                    sum(iif(Routes.Date is not null and Sales.ClientId is not null , 1, 0)) as RouteVisitCount,
                    sum(iif(Routes.Date is null and Sales.ClientId is not null, 1, 0))     as NonRouteVisitCount

             from Routes
                      full join Sales on Routes.ClientId = Sales.ClientId and Routes.Date = Sales.Date
             group by coalesce(Routes.ClientId, Sales.ClientId))

    select TigerId                              as ClientId,
           Code                                 as ClientCode,
           Name                                 as ClientName,
           Edino                                as ClientEdino,
           routeCount                           as RouteCount,
           routeVisitCount                      as RouteVisitCount,
           nonRouteVisitCount                   as NonRouteVisitCount,
           routeVisitCount + nonRouteVisitCount as TotalVisistCount
    from Results
             join MD_Client Clients with (nolock) on Clients.TigerId = Results.ClientId and Clients.Firm = @firm and IsDeleted = 0

	order by Results.RouteVisitCount desc

END