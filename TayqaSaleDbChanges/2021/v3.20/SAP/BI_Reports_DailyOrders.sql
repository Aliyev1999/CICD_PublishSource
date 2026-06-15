
/****** Object:  View [dbo].[BI_Reports_DailyOrders]    Script Date: 7/27/2021 6:00:50 PM ******/
ALTER  VIEW [dbo].[BI_Reports_DailyOrders] AS
WITH 
Salesmen AS (
			SELECT s.TigerId, s.Firm, s.Name, s.Code, u.Id as UserId
			FROM Abpusers u  WITH (NOLOCK)
			JOIN UIM_UserEmployeeMapping uem ON uem.UserId = u.Id
			JOIN MD_Salesman s on uem.EmployeeId = s.TigerId and uem.Firm = s.Firm
			WHERE 
			u.IsDeleted = 0 AND u.IsActive = 1 AND uem.Status = 0 AND s.IsDeleted = 0),

Clients  AS
         (
            SELECT CL.TigerId, CL.Firm
            FROM MD_Client CL WITH (NOLOCK)
         ),

Route AS (
		 SELECT UserId, Firm, Date, COUNT(*) RouteClientCount FROM MD_Route WHERE Status = 0 GROUP BY UserId, Firm, Date
		),

RouteClientOperations AS (
         SELECT UserId, CAST(SendDate AS DATE) AS ProcessDate, allOp.Firm, COUNT(DISTINCT ClientId) AS TotalOperations
         FROM OP_UserActionGpsData allOp WITH (NOLOCK)
         JOIN Clients CL ON CL.Firm = allOp.Firm AND CL.TigerId = allOp.ClientId
         WHERE (SELECT COUNT(*)
                FROM MD_Route r WITH (NOLOCK)
                WHERE
                  r.Date = CAST(allOp.SendDate AS DATE)
                  AND r.TigerClientId = allOp.ClientId
                  AND r.Firm = allOp.Firm
                  AND r.UserId = allOp.UserId) > 0
         GROUP BY UserId, allOp.Firm, CAST(SendDate AS DATE)),

NonRouteClientOperations AS (
         SELECT UserId, CAST(SendDate AS DATE) AS ProcessDate, allOp.Firm, COUNT(DISTINCT ClientId) AS TotalOperations
         FROM OP_UserActionGpsData allOp WITH (NOLOCK)
         JOIN Clients CL ON CL.Firm = allOp.Firm AND CL.TigerId = allOp.ClientId
         WHERE (SELECT COUNT(*)
                FROM MD_Route r WITH (NOLOCK)
                WHERE
                r.Date = CAST(allOp.SendDate AS DATE)
                AND r.TigerClientId = allOp.ClientId
                AND r.Firm = allOp.Firm
                AND r.UserId = allOp.UserId) = 0
         GROUP BY UserId, allOp.Firm, CAST(SendDate AS DATE)),
 
MinMaxVisitTimes AS (
         SELECT UserId, allOp.Firm , CAST(SendDate AS DATE) AS ProcessDate, MIN(allOp.SendDate) AS FirstVisitTime, MAX(allOp.SendDate) AS LastVisitTime
         FROM OP_UserActionGpsData allOp WITH (NOLOCK)
         JOIN Clients CL ON CL.Firm = allOp.Firm AND CL.TigerId = allOp.ClientId
         GROUP BY UserId, allOp.Firm, CAST(SendDate AS DATE)),

OrderOperations AS (
         SELECT UserId, CAST(SendDate AS DATE) AS ProcessDate, ordOp.Firm, COUNT(DISTINCT ClientId) AS TotalOrders
         FROM OP_UserActionGpsData ordOp WITH (NOLOCK)
         JOIN Clients CL ON CL.Firm = ordOp.Firm AND CL.TigerId = ordOp.ClientId
         WHERE ActionTypeId = 1
         GROUP BY UserId, ordOp.Firm, CAST(SendDate AS DATE)),

Invoices AS (
		    SELECT il.UserId, il.Firm, MIN(il.DocCreatedTime) AS MinInvoiceTime, il.ProcessDate, SUM(ilcx.Price*ilcx.Amount - ISNULL(ilcx.DiscountAmount,0)) AS TotalAmount  FROM OP_IncomingLog il
			JOIN OP_IncomingLogCommonExtension ilx ON il.Id = ilx.Id
			JOIN OP_IncomingLogCommonLineExtension ilcx ON il.Id = ilcx.Id
			JOIN OP_GeneralLog gl ON il.Id = gl.RequestId
			WHERE gl.ImportResult = 0 AND il.DocType IN (0, 4) 
			GROUP BY il.UserId, il.Firm, il.ProcessDate),

Routes AS (
			SELECT 
			Salesmen.Firm,
			Salesmen.TigerId as SalesmanId, 
			Salesmen.Name as SalesmanName, 
			Salesmen.Code as SalesmanCode,
			Date, 
			FORMAT(ISNULL(MIN(MMD.FirstVisitTime),'1900-01-01 00:00'),'HH:mm') AS FirstVisitTime,
			FORMAT(ISNULL(MAX(MMD.LastVisitTime),'2099-01-01 23:59'),'HH:mm') AS LastVisitTime,
			FORMAT(ISNULL(MIN(INV.MinInvoiceTime),'1900-01-01 00:00'),'HH:mm') AS FirstInvoiceTime,
			SUM(ISNULL(R.RouteClientCount, 0)) AS RouteClientCount,
            SUM(ISNULL(RCO.TotalOperations, 0)) AS VisitedRouteClientCount,
			SUM(ISNULL(NRCO.TotalOperations, 0)) AS VisitedNonRouteClientCount,
			SUM(ISNULL(OOP.TotalOrders, 0)) AS OrderClientCount,
			SUM(ISNULL(INV.TotalAmount, 0)) AS TotalAmount
			FROM
			Salesmen
			LEFT JOIN Route R ON Salesmen.UserId = R.UserId AND R.Firm = Salesmen.Firm
			LEFT JOIN RouteClientOperations RCO ON RCO.UserId = Salesmen.UserId and RCO.ProcessDate = r.Date and RCO.Firm = R.Firm
			LEFT JOIN NonRouteClientOperations NRCO ON NRCO.UserId = Salesmen.UserId and NRCO.ProcessDate = r.Date and NRCO.Firm = R.Firm
			LEFT JOIN OrderOperations OOP ON OOP.UserId = Salesmen.UserId and OOP.ProcessDate = r.Date and OOP.Firm = R.Firm
			LEFT JOIN MinMaxVisitTimes MMD ON MMD.UserId = Salesmen.UserId and MMD.ProcessDate = r.Date and MMD.Firm = R.Firm
			LEFT JOIN Invoices INV ON INV.UserId = Salesmen.UserId and INV.ProcessDate = r.Date and INV.Firm = R.Firm
			
			GROUP BY Salesmen.TigerId, Salesmen.Firm, Salesmen.Name, Salesmen.Code, R.Date
	     )
SELECT * FROM Routes
GO


