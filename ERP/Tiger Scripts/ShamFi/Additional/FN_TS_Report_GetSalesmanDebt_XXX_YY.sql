CREATE OR ALTER function [dbo].[FN_TS_Report_GetSalesmanDebt_XXX_YY]()
    RETURNS TABLE
        AS RETURN
            (
                WITH Clfline AS (
                    Select (CASE
                                WHEN SubString(CLCARD.SPECODE5, 1, 2) != 'AU' -- non combine, let's replace
                                    THEN (SELECT TOP 1 SALESMANREF
                                          FROM LG_XXX_SLSCLREL REL WITH (NOLOCK)
                                                   JOIN LOGODB.dbo.LG_SLSMAN MAN ON MAN.LOGICALREF = REL.SALESMANREF
                                          WHERE CLIENTREF = CLFLINE.CLIENTREF
                                            AND TRY_CONVERT(INT, CODE) IS NOT NULL
                                            AND SALESMANREF > 0)
                                ELSE CLFLINE.SALESMANREF END)                              AS SalesmanId,
                           CLFLINE.CLIENTREF                                               As ClientId,
                           (CASE WHEN CLFLINE.SIGN = 0 THEN 1 ELSE 0 END) * CLFLINE.AMOUNT AS Debit,
                           (CASE WHEN CLFLINE.SIGN = 1 THEN 1 ELSE 0 END) * CLFLINE.AMOUNT AS Credit
                    FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                             Inner Join LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                    WHERE CLFLINE.CANCELLED = 0
                ),
                     CreditData AS (
                         SELECT SalesmanId,
                                ClientId,
                                ISNULL(ROUND(SUM(Debit), 2), 0)  AS Debit,
                                ISNULL(ROUND(SUM(Credit), 2), 0) AS Credit
                         FROM Clfline
                         WHERE SalesmanId > 0
                         GROUP BY SalesmanId, ClientId)

                SELECT CreditData.SalesmanId,
                       CLCARD.LOGICALREF  As ClientId,
                       CLCARD.CODE        As ClientCode,
                       CLCARD.DEFINITION_ As ClientName,
                       ''                 As Edino,
                       CLCARD.CITY        AS City,
                       CLCARD.SPECODE     AS Specode,
                       162                As CurrencyType,
                       'AZN'              As CurrencyCode,
                       1                  AS OrderNo,
                       CreditData.Debit,
                       CreditData.Credit
                FROM CreditData WITH (NOLOCK)
                         Inner Join LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CreditData.ClientId = CLCARD.LOGICALREF

                WHERE ((CLCARD.ACTIVE = 0 AND (CreditData.Debit - CreditData.Credit <> 0)) OR
                       (CLCARD.ACTIVE = 1 AND (CreditData.Debit - CreditData.Credit >= 0.15)))
            )