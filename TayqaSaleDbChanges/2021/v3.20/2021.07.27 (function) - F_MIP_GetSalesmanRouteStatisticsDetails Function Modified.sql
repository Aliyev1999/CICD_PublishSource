/****** Object:  UserDefinedFunction [dbo].[F_MIP_GetSalesmanRouteStatisticsDetails]    Script Date: 8/2/2021 5:38:29 PM ******/
ALTER FUNCTION [dbo].[F_MIP_GetSalesmanRouteStatisticsDetails](@startDate DATE, @endDate DATE, @userId BIGINT, @inRoute BIT = NULL,
    @clientFilterEnabled BIT, @latStart FLOAT, @latEnd FLOAT, @longStart FLOAT, @longEnd FLOAT, @firm SMALLINT, @userActionTypes NVARCHAR(MAX) = NULL)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH Users AS (
                    SELECT Id, UserName, Name, Surname
                    FROM Abpusers Users WITH (NOLOCK)
                    WHERE IsDeleted = 0
                      AND IsActive = 1
                      -- AND Id = @userId
					AND (@userId = 0 OR Id = @userId)
                ),
                Clients AS (
                        SELECT CL.TigerId, CL.Firm
                        FROM MD_Client CL WITH (NOLOCK)
                        WHERE @clientFilterEnabled = 0
                        OR ((CL.Latitude BETWEEN @latStart AND @latEnd)
                            AND (CL.Longitude BETWEEN @longStart AND @longEnd))
                    ),
                AllOperations AS (
                    SELECT UserId, Min(SendDate) AS MinProcessDate, Max(SendDate) AS MaxProcessDate, CAST(SendDate AS DATE) AS ProcessDate,
                        COUNT(DISTINCT ClientId) AS TotalOperations
                    FROM OP_UserActionGpsData allOp WITH (NOLOCK)
                            JOIN Clients CL ON CL.Firm = allOp.Firm AND CL.TigerId = allOp.ClientId
                    WHERE 
					-- UserId = @userId
					(@userId = 0 OR UserId = @userId)
                    AND (@inRoute IS NULL OR
                        (@inRoute = IIF((SELECT COUNT(*)
                        FROM MD_Route r WITH (NOLOCK)
                        WHERE r.Date >= @startDate
                            AND r.Date <= @endDate
                            AND r.Date = CAST(allOp.SendDate AS DATE)
                            AND r.TigerClientId = allOp.ClientId
                            AND r.Firm = allOp.Firm
                            AND r.UserId = allOp.UserId) > 0, 1, 0)))
                    AND allOp.Firm = @firm
					AND (@userActionTypes IS NULL OR allOp.ActionTypeId IN (SELECT [Value] FROM F_SplitList(@userActionTypes, ', ')))
                    GROUP BY UserId, CAST(SendDate AS DATE)),
                OrderOperations AS (
                    SELECT UserId, Min(SendDate) AS MinProcessDate, Max(SendDate) AS MaxProcessDate, CAST(SendDate AS DATE) AS ProcessDate,
                        COUNT(DISTINCT ClientId) AS TotalOrders
                    FROM OP_UserActionGpsData ordOp WITH (NOLOCK)
                            JOIN Clients CL ON CL.Firm = ordOp.Firm AND CL.TigerId = ordOp.ClientId
                    WHERE ActionTypeId = 1
                    --AND UserId = @userId
                    AND (@userId = 0 OR UserId = @userId)
					AND (@inRoute IS NULL OR
                        (@inRoute = IIF((SELECT COUNT(*)
                        FROM MD_Route r WITH (NOLOCK)
                        WHERE r.Date >= @startDate
                            AND r.Date <= @endDate
                            AND r.Date = CAST(ordOp.SendDate AS DATE)
                            AND r.TigerClientId = ordOp.ClientId
                            AND r.Firm = ordOp.Firm
                            AND r.UserId = ordOp.UserId) > 0, 1, 0)))
                    AND ordOp.Firm = @firm
                    GROUP BY UserId, CAST(SendDate AS DATE)),
                SRoutes AS (
                    SELECT UserId, Date, COUNT(*) AS RouteCount
                    FROM MD_Route R WITH (NOLOCK)
                            INNER JOIN Users ON Users.Id = R.UserId AND R.Status = 0
                            JOIN Clients CL ON CL.Firm = R.Firm AND CL.TigerId = R.TigerClientId
                    WHERE
					-- UserId = @userId
					(@userId = 0 OR UserId = @userId)
                    AND R.Firm = @firm
                    GROUP BY UserId, Date
                ),
                InvoiceCounts AS (
                    SELECT UAGD.UserId, COUNT(DISTINCT UAGD.ClientId) AS InvoicedClientsCount, CAST(UAGD.SendDate AS DATE) AS Date
                    FROM OP_UserActionGpsData UAGD WITH (NOLOCK)
                            JOIN OP_GeneralLog GL WITH (NOLOCK) ON GL.RequestId = UAGD.ActionLogId
                            JOIN ERP_Invoice I WITH (NOLOCK) ON I.ERPOrderId = GL.TigerId AND I.Firm = UAGD.Firm AND I.ERPOrderId != 0 AND Gl.TigerId != 0
                            JOIN Clients CL ON CL.Firm = UAGD.Firm AND CL.TigerId = UAGD.ClientId
                    WHERE CAST(UAGD.SendDate AS DATE) >= @startDate
                    AND CAST(UAGD.SendDate AS DATE) <= @endDate
                    AND (@inRoute IS NULL OR
                        (@inRoute = IIF((SELECT COUNT(*)
                        FROM MD_Route r WITH (NOLOCK)
                        WHERE r.Date >= @startDate
                            AND r.Date <= @endDate
                            AND r.Date = CAST(UAGD.SendDate AS DATE)
                            AND r.TigerClientId = UAGD.ClientId
                            AND r.Firm = UAGD.Firm
                            AND r.UserId = UAGD.UserId) > 0, 1, 0)))
                    AND UAGD.Firm = @firm
					AND (@userActionTypes IS NULL OR UAGD.ActionTypeId IN (SELECT [Value] FROM F_SplitList(@userActionTypes, ', ')))
                    GROUP BY UAGD.UserId, CAST(UAGD.SendDate AS DATE)
                     )
                SELECT Users.Id AS UserId,
                       iif(SRoutes.Date IS NULL, AllOperations.ProcessDate, SRoutes.Date) as Date,
                       iif(AllOperations.MinProcessDate is null, '1900-01-01', AllOperations.MinProcessDate) AS FirstOperationTime,
                        iif(AllOperations.MaxProcessDate is null, '2099-01-01', AllOperations.MaxProcessDate) AS LastOperationTime,
                       ISNULL(InvoiceCounts.InvoicedClientsCount, 0) AS InvoicedClientsCount,
                       ISNULL(SRoutes.RouteCount, 0) AS RouteCount,
                       ISNULL(AllOperations.TotalOperations, 0) AS TotalOperations, ISNULL(OrderOperations.TotalOrders, 0) AS TotalOrders,
                       ISNULL(IIF(AllOperations.TotalOperations > 0, ROUND(CAST(AllOperations.TotalOperations AS FLOAT) / CAST(SRoutes.RouteCount AS FLOAT) * 100, 2), 0), 0) AS RatioRouteToVisit,
                       ISNULL(IIF(AllOperations.TotalOperations > 0, ROUND(CAST(OrderOperations.TotalOrders AS FLOAT) / CAST(AllOperations.TotalOperations AS FLOAT) * 100,2), 0), 0) AS RatioVisitToOrder,
                       ISNULL(IIF(OrderOperations.TotalOrders > 0, ROUND(CAST(OrderOperations.TotalOrders AS FLOAT) / CAST(SRoutes.RouteCount AS FLOAT) * 100, 2), 0), 0) AS RatioRouteToOrder
                FROM Users
                         LEFT JOIN AllOperations ON AllOperations.UserId = Users.Id
                         LEFT JOIN SRoutes ON (SRoutes.UserId = AllOperations.UserId AND SRoutes.Date = AllOperations.ProcessDate)
                         LEFT JOIN OrderOperations ON (OrderOperations.UserId = Users.Id AND OrderOperations.UserId = AllOperations.UserId AND OrderOperations.ProcessDate = AllOperations.ProcessDate)
                         LEFT JOIN InvoiceCounts ON AllOperations.ProcessDate = InvoiceCounts.Date AND Users.Id = InvoiceCounts.UserId
                WHERE iif(SRoutes.Date IS NULL, AllOperations.ProcessDate, SRoutes.Date) >= @startDate
                  AND iif(SRoutes.Date IS NULL, AllOperations.ProcessDate, SRoutes.Date) <= @endDate
            )
