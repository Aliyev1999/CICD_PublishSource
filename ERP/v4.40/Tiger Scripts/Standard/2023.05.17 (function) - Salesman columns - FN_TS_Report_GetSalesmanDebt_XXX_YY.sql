ALTER Function [dbo].[FN_TS_Report_GetSalesmanDebt_XXX_YY]()
    RETURNS TABLE
        AS RETURN
            (
                Select DISTINCT SLSCLREL.SALESMANREF As SalesmanId,
                                SLSMAN.DEFINITION_   as SalesmanName,
                                SLSMAN.CODE          as SalesmanCode,
                                CLCARD.LOGICALREF    As ClientId,
                                CLCARD.CODE          As ClientCode,
                                CLCARD.DEFINITION_   As ClientName,
                                PCARD.EDINO          As Edino,
                                GNTOTCL.DEBIT        As Debit,
                                GNTOTCL.CREDIT       As Credit,
                                CLCARD.CITY          AS City,
                                DIV.NAME             AS Specode,
                                162                  As CurrencyType,
                                'AZN'                As CurrencyCode,
                                1                    AS OrderNo
                FROM LV_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
                         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON GNTOTCL.CARDREF = CLCARD.LOGICALREF
                         LEFT JOIN LG_XXX_CLCARD PCARD WITH (NOLOCK) ON CLCARD.PARENTCLREF = PCARD.LOGICALREF
                         INNER JOIN LG_XXX_SLSCLREL SLSCLREL WITH (NOLOCK) ON (SLSCLREL.CLIENTREF = GNTOTCL.CARDREF)
                         LEFT JOIN LG_SLSMAN SLSMAN with (Nolock) on (SLSCLREL.SALESMANREF = SLSMAN.LOGICALREF) AND SLSMAN.FIRMNR = CAST(XXX AS INT)
                         INNER JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = GNTOTCL.BRANCH and DIV.FIRMNR = CAST(XXX AS INT)
                Where GNTOTCL.TOTTYP = 1
            )