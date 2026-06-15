CREATE  Function FN_TS_Report_GetItemProfitData_XXX_YY(@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT SLSMAN.CODE                                                                AS SalesmanCode,
                       SLSMAN.DEFINITION_                                                         AS SalesmanName,
                       ITEMS.NAME                                                                 AS ItemName,
                       ITEMS.CODE                                                                 AS ItemCode,
                       ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, 0)) *
                                 LINE.AMOUNT *
                                 ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) /
                                  (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                             2)                                                                   AS GrossQuantity,
                       ROUND(SUM((IIF(LINE.TRCODE IN (2, 3), 1, 0)) * LINE.AMOUNT *
                                 ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) /
                                  (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                             2)                                                                   AS ReturnQuantity,
                       ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) *
                                 LINE.AMOUNT *
                                 ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) /
                                  (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1)))),
                             2)                                                                   AS NetQuantity,
                       ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) *
                                 LINE.AMOUNT *
                                 ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) /
                                  (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1))) * LINE.PRICE), 2)       AS NetAmount,
                       ROUND(SUM((IIF(LINE.LINETYPE IN (0, 6), 1, 0)) * (IIF(LINE.TRCODE IN (7, 8), 1, -1)) *
                                 LINE.AMOUNT *
                                 ((IIF(LINE.UINFO2 = 0, 1, LINE.UINFO2)) /
                                  (IIF(LINE.UINFO1 = 0, 1, LINE.UINFO1))) * LINE.PRICE), 2) * 0.1 AS IncomeAmount

                FROM LG_XXX_YY_STLINE LINE WITH (NOLOCK)
                         INNER JOIN LG_SLSMAN SLSMAN WITH (NOLOCK)
                                    ON SLSMAN.LOGICALREF = LINE.SALESMANREF 
                         INNER JOIN LG_XXX_ITEMS ITEMS WITH (NOLOCK) ON ITEMS.LOGICALREF = LINE.STOCKREF
                WHERE LINE.CANCELLED = 0
                  AND LINE.STATUS = 0
                  AND LINE.LINETYPE IN (0, 1, 6)
                  AND LINE.TRCODE IN (2, 3, 7, 8)
                  AND LINE.DATE_ >= @beginDate
                  AND LINE.DATE_ <= @endDate
                GROUP BY SLSMAN.CODE, SLSMAN.DEFINITION_, ITEMS.NAME, ITEMS.CODE
            )