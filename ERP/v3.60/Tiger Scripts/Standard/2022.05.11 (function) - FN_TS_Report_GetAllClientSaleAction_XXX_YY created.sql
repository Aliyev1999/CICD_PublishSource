alter Function [dbo].[FN_TS_Report_GetAllClientSaleAction_XXX_YY](@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (

-- Date: 28.04.2022 
-- Written by TayqaTech (Kanan Mammadov) for TayqaSale
-- The query returns the list of all clients / divisions with sales, return and balance amounts 

                With Actionlines AS (SELECT INVOICE.SOURCEINDEX                                                                                   AS ReturnWarehouse,
                                            CLFLINE.SALESMANREF                                                                                   AS SalesmanId,
                                            CLFLINE.CLIENTREF                                                                                     AS ClientId,
                                            DIV.NR                                                                                                AS DivisionNr,
                                            DIV.NAME                                                                                              AS DivisionName,
                                            IsNull(Round(Sum(AMOUNT * (case when CLFLINE.date_ < @beginDate then 1 else 0 end) *
                                                             (Case When CLFLINE.SIGN = 0 Then 1 Else -1 End)), 2), 0)
                                                                                                                                                  AS ClienBegtDebt,
                                            IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.SIGN = 0 Then 1 Else -1 End)), 2), 0)                    AS ClientDebt,
                                            IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (37, 38) Then 1 When CLFLINE.TRCODE In (32, 33) Then -1 End) *
                                                             (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)), 2), 0) AS NetSaleAmount,
                                            IsNull(Round(Sum(INVOICE.NETTOTAL), 2), 0)                                                            AS ReturnAmount,
                                            IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (1) Then 1 Else 0 End) *
                                                             (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)), 2), 0) AS CashAmount,
                                            IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (21) Then 1 Else 0 End) *
                                                             (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)), 2), 0) AS BankAmount
                                     FROM LG_XXX_YY_CLFLINE CLFLINE With (NoLock)
                                              INNER JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = CLFLINE.BRANCH AND DIV.FIRMNR = CAST(XXX AS INT)
                                              LEFT JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK)
                                                        ON (INVOICE.LOGICALREF = CLFLINE.SOURCEFREF AND CLFLINE.TRCODE IN (32, 33) AND INVOICE.CANCELLED = 0 AND
                                                            INVOICE.DATE_ Between @beginDate And @endDate)
                                     WHERE CLFLINE.CANCELLED = 0
                                     GROUP BY CLFLINE.CLIENTREF, INVOICE.SOURCEINDEX, CLFLINE.SALESMANREF, DIV.NR, DIV.NAME)

                Select CLIENTREL.SALESMANREF     AS SalesmanId,
                       CLCARD.CODE               AS ClientCode,
                       CLCARD.DEFINITION_        AS ClientName,
                       PCLCARD.EDINO             AS Edino,
                       Actionlines.BankAmount    AS BankAmount,
                       Actionlines.ClientId,
                       Actionlines.ReturnWarehouse,
                       Actionlines.ClientDebt,
                       Actionlines.ClienBegtDebt as InitialDebt,
                       Actionlines.ClientDebt    AS Debt,
                       Actionlines.NetSaleAmount,
                       Actionlines.ReturnAmount  AS ReturnAmount,
                       Actionlines.CashAmount,
                       'AZN'                     AS CurrencyCode,
                       Actionlines.BankAmount    AS BankPayment,
                       DivisionNr                as DivisionNr,
                       DivisionName              as DivisionName,
                       Actionlines.CashAmount    AS CashPayment
                From Actionlines With (NoLock)
                         Inner Join LG_XXX_SLSCLREL CLIENTREL With (NoLock) On CLIENTREL.CLIENTREF = Actionlines.ClientId
                    and Actionlines.SalesmanId = CLIENTREL.SALESMANREF
                         Inner Join LG_XXX_CLCARD CLCARD With (NoLock) On CLCARD.LOGICALREF = Actionlines.ClientId
                         Left Join LG_XXX_CLCARD PCLCARD With (NoLock) On PCLCARD.LOGICALREF = CLCARD.PARENTCLREF

            )
go