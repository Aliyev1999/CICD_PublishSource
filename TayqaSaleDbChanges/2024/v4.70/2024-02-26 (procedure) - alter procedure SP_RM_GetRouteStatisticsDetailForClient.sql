
ALTER procedure [dbo].[SP_RM_GetRouteStatisticsDetailForClient](
    @beginDate datetime,
    @endDate datetime,
    @userId bigint,
    @firm smallint,
    @clientId int)
AS
BEGIN

    -- Last modified by Kanan Mammadov to fix count issues

    with Routes as (select Date
                    from MD_Route with (nolock)
                    where Firm = @Firm
                      and UserId = @UserId
                      and Date between @begindate and @endDate
                      and TigerClientId = @clientId),

         Actions as (select distinct ProcessDate as Date
                     from OP_IncomingLog ILog with (nolock)
                              join OP_GeneralLog GLog with (nolock) on ILog.Id = GLog.RequestId and GLog.ImportResult = 0
                     where ILog.UserId = @UserId
                       and ILog.ProcessDate between @begindate and @endDate
                       and ClientId = @clientId
                       and ILog.Firm = @Firm

                     union

                     select cast(CreatedDate as date) as Date
                     from OP_ClientVisitLog
                     where cast(CreatedDate as date) between @begindate and @endDate
                       and CreatedUserId = @UserId
                       and Firm = @Firm
                       and ClientId = @clientId

                     union

                     select distinct cast(CreatedDate as date) as Date
                     from WPM_TaskTicket with (nolock)
                     where UserId = @userId
                       and Firm = @firm
                       and cast(CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
                       and ClientId = @clientId),

         Results as (select distinct coalesce(Routes.Date, Actions.Date) as Date,
                                     iif(Routes.Date is not null, 1, 0)  as IsOnRoute,
                                     iif(Actions.Date is not null, 1, 0) as IsVisisted
                     from Routes
                              full join Actions on Actions.Date = Routes.Date)

    select Date,
           IsOnRoute  as IsOnRoute,
           IsVisisted as IsVisited
    from Results
END