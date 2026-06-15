ALTER Function [dbo].[FN_TS_Report_GetSalesmanSaleSummary_XXX_YY](@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                WITH ORDERS AS (SELECT SALESMANREF   as SalesmanId,
                                       BRANCH        as DivisionNr,
                                       ORD.DATE_     as Date,
                                       SUM(NETTOTAL) As OrderNetTotal
                                FROM LG_XXX_YY_ORFICHE ORD WITH (NOLOCK)
                                WHERE DATE_ BETWEEN @beginDate AND @endDate
                                GROUP BY SALESMANREF, ORD.DATE_, BRANCH),

                     SALEOPS AS (SELECT COALESCE(CLFLINE.SALESMANREF, ORDERS.SalesmanId)                    AS SalesmanId,
                                        COALESCE(CLFLINE.DATE_, ORDERS.Date)                                AS Date,
                                        COALESCE(CLFLINE.BRANCH, ORDERS.DivisionNr)                         as DivisionNr,
                                        ROUND(ISNULL(ORDERS.OrderNetTotal, 0), 2)                           AS OrderTotal,
                                        ROUND(SUM(IIF(TRCODE IN (37, 38), AMOUNT, 0)), 2)                   AS SalesTotal,
                                        ROUND(SUM(IIF(TRCODE IN (32, 33), AMOUNT, 0)), 2)                   AS ReturnTotal,
                                        ROUND(SUM(IIF(TRCODE IN (1), AMOUNT, 0)), 2)                        AS CashIn,
                                        ROUND(ISNULL(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1))), 0), 2)           AS DailyTotal,
                                        ROUND(SUM(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1))))
                                                  OVER (PARTITION BY SALESMANREF ORDER BY SALESMANREF, DATE_
                                                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS CumilativeDebt
                                 FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                                          FULL OUTER JOIN ORDERS ON ORDERS.SalesmanId = CLFLINE.SALESMANREF AND ORDERS.Date = CLFLINE.DATE_
                                     AND ORDERS.DivisionNr = CLFLINE.BRANCH
                                 WHERE CLFLINE.SALESMANREF > 0
                                   AND CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                                 GROUP BY CLFLINE.SALESMANREF, ORDERS.OrderNetTotal, CLFLINE.DATE_, CLFLINE.BRANCH, ORDERS.SalesmanId, ORDERS.Date, ORDERS.DivisionNr),

                     DEBTS AS (SELECT COALESCE(SALEOPS.SalesmanId, OpenDebt.SalesmanId) as SalesmanId,
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
                                        FULL OUTER JOIN (SELECT C.SALESMANREF                                                                  as SalesmanId,
                                                                C.BRANCH                                                                       as DivisionNr,
                                                                @beginDate                                                                     as Date,
                                                                ROUND(SUM(AMOUNT * (IIF(SIGN = 0, 1, -1)) * IIF(DATE_ < @beginDate, 1, 0)), 2) as OpenDebt
                                                         FROM LG_XXX_YY_CLFLINE C WITH (NOLOCK)
                                                         WHERE C.SALESMANREF > 0
                                                         GROUP BY C.SALESMANREF, C.BRANCH) OpenDebt on OpenDebt.SalesmanId = SALEOPS.SalesmanId AND
                                                                                                       SALEOPS.DivisionNr = OpenDebt.DivisionNr)

                SELECT SLSMAN.LOGICALREF           AS SalesmanId,
                       SLSMAN.CODE                 AS SalesmanCode,
                       SLSMAN.DEFINITION_          AS SalesmanName,
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
                         JOIN LG_SLSMAN SLSMAN WITH (NOLOCK) ON SLSMAN.FIRMNR = CAST(XXX AS INT) AND SLSMAN.LOGICALREF = DEBTS.SalesmanId
            )
