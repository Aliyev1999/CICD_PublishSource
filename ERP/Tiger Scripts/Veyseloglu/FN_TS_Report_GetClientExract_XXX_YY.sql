ALTER Function [dbo].[FN_TS_Report_GetClientExract_XXX_YY](@clientId int, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT CLFLINE.SOURCEFREF                                        AS FicheId,
                       CLFLINE.TRCODE                                            AS Trcode,
                       CLFLINE.DATE_                                             AS FicheDate,
                       ISNULL(PCARD.EDINO, '')                                   AS Edino,
                       CLCARD.CODE                                               AS ClientCode,
                       CLCARD.DEFINITION_                                        As ClientName,
                       CLFLINE.TRANNO                                            AS FicheNo,
                       CASE
                           WHEN TRCODE = 1 THEN CASE
                                                    WHEN CLFLINE.STATUS = 1
                                                        THEN CONCAT(N'Önəri - ', ISNULL(CLFLINE.DOCODE, N'Boşluq'))
                                                    WHEN CLFLINE.STATUS = 0
                                                        THEN CONCAT(N'Gerçək - ', ISNULL(CLFLINE.DOCODE, N'Boşluq')) END
                           ELSE CLFLINE.LINEEXP END                              AS LineDesc,
                       CLFLINE.DOCODE                                            AS Docode,
                       MAN.LOGICALREF                                            As SalesmanId,
                       MAN.CODE                                                  As SalesmanCode,
                       MAN.DEFINITION_                                           As SalesmanName,
                       CASE WHEN CLFLINE.SIGN = 0 THEN CLFLINE.AMOUNT ELSE 0 END AS Debit,
                       CASE WHEN CLFLINE.SIGN = 1 THEN CLFLINE.AMOUNT ELSE 0 END AS Credit,
                       --'AZN'                                                     AS CurrencyCode --  -- 3.0.0 versiyasindan etibaren bu sutun da elave olmalidir
                       CLFLINE.AMOUNT                                            AS Amount
                FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         LEFT JOIN LG_XXX_CLCARD PCARD WITH (NOLOCK) ON PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF
                WHERE CLFLINE.CANCELLED = 0
                  AND CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                  AND CLCARD.LOGICALREF = @clientId
                -- AND CLFLINE.STATUS = 0 -- Comment olundugu halda hem gercek, hem oneri statusunda olan emeliyyatlari getirir

                UNION

                SELECT CLFLINE.SOURCEFREF                                        AS FicheId,
                       CLFLINE.TRCODE                                            AS Trcode,
                       CLFLINE.DATE_                                             AS FicheDate,
                       ISNULL(PCARD.EDINO, '')                                   AS Edino,
                       CLCARD.CODE                                               AS ClientCode,
                       CLCARD.DEFINITION_                                        As ClientName,
                       CLFLINE.TRANNO                                            AS FicheNo,
                       CASE
                           WHEN TRCODE = 1 THEN CASE
                                                    WHEN CLFLINE.STATUS = 1
                                                        THEN CONCAT(N'Önəri - ', ISNULL(CLFLINE.DOCODE, N'Boşluq'))
                                                    WHEN CLFLINE.STATUS = 0
                                                        THEN CONCAT(N'Gerçək - ', ISNULL(CLFLINE.DOCODE, N'Boşluq')) END
                           ELSE CLFLINE.LINEEXP END                              AS LineDesc,
                       CLFLINE.DOCODE                                            AS Docode,
                       MAN.LOGICALREF                                            As SalesmanId,
                       MAN.CODE                                                  As SalesmanCode,
                       MAN.DEFINITION_                                           As SalesmanName,
                       CASE WHEN CLFLINE.SIGN = 0 THEN CLFLINE.AMOUNT ELSE 0 END AS Debit,
                       CASE WHEN CLFLINE.SIGN = 1 THEN CLFLINE.AMOUNT ELSE 0 END AS Credit,
                       --'AZN'                                                     AS CurrencyCode -- 3.0.0 versiyasindan etibaren bu sutun da elave olmalidir
                       CLFLINE.AMOUNT                                            AS Amount
                FROM TIGER2020.dbo.LG_151_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN TIGER2020.dbo.LG_151_CLCARD CLCARD WITH (NOLOCK)
                                    ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         LEFT JOIN TIGER2020.dbo.LG_151_CLCARD PCARD WITH (NOLOCK)
                                   ON PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN TIGER2020.dbo.LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF
                WHERE CLFLINE.CANCELLED = 0
                  AND CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                  AND CLCARD.LOGICALREF = @clientId
                -- AND CLFLINE.STATUS = 0 -- Comment olundugu halda hem gercek, hem oneri statusunda olan emeliyyatlari getirir
            );