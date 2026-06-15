ALTER   procedure [dbo].[SP_RM_GetRouteStatisticsDetailForDate](
    @date datetime NULL,
    @userId bigint NULL,
    @firm smallint NULL)
AS
BEGIN
	-- Last modified by Kanan Mammadov to fix count issues

    with Routes as (
        select TigerClientId as ClientId
        from MD_Route with (nolock)
        where Firm = @firm
          and UserId = @userId
          and Date = @date),

         Sales as (
             select distinct ClientId
             from OP_IncomingLog ILog with (nolock)
                      join OP_GeneralLog GLog with (nolock) on ILog.Id = GLog.RequestId and GLog.ImportResult = 0
             where ILog.UserId = @userId
               and ILog.ProcessDate = @date
               and ILog.Firm = @firm),

         Visits as (select distinct ClientId
                    from OP_ClientVisitLog
                    where cast(CreatedDate as date) = @date
                      and CreatedUserId = @userId
                      and Firm = @firm),

         Results as (
             select coalesce(Routes.ClientId, Sales.ClientId, Visits.ClientId)           as ClientId,
                    iif(Routes.ClientId is not null, 1, 0)                               as IsOnRoute,
                    iif(Sales.ClientId is not null or Visits.ClientId is not null, 1, 0) as IsVisisted
             from Routes
                      full join Sales on Sales.ClientId = Routes.ClientId
                      full join Visits on Visits.ClientId = Routes.ClientId)

    select Name       as ClientName,
           Code       as ClientCode,
           Edino      as ClientEdino,
           IsOnRoute  as IsOnRoute,
           IsVisisted as IsVisited
    from Results
             join MD_Client Client with (nolock) on Client.TigerId = Results.ClientId and Client.Firm = @firm and Client.IsDeleted = 0
END