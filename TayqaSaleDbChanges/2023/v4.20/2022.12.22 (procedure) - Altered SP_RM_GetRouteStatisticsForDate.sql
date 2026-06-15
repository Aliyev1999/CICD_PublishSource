ALTER   procedure [dbo].[SP_RM_GetRouteStatisticsForDate] @beginDate datetime,
                                                                @endDate datetime,
                                                                @userId bigint,
                                                                @firm smallint
AS
BEGIN

    with Routes as (
        select TigerClientId as ClientId, Date
        from MD_Route with (nolock)
        where UserId = @userId
          and Firm = @Firm
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
             select coalesce(Routes.Date, Sales.Date)                                                          as date,
                    datepart(dw, coalesce(Routes.Date, Sales.Date))                                            as dayOfWeek,
                    sum(iif(Routes.Date is not null, 1, 0))                                                                 as routeCount,
                    sum(iif(Routes.Date is not null and Sales.ClientId is not null, 1, 0)) as routeVisitCount,
                    sum(iif(Routes.Date is null and Sales.ClientId is not null, 1, 0))     as nonRouteVisitCount

             from Routes
                      full outer join Sales on Routes.ClientId = Sales.ClientId and Routes.Date = Sales.Date 
					  group by coalesce(Routes.Date, Sales.Date))

    select date                                 as date,
           iif(dayOfWeek = 1, 7, dayOfWeek - 1) as dayOfWeek,
           routeCount                           as routeCount,
           routeVisitCount                      as routeVisitCount,
           nonRouteVisitCount                   as nonRouteVisitCount,
           routeVisitCount + nonRouteVisitCount as totalVisistCount
    from Results

END