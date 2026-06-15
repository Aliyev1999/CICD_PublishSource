create Function [dbo].[FN_TS_MasterData_GetCurrency]()
RETURNS TABLE
AS RETURN
(
SELECT FIRMNR AS Firm, CURTYPE As CurrencyType, CURCODE AS CurrencyCode, CURNAME AS CurrencyName FROM L_CURRENCYLIST WITH (NOLOCK)
);

GO
