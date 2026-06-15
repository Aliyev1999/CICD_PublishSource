CREATE PROCEDURE [dbo].[SP_MIP_GetMipDashboardGeneralStatistics](@userId bigint)
AS
BEGIN
    DECLARE @sql nvarchar(max);
    SET @sql = '
WITH RouteData AS (
    SELECT
        TigerClientId,
        Firm,
        Routes.UserId,
        Date
    FROM MD_Route Routes WITH (NOLOCK)
	join AbpUsers users with(nolock) on Routes.UserId=Users.Id and Users.IsDeleted=0
	'

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu on Routes.UserId = otu.UserId')
        END
    set @sql = concat(@sql, ' WHERE Date = cast(getdate() as date)  AND Status = 0),

AllVisits AS (
    SELECT
        Ticket.Firm,
        Ticket.ClientId,
        Ticket.UserId,
        CAST(Ticket.CreatedDate AS DATE) AS Date
    FROM  WPM_TaskTicket Ticket WITH (NOLOCK)
	join AbpUsers users with(nolock) on Ticket.UserId=Users.Id and Users.IsDeleted=0
	')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ticket.UserId = otu.UserId');
        END

    set @sql = concat(@sql, ' WHERE  CAST(Ticket.CreatedDate AS DATE) = cast(getdate() as date)

    UNION

    SELECT
        Firm,
        ClientId,
        CreatedUserId AS UserId,
        CAST(CreatedDate AS DATE) AS Date
    FROM OP_ClientVisitLog Visit WITH(NOLOCK)
	join AbpUsers users with(nolock) on Visit.CreatedUserId=Users.Id and Users.IsDeleted=0
	')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Visit.CreatedUserId = otu.UserId')
        END
    set @sql = concat(@sql, '
    WHERE CAST(Date AS DATE) = cast(getdate() as date)

    UNION

    SELECT
        Firm,
        ClientId,
        Ilog.UserId,
        CAST(DocCreatedTime AS DATE) AS Date
    FROM OP_IncomingLog Ilog WITH (NOLOCK)
	join AbpUsers users with(nolock) on Ilog.UserId=Users.Id and Users.IsDeleted=0
	')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ilog.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '

    WHERE ProcessDate = cast(getdate() as date)
),


 AllClients as (select Clients.UserId, count(distinct ClientId) as AllClients 
 from F_GetAllPermittedClient() Clients
 join AbpUsers users with(nolock) on Clients.UserId=Users.Id and Users.IsDeleted=0
 join Md_Client Client with(nolock) on Client.TigerId=Clients.ClientId and Client.IsDeleted=0 and Client.Status=0
 ')
    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Clients.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '
 group by Clients.UserId
 ),
LastData as(

SELECT COALESCE (OV.UserId,RD.UserId) as UserId,
    COUNT(DISTINCT IIF(RD.TigerClientId IS NOT NULL, RD.TigerClientId, NULL)) AS InRouteClientsCount,
    COUNT(DISTINCT OV.ClientId)  AS VisitClientsCount,
    COUNT(DISTINCT IIF(OV.ClientId IS NOT NULL AND RD.TigerClientId IS NOT NULL, OV.ClientId, NULL)) AS InRouteVisitClientsCount,
    COUNT(DISTINCT IIF(OV.ClientId IS NOT NULL AND RD.TigerClientId IS NULL, OV.ClientId, NULL)) AS OutOfRouteVisitsCount
FROM AllVisits OV
FULL OUTER JOIN  RouteData RD  ON RD.Firm = OV.Firm AND RD.UserId = OV.UserId AND RD.Date = OV.Date and  RD.TigerClientId=Ov.ClientId
GROUP BY COALESCE (OV.UserId,RD.UserId))
SELECT 
round((cast(isnull(sum(InRouteClientsCount), 0) as float) / IIF(isnull(sum(Clients.AllClients),1) = 0, 1, isnull(sum(Clients.AllClients),1))) * 100, 2) as InRouteClientsPercent,
round((cast(isnull(sum(LastData.VisitClientsCount), 0) as float) / IIF(isnull(sum(Clients.AllClients),1)= 0, 1, isnull(sum(Clients.AllClients),1))) * 100, 2) as OperationClientsPercent,
round((cast(isnull(sum(LastData.InRouteVisitClientsCount), 0) as float) / IIF(isnull(sum(LastData.InRouteClientsCount) ,1)= 0, 1, isnull(sum(LastData.InRouteClientsCount) ,1))) * 100, 2) as InRouteOperationClientsPercent,
round((cast(isnull(sum(LastData.OutOfRouteVisitsCount), 0) as float) / IIF(isnull(sum(Clients.AllClients) ,1)= 0, 1, isnull(sum(Clients.AllClients) ,1))) * 100, 2) as OutOfRouteVisitsPercent


FROM LastData
full outer join AllClients Clients on Clients.UserId = LastData.UserId')
    print @sql
    execute sp_executesql @sql,
            N' @userId bigint',
            @userId=@userId
END
