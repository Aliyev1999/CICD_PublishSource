CREATE Function [dbo].[FN_TS_MasterData_GetSaleRoute_XXX]()
RETURNS TABLE
AS RETURN
(
with route as (
SELECT R.SALESMANREF as SalesmanId,
       RT.CLIENTREF as ClientId,
       R.STATUS as Status,
	   1 AS ClientOrderNo,
       DATEADD(DAY, -6, DATEADD(DAY, CAST(SUBSTRING(CODE, 2, 1) AS INT) - 1,
                                DATEADD(dd, -(DATEPART(WEEKDAY, CURRENT_TIMESTAMP) - 1),
                                        DATEADD(dd, DATEDIFF(dd, 0, CURRENT_TIMESTAMP), 0)))) AS RouteDate
FROM LG_XXX_ROUTE R WITH (NOLOCK)
         INNER JOIN LG_XXX_ROUTETRS RT WITH (NOLOCK) on RT.ROUTEREF = R.LOGICALREF
WHERE SUBSTRING(CODE, 4, 1) IN (1, 2)
  AND SUBSTRING(CODE, 4, 1) = (DATEPART(WW, CURRENT_TIMESTAMP) % 2) + 1

UNION ALL

----------------------------------- HAZIRKI HEFTE -----------------------------------
SELECT R.SALESMANREF as SalesmanId,
       RT.CLIENTREF as ClientId,
       R.STATUS as Status,
	   1 AS ClientOrderNo,
       DATEADD(DAY, CAST(SUBSTRING(CODE, 2, 1) AS INT),
               DATEADD(dd, -(DATEPART(WEEKDAY, CURRENT_TIMESTAMP) - 1),
                       DATEADD(dd, DATEDIFF(dd, 0, CURRENT_TIMESTAMP), 0))) AS RouteDate
FROM LG_XXX_ROUTE R WITH (NOLOCK)
         INNER JOIN LG_XXX_ROUTETRS RT WITH (NOLOCK) on RT.ROUTEREF = R.LOGICALREF
WHERE SUBSTRING(CODE, 4, 1) IN (1, 2)
  AND (
      SUBSTRING(CODE, 4, 1) = (DATEPART(WW, CURRENT_TIMESTAMP) % 2)
   OR SUBSTRING(CODE, 4, 1) = (DATEPART(WW, CURRENT_TIMESTAMP) % 2)  + 2 )
UNION ALL

----------------------------------- SONRAKI HEFTE -----------------------------------
SELECT R.SALESMANREF as SalesmanId,
       RT.CLIENTREF as ClientId,
       R.STATUS as Status,
	   1 AS ClientOrderNo,
       DATEADD(DAY, +8, DATEADD(DAY, CAST(SUBSTRING(CODE, 2, 1) AS INT) - 1,
                                DATEADD(dd, -(DATEPART(WEEKDAY, CURRENT_TIMESTAMP) - 1),
                                        DATEADD(dd, DATEDIFF(dd, 0, CURRENT_TIMESTAMP), 0)))) AS RouteDate
FROM LG_XXX_ROUTE R WITH (NOLOCK)
         INNER JOIN LG_XXX_ROUTETRS RT WITH (NOLOCK) on RT.ROUTEREF = R.LOGICALREF
WHERE SUBSTRING(CODE, 4, 1) IN (1, 2)
  AND SUBSTRING(CODE, 4, 1) = (DATEPART(WW, CURRENT_TIMESTAMP) % 2) + 1)

  select SalesmanId, ClientId, Status, ClientOrderNo, RouteDate from route
  where CAST(RouteDate AS DATE) >= CAST(GETDATE() AS DATE)
);