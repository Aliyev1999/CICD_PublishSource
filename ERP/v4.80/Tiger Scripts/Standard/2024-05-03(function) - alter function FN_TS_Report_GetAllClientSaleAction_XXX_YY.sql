
ALTER Function [dbo].[FN_TS_Report_GetAllClientSaleAction_XXX_YY](@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                With Actionlines AS (SELECT INVOICE.SOURCEINDEX                                                                AS ReturnWarehouse,
                                            CLIENTREL.SALESMANREF                                                              AS SalesmanId,
                                            CLFLINE.CLIENTREF                                                                  AS ClientId,
                                            DIV.NR                                                                             AS DivisionNr,
                                            DIV.NAME                                                                           AS DivisionName,
                                            IsNull(Round(Sum(AMOUNT * (case when CLFLINE.date_ < @beginDate then 1 else 0 end) *
                                                             (Case When CLFLINE.SIGN = 0 Then 1 Else -1 End)), 4),
                                                   0)                                                                          AS ClienBegtDebt,
                                            IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.SIGN = 0 Then 1 Else -1 End)), 4), 0) AS ClientDebt,
                                            IsNull(Round(Sum(AMOUNT *
                                                             (Case When CLFLINE.TRCODE In (37, 38) Then 1 When CLFLINE.TRCODE In (32, 33) Then -1 End) *
                                                             (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)), 4),
                                                   0)                                                                          AS NetSaleAmount,
                                            Round(Sum(INVOICE.NETTOTAL), 2)                                                    AS ReturnAmount,
                                            Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (1) Then 1 Else 0 End) *
                                                      (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),
                                                  4)                                                                           AS CashAmount,
                                            Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (20) Then 1 Else 0 End) *
                                                      (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),
                                                  4)                                                                           AS BankAmount
                                     FROM LG_XXX_YY_CLFLINE CLFLINE With (NoLock)
                                              INNER JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = CLFLINE.BRANCH AND DIV.FIRMNR = CAST(XXX AS INT)
                                              Inner Join LG_XXX_SLSCLREL CLIENTREL With (NoLock) On CLIENTREL.CLIENTREF = CLFLINE.CLIENTREF
                                              LEFT JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK)
                                                        ON (INVOICE.LOGICALREF = CLFLINE.SOURCEFREF AND CLFLINE.TRCODE IN (32, 33) AND INVOICE.CANCELLED = 0 AND
                                                            INVOICE.DATE_ Between @beginDate And @endDate)
                                     WHERE CLFLINE.CANCELLED = 0
                                     GROUP BY CLFLINE.CLIENTREF, INVOICE.SOURCEINDEX, CLIENTREL.SALESMANREF, DIV.NR, DIV.NAME)

                Select Actionlines.SalesmanId			  AS SalesmanId,
                       CLCARD.CODE                        AS ClientCode,
                       CLCARD.DEFINITION_                 AS ClientName,
                       PCLCARD.EDINO                      AS Edino,
                       Actionlines.BankAmount             AS BankAmount,
                       Actionlines.ClientId               AS ClientId,
                       Actionlines.ReturnWarehouse        AS ReturnWarehouse,
                       Actionlines.ClientDebt             as ClientDebt,
                       Actionlines.ClienBegtDebt          AS InitialDebt,
                       Actionlines.ClientDebt             AS Debt,
                       Actionlines.NetSaleAmount          AS NetSaleAmount,
                       Actionlines.ReturnAmount           AS ReturnAmount,
                       Actionlines.CashAmount             AS CashAmount,
                       'AZN'							  AS CurrencyCode,
                       Actionlines.BankAmount             AS BankPayment,
                       DivisionNr                         AS DivisionNr,
                       DivisionName                       AS DivisionName,
                       Actionlines.CashAmount             AS CashPayment
                From Actionlines With (NoLock)
                         Inner Join LG_XXX_CLCARD CLCARD With (NoLock) On CLCARD.LOGICALREF = Actionlines.ClientId
                         Left Join LG_XXX_CLCARD PCLCARD With (NoLock) On PCLCARD.LOGICALREF = CLCARD.PARENTCLREF

            )