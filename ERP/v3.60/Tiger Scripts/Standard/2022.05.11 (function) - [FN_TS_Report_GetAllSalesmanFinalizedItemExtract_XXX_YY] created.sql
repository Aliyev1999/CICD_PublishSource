alter FUNCTION [dbo].[FN_TS_Report_GetAllSalesmanFinalizedItemExtract_XXX_YY](@beginDate DATETIME, @endDate DATETIME)
    RETURNS TABLE
        AS RETURN
            (

-- Date: 28.04.2022 
-- Written by TayqaTech (Kanan Mammadov) for TayqaSale
-- The query returns the list of items with sales, return and promo amounts 

                SELECT t.ItemCode,
                       t.ItemName,
                       t.ItemId,

                       t.GrossQuantity,
                       t.ReturnQuantity,
                       t.NetQuantity,
                       t.PromoQuantity,
                       t.SalesmanRef,

                       t.SalesmanCode,
                       t.SalesmanName,

                       t.GrossAmount,
                       t.ReturnAmount,
                       t.NetAmount,
                       t.PromoAmount,

                       DivisionNr,
                       DivisionName,

                       t.GrossQuantity * t.WEIGHT  GrossWeight,
                       t.ReturnQuantity * t.WEIGHT ReturnWeight,
                       t.NetQuantity * t.WEIGHT    NetWeight,
                       t.PromoQuantity * t.WEIGHT  PromoWeight,
                       'AZN' As                    CurrencyCode
                FROM (SELECT ITEMS.CODE                                                         AS ItemCode,
                             SLSMAN.DEFINITION_                                                 AS SalesmanName,
                             SLSMAN.CODE                                                        AS SalesmanCode,
                             ITEMS.NAME                                                         AS ItemName,
                             LINE.SALESMANREF                                                   AS SalesmanRef,
                             DIV.NR                                                             AS DivisionNr,
                             DIV.NAME                                                           AS DivisionName,
                             ITEMS.LOGICALREF
                                                                                                AS ItemId,
                             UNITS.GROSSWEIGHT                                                  AS WEIGHT,
                             ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.AMOUNT *
                                       ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                                   2)                                                           AS GrossQuantity,

                             ROUND(SUM((IIF(LINE.TRCODE IN (2, 3), 1, 0)) * LINE.AMOUNT *
                                       ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                                   2)                                                           AS ReturnQuantity,

                             ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) * LINE.AMOUNT *
                                       ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                                   2)                                                           AS NetQuantity,

                             ROUND(SUM((IIF(LINE.LINETYPE IN (1), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.AMOUNT *
                                       ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                                   2)                                                           AS PromoQuantity,

                             ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.VATMATRAH),
                                   2)                                                           AS GrossAmount,

                             ROUND(SUM((IIF(LINE.TRCODE IN (2, 3), 1, 0)) * LINE.VATMATRAH), 2) AS ReturnAmount,

                             ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) * LINE.VATMATRAH),
                                   2)                                                           AS NetAmount,

                             ROUND(SUM((IIF(LINE.LINETYPE IN (1), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.VATMATRAH),
                                   2)                                                           AS PromoAmount

                      FROM LG_XXX_YY_STLINE LINE WITH (NOLOCK)
                               INNER JOIN LG_XXX_ITEMS ITEMS WITH (NOLOCK) ON ITEMS.LOGICALREF = LINE.STOCKREF
                               INNER JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK) ON LINE.INVOICEREF = INVOICE.LOGICALREF
                               INNER JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = INVOICE.BRANCH AND DIV.FIRMNR = CAST(XXX AS INT)
                               INNER JOIN LG_XXX_ITMUNITA UNITS WITH (NOLOCK) ON UNITS.ITEMREF = LINE.STOCKREF AND UNITS.LINENR = 1
                               LEFT JOIN LG_SLSMAN SLSMAN on SLSMAN.logIcalref = LINE.salesmanref and SLSMAN.FIRMNR =  CAST(XXX AS INT)
                      WHERE LINE.CANCELLED = 0
                        AND LINE.STATUS = 0
                        AND LINE.LINETYPE IN (0, 1, 6)
                        AND LINE.TRCODE IN (2, 3, 7, 8)
                        AND LINE.DATE_ >= @beginDate
                        AND LINE.DATE_ <= @endDate
                      GROUP BY ITEMS.CODE, ITEMS.NAME, ITEMS.LOGICALREF, LINE.SALESMANREF, UNITS.GROSSWEIGHT, SLSMAN.CODE, SLSMAN.DEFINITION_, 
					  DIV.NR,DIV.NAME) t
            )
go