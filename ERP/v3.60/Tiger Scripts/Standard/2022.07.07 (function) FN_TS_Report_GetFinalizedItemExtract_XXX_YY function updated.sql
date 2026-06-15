
ALTER FUNCTION [dbo].[FN_TS_Report_GetFinalizedItemExtract_XXX_YY](@clientId INT, @beginDate DATETIME, @endDate DATETIME)
    RETURNS TABLE
        AS RETURN
            (
                SELECT t.ItemCode, t.ItemName, t.GrossQuantity, t.ReturnQuantity, t.NetQuantity, t.PromoQuantity, t.ItemId,
                       -- will be deprecated
                       t.GrossQuantity AS GrossAmount, t.ReturnQuantity ReturnAmount, t.NetQuantity NetAmount, t.PromoQuantity PromoAmount, 'AZN' As CurrencyCode
                FROM (
                         SELECT ITEMS.CODE AS ItemCode, ITEMS.NAME AS ItemName, ITEMS.LOGICALREF AS ItemId,
                                ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.AMOUNT *
                                          ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))), 2) AS GrossQuantity,
                                ROUND(SUM((IIF(LINE.TRCODE IN (2, 3), 1, 0)) * LINE.AMOUNT *
                                          ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))), 2) AS ReturnQuantity,
                                ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) * LINE.AMOUNT *
                                          ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))), 2) AS NetQuantity,
                                ROUND(SUM((IIF(LINE.LINETYPE IN (1), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) * LINE.AMOUNT *
                                          ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) / (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))), 2) AS PromoQuantity
                         FROM LG_XXX_YY_STLINE LINE WITH (NOLOCK)
                                  INNER JOIN LG_XXX_ITEMS ITEMS WITH (NOLOCK) ON ITEMS.LOGICALREF = LINE.STOCKREF
                                  INNER JOIN LG_XXX_CLCARD CL WITH (NOLOCK) ON CL.LOGICALREF = LINE.CLIENTREF
                                  INNER JOIN LG_XXX_ITMUNITA mun WITH (NOLOCK)
                                             ON mun.ITEMREF = LINE.STOCKREF AND mun.LINENR = (IIF(ITEMS.CARDTYPE = 2, 1, 2))
                         WHERE LINE.CANCELLED = 0
                           AND LINE.STATUS = 0
                           AND LINE.LINETYPE IN (0, 1, 6)
                           AND LINE.TRCODE IN (2, 3, 7, 8)
                           AND LINE.DATE_ >= @beginDate
                           AND LINE.DATE_ <= @endDate
                           AND CL.LOGICALREF = @clientId
                         GROUP BY ITEMS.CODE, ITEMS.NAME, ITEMS.LOGICALREF) t
            )
