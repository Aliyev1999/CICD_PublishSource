create Function [dbo].[FN_TS_MasterData_GetPaymentFactForSalesmanClient_XXX_YY](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT SALESMANREF As SalesmanId, CLIENTREF AS ClientId, DATE_ AS Date, SUM (AMOUNT) AS Amount, 162 AS CurrencyType
FROM LG_XXX_YY_CLFLINE
WHERE TRCODE In (1,21) AND DATE_>=@beginDate AND DATE_<@endDate 
GROUP BY SALESMANREF, CLIENTREF, DATE_ 
)
GO
