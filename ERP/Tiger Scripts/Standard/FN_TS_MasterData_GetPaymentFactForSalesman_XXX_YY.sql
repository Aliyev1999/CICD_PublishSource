CREATE Function [dbo].[FN_TS_MasterData_GetPaymentFactForSalesman_XXX_YY](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT SALESMANREF As SalesmanId, DATE_ AS Date, SUM (AMOUNT) AS Amount, 162 AS CurrencyType
FROM LG_XXX_YY_CLFLINE
WHERE TRCODE In (1,21) AND DATE_>=@beginDate AND DATE_<@endDate 
GROUP BY SALESMANREF, DATE_ 
)
GO
