ALTER PROC [dbo].[SP_MIP_GetSalesmanRouteStatisticsMasterSummary] @startDate DATE, @endDate DATE, @inRoute BIT = NULL, @clientFilterEnabled BIT,
                                                           @latStart FLOAT, @latEnd FLOAT, @longStart FLOAT, @longEnd FLOAT,
                                                           @firm SMALLINT, @userActionTypes NVARCHAR(MAX) = NULL, @currentUserId bigint, @userIds nvarchar(max)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql =
    'WITH Users AS (
        SELECT Id, UserName, Name, Surname
        FROM Abpusers Users WITH (NOLOCK)
        WHERE IsDeleted = 0 AND IsActive = 1),
    Clients AS (
         SELECT CL.TigerId, CL.Firm
         FROM MD_Client CL WITH (NOLOCK)
         WHERE CL.Firm = @firm AND CL.IsDeleted = 0';

    IF (@clientFilterEnabled = 1)
        BEGIN
            SET @sql = CONCAT(@sql,
    ' and ((CL.Latitude BETWEEN @latStart AND @latEnd) AND (CL.Longitude BETWEEN @longStart AND @longEnd))');
        END

    SET @sql = CONCAT(@sql, '),');

    SET @sql = CONCAT(@sql,
'
AllOperations AS (
SELECT UserId, CAST(SendDate AS DATE) AS ProcessDate, COUNT(DISTINCT ClientId) AS TotalOperations
FROM OP_UserActionGpsData allOp WITH (NOLOCK)
       JOIN Clients CL ON CL.Firm = allOp.Firm AND CL.TigerId = allOp.ClientId
WHERE allOp.Firm = @firm');

    IF (@inRoute IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
' AND @inRoute = IIF((SELECT COUNT(*)
  FROM MD_Route r WITH (NOLOCK)
  WHERE r.Date >= @startDate
    AND r.Date <= @endDate
    AND r.Date = CAST(allOp.SendDate AS DATE)
    AND r.TigerClientId = allOp.ClientId
    AND r.Firm = allOp.Firm
    AND r.UserId = allOp.UserId) > 0, 1, 0)');
        END

    IF (@userActionTypes IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
' AND allOp.ActionTypeId IN (SELECT [Value] FROM F_SplitList(@userActionTypes, '',''))');
        END

    SET @sql = CONCAT(@sql,
' GROUP BY UserId, CAST(SendDate AS DATE)),');

    SET @sql = CONCAT(@sql,
'
OrderOperations AS (
SELECT UserId, CAST(SendDate AS DATE) AS ProcessDate, COUNT(DISTINCT ClientId) AS TotalOrders
FROM OP_UserActionGpsData ordOp WITH (NOLOCK)
       JOIN Clients CL ON CL.Firm = ordOp.Firm AND CL.TigerId = ordOp.ClientId
WHERE ActionTypeId = 1  AND ordOp.Firm = @firm');

    IF (@inRoute IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
' AND @inRoute = IIF((SELECT COUNT(*)
  FROM MD_Route r WITH (NOLOCK)
  WHERE r.Date >= @startDate
    AND r.Date <= @endDate
    AND r.Date = CAST(ordOp.SendDate AS DATE)
    AND r.TigerClientId = ordOp.ClientId
    AND r.Firm = ordOp.Firm
    AND r.UserId = ordOp.UserId) > 0, 1, 0)');
        END

    SET @sql = CONCAT(@sql,
' GROUP BY UserId, CAST(SendDate AS DATE)),');

    SET @sql = CONCAT(@sql,
'
SRoutes AS (
SELECT UserId, Date, COUNT(*) AS RouteCount
FROM MD_Route R WITH (NOLOCK)
        INNER JOIN Users ON Users.Id = R.UserId AND R.Status = 0
        INNER JOIN Clients CL ON CL.Firm = R.Firm AND CL.TigerId = R.TigerClientId
WHERE r.Firm = @firm
GROUP BY UserId, Date),');

    SET @sql = CONCAT(@sql,
'
InvoiceCounts AS (
SELECT UAGD.UserId, CAST(UAGD.SendDate AS DATE) AS Date, COUNT(DISTINCT UAGD.ClientId) AS InvoicedClientsCount
FROM OP_UserActionGpsData UAGD WITH (NOLOCK)
       JOIN OP_GeneralLog GL WITH (NOLOCK) ON GL.RequestId = UAGD.ActionLogId
       JOIN ERP_Invoice I WITH (NOLOCK) ON  I.Firm = UAGD.Firm AND I.Type= 4 AND Gl.TigerId != 0 AND ( GL.TigerId=I.ERPOrderId OR I.ERPId = GL.TigerId )
       JOIN Clients CL ON CL.Firm = UAGD.Firm AND CL.TigerId = UAGD.ClientId
WHERE CAST(UAGD.SendDate AS DATE) >= @startDate
AND CAST(UAGD.SendDate AS DATE) <= @endDate
 AND I.Firm = @firm');

    IF (@inRoute IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
' AND @inRoute = IIF((SELECT COUNT(*)
  FROM MD_Route r WITH (NOLOCK)
  WHERE r.Date >= @startDate
    AND r.Date <= @endDate
    AND r.Date = CAST(UAGD.SendDate AS DATE)
    AND r.TigerClientId = UAGD.ClientId
    AND r.Firm = UAGD.Firm
    AND r.UserId = UAGD.UserId) > 0, 1, 0)');
        END

    IF (@userActionTypes IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
  ' AND UAGD.ActionTypeId IN (SELECT [Value] FROM F_SplitList(@userActionTypes, '',''))');
        END

    SET @sql = CONCAT(@sql,
' GROUP BY UAGD.UserId, CAST(UAGD.SendDate AS DATE)
),');

    SET @sql = CONCAT(@sql,
'
  LastQuery AS (SELECT Users.Id AS UserId,
     ISNULL(SUM(SRoutes.RouteCount), 0) AS RouteCount,
     ISNULL(SUM(AllOperations.TotalOperations), 0) AS TotalOperations,
     ISNULL(SUM(OrderOperations.TotalOrders), 0) AS TotalOrders,
     ISNULL(SUM(InvoiceCounts.InvoicedClientsCount), 0) AS InvoicedClientsCount,
     ISNULL(IIF(SUM(AllOperations.TotalOperations) > 0, ROUND(CAST(SUM(AllOperations.TotalOperations) AS FLOAT) / CAST(SUM(SRoutes.RouteCount) AS FLOAT) * 100, 2), 0), 0) AS RatioRouteToVisit,
     ISNULL(IIF(SUM(AllOperations.TotalOperations) > 0, ROUND(CAST(SUM(OrderOperations.TotalOrders) AS FLOAT) / CAST(SUM(AllOperations.TotalOperations) AS FLOAT) * 100, 2), 0), 0) AS RatioVisitToOrder,
     ISNULL(IIF(SUM(OrderOperations.TotalOrders) > 0, ROUND(CAST(SUM(OrderOperations.TotalOrders) AS FLOAT) / CAST(SUM(SRoutes.RouteCount) AS FLOAT) * 100, 2), 0), 0) AS RatioRouteToOrder
FROM Users
       LEFT JOIN AllOperations ON AllOperations.UserId = Users.Id
       LEFT JOIN SRoutes ON (SRoutes.UserId = AllOperations.UserId AND SRoutes.Date = AllOperations.ProcessDate)
       LEFT JOIN OrderOperations ON (OrderOperations.UserId = Users.Id AND OrderOperations.UserId = AllOperations.UserId AND OrderOperations.ProcessDate = AllOperations.ProcessDate)
       LEFT JOIN InvoiceCounts ON (AllOperations.ProcessDate = InvoiceCounts.Date AND Users.Id = InvoiceCounts.UserId)
WHERE IIF(SRoutes.Date IS NULL, AllOperations.ProcessDate, SRoutes.Date) >= @startDate
AND IIF(SRoutes.Date IS NULL, AllOperations.ProcessDate, SRoutes.Date) <= @endDate
GROUP BY Users.Id)');

       SET @sql = CONCAT(@sql,'
        SELECT
		COUNT(lq.UserId) TotalCount,
		COALESCE(sum(lq.TotalOperations), 0) as TotalOperationsCount,
		COALESCE(sum(lq.TotalOrders), 0) as TotalOrdersCount,
		COALESCE(sum(lq.RouteCount), 0)  as TotalRouteCount,
		COALESCE(avg(lq.RatioRouteToOrder),0) as AvarageRatioRouteToOrder,
		COALESCE(avg(lq.RatioRouteToVisit),0) as AvarageRatioRouteToVisit,
		COALESCE(avg(lq.RatioVisitToOrder),0) as AvarageRatioVisitToOrder
       FROM LastQuery lq
        JOIN F_GetPermittedUsers(@currentUserId) u ON lq.UserId=u.UserId
        JOIN AbpUsers users ON users.Id=u.UserId')

        IF (@userIds IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql,
                ' WHERE u.UserId IN (SELECT [Value] FROM F_SplitList(@userIds,  '',''))');
        END
    PRINT Cast(@sql as NText);

       EXEC sp_executesql @sql, N'@startDate date, @endDate date, @inRoute BIT,
                                  @clientFilterEnabled bit, @latStart float, @latEnd float, @longStart float, @longEnd float,
                                  @firm smallint, @userActionTypes NVARCHAR(MAX),  @currentUserId bigint, @userIds nvarchar(max)' ,
       @startDate = @startDate, @endDate = @endDate, @inRoute = @inRoute, @clientFilterEnabled = @clientFilterEnabled, @latStart=@latStart,
		@latEnd = @latEnd, @longStart = @longStart, @longEnd = @longEnd, @firm=@firm, @userActionTypes = @userActionTypes, @currentUserId=@currentUserId, @userIds=@userIds
END

go