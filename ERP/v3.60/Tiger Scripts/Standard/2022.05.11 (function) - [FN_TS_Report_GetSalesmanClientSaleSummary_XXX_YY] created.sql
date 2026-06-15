alter Function [dbo].[FN_TS_Report_GetSalesmanClientSaleSummary_XXX_YY](@salesmanId int, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (

-- Date: 28.04.2022 
-- Written by TayqaTech (Kanan Mammadov) for TayqaSale
-- The query returns the list of clients with sales, return and promo amounts for selected salesman

                WITH ORDERS AS (SELECT ORD.SALESMANREF AS SalesmanId,
                                       ORD.CLIENTREF   as ClientId,
                                       ORD.DATE_       as Date,
                                       BRANCH          as DivisionNr,
                                       SUM(NETTOTAL)   As OrderNetTotal
                                FROM LG_XXX_YY_ORFICHE ORD WITH (NOLOCK)
                                     
                                WHERE DATE_ BETWEEN @beginDate AND @endDate
                                  AND SALESMANREF = @salesmanId
                                GROUP BY ORD.SALESMANREF, ORD.CLIENTREF, ORD.DATE_, BRANCH),

                     SALEOPS AS (SELECT COALESCE(CLFLINE.CLIENTREF, ORDERS.ClientId)                                   AS ClientId,
                                        COALESCE(CLFLINE.DATE_, ORDERS.Date)                                           AS Date,
                                        COALESCE(CLFLINE.BRANCH, ORDERS.DivisionNr)                                    as DivisionNr,
                                        ROUND(ISNULL(ORDERS.OrderNetTotal, 0), 2)                                      AS OrderTotal,
                                        ROUND(SUM(IIF(TRCODE IN (37, 38), AMOUNT, 0)), 2)                              AS SalesTotal,
                                        ROUND(SUM(IIF(TRCODE IN (32, 33), AMOUNT, 0)), 2)                              AS ReturnTotal,
                                        ROUND(SUM(IIF(TRCODE IN (1), AMOUNT, 0)), 2)                                   AS CashIn,
                                        ROUND(ISNULL(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1))), 0), 2)                      AS DailyTotal,
                                        ROUND(ISNULL(SUM(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1))))
                                                         OVER (PARTITION BY CLFLINE.CLIENTREF ORDER BY CLFLINE.CLIENTREF, CLFLINE.DATE_
                                                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0), 2) AS CumilativeDebt
                                 FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                                          FULL OUTER JOIN ORDERS ON ORDERS.ClientId = CLFLINE.CLIENTREF AND ORDERS.Date = CLFLINE.DATE_
                                     AND ORDERS.DivisionNr = CLFLINE.BRANCH
                                 WHERE (CLFLINE.DATE_ BETWEEN @beginDate AND @endDate OR ORDERS.Date BETWEEN @beginDate AND @endDate)
                                   AND (SALESMANREF = @salesmanId OR ORDERS.SalesmanId = @salesmanId)
                                 GROUP BY CLFLINE.CLIENTREF, ORDERS.ClientId, ORDERS.Date, ORDERS.OrderNetTotal, DATE_, CLFLINE.BRANCH, ORDERS.DivisionNr),

                     DEBTS AS (SELECT COALESCE(SALEOPS.ClientId, OpenDebt.ClientId)     as ClientId,
                                      COALESCE(SALEOPS.Date, OpenDebt.Date)             as Date,
                                      COALESCE(SALEOPS.DivisionNr, OpenDebt.DivisionNr) as DivisionNr,
                                      ISNULL(OrderTotal, 0)                             as OrderTotal,
                                      ISNULL(SalesTotal, 0)                             as SalesTotal,
                                      ISNULL(ReturnTotal, 0)                            as ReturnTotal,
                                      ISNULL(CashIn, 0)                                 as CashIn,
                                      ISNULL(DailyTotal, 0)                             as DailyTotal,
                                      ISNULL(CumilativeDebt, 0)                         as CumilativeDebt,
                                      ISNULL(OpenDebt, 0) + ISNULL(CumilativeDebt, 0)   AS ClosingBalance
                               FROM SALEOPS
                                        FULL OUTER JOIN (SELECT CLFLINE.CLIENTREF                                                              as ClientId,
                                                                CLFLINE.BRANCH                                                                 as DivisionNr,
                                                                @beginDate                                                                     as Date,
                                                                ROUND(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1)) * IIF(DATE_ < @beginDate, 1, 0)), 2) as OpenDebt
                                                         FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                                                         WHERE CLFLINE.CLIENTREF > 0
                                                           AND CLFLINE.SALESMANREF = @salesmanId
                                                         GROUP BY CLFLINE.CLIENTREF, CLFLINE.BRANCH) OpenDebt on OpenDebt.ClientId = SALEOPS.ClientId
                                   AND OpenDebt.DivisionNr = SALEOPS.DivisionNr)

                SELECT CLCARD.LOGICALREF           AS ClientId,
                       CLCARD.CODE                 AS ClientCode,
                       CLCARD.DEFINITION_          AS ClientName,
                       DEBTS.Date                  AS Date,
                       DEBTS.CashIn                AS CashInAmount,
                       DEBTS.ReturnTotal           AS ReturnInvoiceAmount,
                       DEBTS.OrderTotal            AS OrderAmount,
                       ClosingBalance - DailyTotal AS OpenDebt,
                       ClosingBalance              AS TotalDebt,
                       DEBTS.SalesTotal            AS InvoicedAmount,
                       DIV.NR                      as DivisionNr,
                       DIV.NAME                    as DivisionName
                FROM DEBTS
                         JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = DEBTS.DivisionNr AND DIV.FIRMNR = CAST(XXX AS INT)
                         JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLCARD.LOGICALREF = DEBTS.ClientId
            )
go