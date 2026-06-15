ALTER Function [dbo].[FN_TS_Report_GetSalesmanClientItemSaleSummary_XXX_YY](@salesmanId int, @clientId int, @beginDate datetime, @endDate
    datetime)
    RETURNS TABLE
        AS RETURN
            (

-- Date: 28.04.2022 
-- Written by TayqaTech (Kanan Mammadov) for TayqaSale
-- The query returns the list of items with sales, return and promo amounts for selected salesman and client

                WITH ORDERS AS (SELECT LINE.STOCKREF     AS ItemId,
                                       LINE.DATE_        AS Date,
                                       LINE.BRANCH       AS DivisionNr,
                                       SUM(ISNULL(CASE
                                                      WHEN LINE.LINETYPE IN (1) THEN LINE.LINENET - LINE.LINENET * LINE.DISCPER / 100
                                                      WHEN LINE.LINETYPE IN (0, 6) THEN LINE.LINENET - ISNULL(DISCOUNTLINE.LINENET, 0) END, 0) +
                                           LINE.VATAMNT) AS OrderAmount
                                FROM LG_XXX_YY_ORFLINE LINE WITH (NOLOCK)
                                         LEFT JOIN LG_XXX_YY_ORFLINE DISCOUNTLINE WITH (NOLOCK)
                                                   ON (DISCOUNTLINE.ORDFICHEREF = LINE.ORDFICHEREF AND DISCOUNTLINE.LINETYPE = 2 AND
                                                       DISCOUNTLINE.GLOBTRANS = 0 AND LINE.LOGICALREF = DISCOUNTLINE.PARENTLNREF)
                                WHERE (LINE.LINETYPE in (0, 1, 6) OR (LINE.LINETYPE IN (2)
                                    AND LINE.GLOBTRANS = 1))
                                  AND (LINE.SALESMANREF = @salesmanId OR DISCOUNTLINE.SALESMANREF = @salesmanId)
                                  AND (LINE.CLIENTREF = @clientId OR DISCOUNTLINE.CLIENTREF = @clientId)
                                  AND LINE.DATE_ BETWEEN @beginDate AND @endDate
                                GROUP BY LINE.STOCKREF, LINE.DATE_, LINE.BRANCH),

                     INVOICES AS (SELECT LINE.STOCKREF                                                      AS ItemId,
                                         LINE.DATE_                                                         AS Date,
                                         INVOICE.BRANCH                                                     AS DivisionNr,
                                         ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) *
                                                   (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.VATMATRAH),
                                               2)                                                           AS GrossAmount,
                                         ROUND(SUM((IIF(LINE.TRCODE IN (2, 3), 1, 0)) * LINE.VATMATRAH), 2) AS ReturnAmount,
                                         ROUND(SUM((IIF(LINE.LINETYPE IN (1), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.VATMATRAH),
                                               2)                                                           AS PromoAmount

                                  FROM LG_XXX_YY_STLINE LINE WITH (NOLOCK)
                                           JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK) ON LINE.INVOICEREF = INVOICE.LOGICALREF

                                  WHERE LINE.CANCELLED = 0
                                    AND LINE.STATUS = 0
                                    AND LINE.LINETYPE IN (0, 1, 6)
                                    AND LINE.TRCODE IN (2, 3, 7, 8)
                                    AND LINE.DATE_ >= @beginDate
                                    AND LINE.DATE_ <= @endDate
                                    AND LINE.SALESMANREF = @salesmanId
                                    AND LINE.CLIENTREF = @clientId
                                  GROUP BY LINE.STOCKREF, LINE.DATE_, INVOICE.BRANCH)


                SELECT ITEMS.CODE                                       AS ItemCode,
                       ITEMS.NAME                                       AS ItemName,
                       ITEMS.LOGICALREF                                 AS ItemId,
                       COALESCE(ORDERS.Date, INVOICES.Date)             AS Date,
                       ISNULL(INVOICES.PromoAmount, 0)                  AS PromoAmount,
                       ISNULL(INVOICES.ReturnAmount, 0)                 AS ReturnInvoiceAmount,
                       ISNULL(ORDERS.OrderAmount, 0)                    AS OrderAmount,
                       ISNULL(INVOICES.GrossAmount, 0)                  AS InvoicedAmount,
                       COALESCE(ORDERS.DivisionNr, INVOICES.DivisionNr) as DivisionNr,
                       DIV.NAME                                         as DivisionName

                FROM ORDERS
                         FULL OUTER JOIN INVOICES ON ORDERS.ItemId = INVOICES.ItemId AND ORDERS.Date = INVOICES.Date AND ORDERS.DivisionNr = INVOICES.DivisionNr
                         JOIN L_CAPIDIV DIV WITH (NOLOCK) ON (DIV.NR = ORDERS.DivisionNr OR DIV.NR = INVOICES.DivisionNr) AND DIV.FIRMNR = CAST(XXX AS INT)
                         JOIN LG_XXX_ITEMS ITEMS WITH (NOLOCK) ON ITEMS.LOGICALREF = ORDERS.ItemId OR ITEMS.LOGICALREF = INVOICES.ItemId
            )
go