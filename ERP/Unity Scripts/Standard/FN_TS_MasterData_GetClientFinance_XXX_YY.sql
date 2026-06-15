create   function [dbo].[FN_TS_MasterData_GetClientFinance_XXX_YY](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT Client.ClientId AS ClientId, CLRNUMS.ACCRISKLIMIT AS AccRiskLimit, CLRNUMS.MYCSRISKLIMIT AS MyCsRiskLimit, CLRNUMS.CSTCSRISKLIMIT AS CsTcsRiskLimit, 
0 AS CsTcsCiroRiskLimit, CLRNUMS.DESPRISKLIMIT AS DespRiskLimit, 0 AS DespRiskLimitSug, CLRNUMS.ORDRISKLIMIT AS OrdRiskLimit, 
CLRNUMS.ORDRISKLIMITSUGG AS OrdRiskLimitSug, RISK.RISKBALANCED AS RiskBalanced, RISK.RISKTOTAL AS RiskTotal
FROM FN_TS_MasterData_GetAllClient_XXX() Client 
LEFT JOIN LG_XXX_YY_CLRNUMS CLRNUMS WITH (NOLOCK) ON CLRNUMS.CLCARDREF = Client.ClientId 
LEFT JOIN LG_XXX_YY_CLCOLLATRLRISK RISK WITH (NOLOCK) ON RISK.CLCARDREF = Client.ClientId 
WHERE ((Client.CreatedDate >=@beginDate AND Client.CreatedDate <=@endDate ) 
OR (Client.ModifiedDate>=@beginDate AND Client.ModifiedDate<=@endDate)));
GO
