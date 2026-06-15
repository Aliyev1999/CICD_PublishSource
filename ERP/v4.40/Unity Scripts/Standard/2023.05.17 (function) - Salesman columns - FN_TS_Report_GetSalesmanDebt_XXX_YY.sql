			
ALTER Function [dbo].[FN_TS_Report_GetSalesmanDebt_XXX_YY]()
RETURNS TABLE
AS RETURN
(
Select SLSMAN.LOGICALREF as SalesmanId,
	   SLSMAN.DEFINITION_   AS SalesmanName,
       SLSMAN.CODE          AS SalesmanCode,
       CLCARD.LOGICALREF    As ClientId,
       CLCARD.CODE          As ClientCode,
       CLCARD.DEFINITION_   As ClientName,
       PCARD.EDINO          As Edino,
       GNTOTCL.DEBIT        As Debit,
       GNTOTCL.CREDIT       As Credit,
       CLCARD.CITY          AS City,
       CLCARD.SPECODE       AS Specode,
       162                  As CurrencyType,
       'AZN'                As CurrencyCode,
       1                    AS OrderNo
FROM LG_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
         Inner Join LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON GNTOTCL.CARDREF = CLCARD.LOGICALREF
         Left Join LG_XXX_CLCARD PCARD WITH (NOLOCK) ON CLCARD.PARENTCLREF = PCARD.LOGICALREF
         Inner join LG_XXX_SLSCLREL CLREL WITH(NOLOCK) On CLREL.CLIENTREF=CLCARD.LOGICALREF
		 INNER JOIN LG_SLSMAN SLSMAN WITH (NOLOCK) ON CLREL.SALESMANREF = SLSMAN.LOGICALREF
Where GNTOTCL.TOTTYP = 1 
);
