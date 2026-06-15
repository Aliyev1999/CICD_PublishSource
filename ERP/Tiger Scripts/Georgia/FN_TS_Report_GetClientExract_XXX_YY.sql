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
                                                    WHEN CLFLINE.STATUS = 1 THEN N'Önəri'
                                                    WHEN CLFLINE.STATUS = 0 THEN N'Gerçək' END
                           ELSE CLFLINE.LINEEXP END                              AS LineDesc,
                       CLFLINE.DOCODE                                            AS Docode,
                       MAN.LOGICALREF                                            As SalesmanId,
                       MAN.CODE                                                  As SalesmanCode,
                       MAN.DEFINITION_                                           As SalesmanName,
                       CASE WHEN CLFLINE.SIGN = 0 THEN CLFLINE.AMOUNT ELSE 0 END AS Debit,
                       CASE WHEN CLFLINE.SIGN = 1 THEN CLFLINE.AMOUNT ELSE 0 END AS Credit,
                       CLFLINE.AMOUNT                                            AS Amount,
                       'GEL'                                                     As CurrencyCode
                FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         LEFT JOIN LG_XXX_CLCARD PCARD WITH (NOLOCK) ON PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF
                WHERE CLFLINE.CANCELLED = 0
                  AND CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                  AND CLCARD.LOGICALREF = @clientId
                  -- AND CLFLINE.STATUS = 0 -- Comment halinda gercek ve oneri statusunda olan emeliyyatlari getirir

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
                                                    WHEN CLFLINE.STATUS = 1 THEN N'Önəri'
                                                    WHEN CLFLINE.STATUS = 0 THEN N'Gerçək' END
                           ELSE CLFLINE.LINEEXP END                              AS LineDesc,
                       CLFLINE.DOCODE                                            AS Docode,
                       MAN.LOGICALREF                                            As SalesmanId,
                       MAN.CODE                                                  As SalesmanCode,
                       MAN.DEFINITION_                                           As SalesmanName,
                       CASE WHEN CLFLINE.SIGN = 0 THEN CLFLINE.AMOUNT ELSE 0 END AS Debit,
                       CASE WHEN CLFLINE.SIGN = 1 THEN CLFLINE.AMOUNT ELSE 0 END AS Credit,
                       CLFLINE.AMOUNT                                            AS Amount,
                       'GEL'                                                     As CurrencyCode
                FROM GEO2019.dbo.LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN GEO2019.dbo.LG_XXX_CLCARD CLCARD WITH (NOLOCK)
                                    ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         LEFT JOIN GEO2019.dbo.LG_XXX_CLCARD PCARD WITH (NOLOCK)
                                   ON PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN GEO2019.dbo.LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF
                WHERE CLFLINE.CANCELLED = 0
                  AND CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                  AND CLCARD.LOGICALREF = @clientId
                -- AND CLFLINE.STATUS = 0 -- Comment halinda gercek ve oneri statusunda olan emeliyyatlari getirir
            );