create Function [dbo].[FN_TS_MasterData_GetFinanceOperation_XXX_YY](@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT COALESCE(KSLINES.LOGICALREF, CLFLINE.LOGICALREF) AS ERPId,
                       CLFLINE.CLIENTREF              AS ClientId,
                       SLSCLREL.SALESMANREF           AS SalesmanId,
                       SOURCEFREF                     AS SourceId,
                       CLFLINE.DATE_                  AS Date,
                       CLFLINE.DEPARTMENT             AS Department,
                       CLFLINE.BRANCH                 AS Division,
                       CASE
                           WHEN CLFLINE.TRCODE IN (1) THEN 5   -- cash in
                           WHEN CLFLINE.TRCODE IN (21) THEN 51 --bank payment
                           ELSE CLFLINE.TRCODE END    AS Type,
                       CLFLINE.SPECODE                AS Specode,
                       CLFLINE.CYPHCODE               AS Specode2,
                       CLFLINE.DOCODE                 AS Docode,
                       CLFLINE.TRADINGGRP             AS Specode3,
                       CLFLINE.SIGN                   AS Sign,
                       CLFLINE.AMOUNT                 AS Amount,
                       CLFLINE.CANCELLED              AS IsCancelled,
                       CLFLINE.CAPIBLOCK_CREADEDDATE  AS CreatedDate,
                       CLFLINE.CAPIBLOCK_MODIFIEDDATE AS ModifiedDate,
                       162                            as CurrencyType
                FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         LEFT JOIN LG_XXX_YY_KSLINES KSLINES WITH (NOLOCK) ON KSLINES.LOGICALREF = CLFLINE.SOURCEFREF AND KSLINES.TRCODE = 11
                         LEFT JOIN LG_XXX_SLSCLREL SLSCLREL WITH (NOLOCK) ON SLSCLREL.CLIENTREF = CLFLINE.CLIENTREF
                WHERE CLFLINE.TRCODE IN (1, 21)
                  AND ((CLFLINE.CAPIBLOCK_CREADEDDATE >= @beginDate AND CLFLINE.CAPIBLOCK_CREADEDDATE <= @endDate)
                    OR (CLFLINE.CAPIBLOCK_MODIFIEDDATE >= @beginDate AND CLFLINE.CAPIBLOCK_MODIFIEDDATE <= @endDate))
            )



