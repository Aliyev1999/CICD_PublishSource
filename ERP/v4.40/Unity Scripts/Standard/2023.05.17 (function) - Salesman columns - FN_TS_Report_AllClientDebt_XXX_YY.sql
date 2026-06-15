ALTER Function [dbo].[FN_TS_Report_GetAllClientDebt_XXX_YY]()
RETURNS TABLE
AS RETURN
(
WITH DebtData AS (select CLIENTREF,
                         SALESMANREF,
                         SUM(ISNULL((CASE  WHEN SIGN=0 THEN AMOUNT * (1 - SIGN) ELSE AMOUNT END), 0)) AS Debit,
                         SUM(ISNULL((CASE  WHEN SIGN=1 THEN AMOUNT * (SIGN) ELSE AMOUNT END), 0))     AS Credit
                  from LG_XXX_YY_CLFLINE CLFLINE
                  group by SALESMANREF, CLIENTREF)
SELECT SLSMAN.LOGICALREF as SalesmanId,
	   SLSMAN.DEFINITION_   AS SalesmanName,
       SLSMAN.CODE          AS SalesmanCode,
       CLCARD.LOGICALREF    AS ClientId,
       CLCARD.CODE          AS ClientCode,
       CLCARD.DEFINITION_   AS ClientName,
       PCARD.EDINO          AS Edino,
       DebtData.Debit       AS Debit,
       DebtData.Credit      AS Credit,
       CLCARD.CITY          AS City,
       CLCARD.SPECODE       AS Specode,
       162                  AS CurrencyType,
       'AZN'                As CurrencyCode
from DebtData WITH (NOLOCK)
         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON DebtData.CLIENTREF = CLCARD.LOGICALREF
         LEFT JOIN LG_XXX_CLCARD PCARD WITH (NOLOCK) ON CLCARD.PARENTCLREF = PCARD.LOGICALREF
         Inner join LG_XXX_SLSCLREL CLREL WITH(NOLOCK) On CLREL.CLIENTREF=CLCARD.LOGICALREF
		 INNER JOIN LG_SLSMAN SLSMAN WITH (NOLOCK) ON CLREL.SALESMANREF = SLSMAN.LOGICALREF



);
