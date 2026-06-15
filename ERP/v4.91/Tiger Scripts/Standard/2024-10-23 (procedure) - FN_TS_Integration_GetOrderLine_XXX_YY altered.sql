alter function dbo.FN_TS_Integration_GetOrderLine_XXX_YY(@orderId int)
    RETURNS TABLE
        AS RETURN(SELECT LINE.ORDFICHEREF                                                                                           AS OrdRef,
                         LINE.LOGICALREF                                                                                            AS LineRef,
                         (CASE WHEN LINE.LINETYPE IN (0, 6) THEN 0 WHEN LINE.LINETYPE = 1 THEN 1 WHEN LINE.LINETYPE = 2 THEN 2 END) AS LineType,
                         LINE.STOCKREF                                                                                              AS ItemId,
                         UNITLINE.LOGICALREF                                                                                        AS ItemUnitId,
                         UNITLINE.CODE                                                                                              AS ItemUnitCode,
                         LINE.AMOUNT                                                                                                AS Quantity,
                         LINE.PRICE                                                                                                 AS Price,
                         (CASE
                              WHEN LINE.LINETYPE IN (1, 2) THEN LINE.DISCPER
                              ELSE ISNULL(LINE.DISTDISC * 100 / (case when LINE.TOTAL = 0 then 1 else LINE.TOTAL end), 0) END)      AS DiscountPercent,
                         ISNULL(CASE WHEN LINE.LINETYPE IN (1, 2) THEN LINE.LINENET ELSE LINE.DISTDISC END, 0)                      AS DiscountAmount,
                         ISNULL(CASE WHEN LINE.LINETYPE IN (1) THEN LINE.LINENET - LINE.LINENET * LINE.DISCPER / 100 WHEN LINE.LINETYPE IN (0, 6) THEN LINE.VATMATRAH END,
                                0)                                                                                                  AS NetTotal,
                         LINE.VATAMNT                                                                                               AS VatAmount,
                         LINE.VAT                                                                                                   AS Vat,
                         LINE.VATINC                                                                                                AS VatInc,
                         ''                                                                                                         as ResultDesc
                  FROM LG_XXX_YY_ORFLINE LINE WITH (NOLOCK)
                           LEFT JOIN LG_XXX_UNITSETL UNITLINE WITH (NOLOCK) ON UNITLINE.LOGICALREF = LINE.UOMREF
                  WHERE (LINE.LINETYPE in (0, 1, 6) OR (LINE.LINETYPE IN (2) AND LINE.GLOBTRANS = 1))
                    AND LINE.ORDFICHEREF = @orderId);
go