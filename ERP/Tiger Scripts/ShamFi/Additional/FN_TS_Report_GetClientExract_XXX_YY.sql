ALTER function [dbo].[FN_TS_Report_GetClientExract_XXX_YY](@clientId int, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT CLFLINE.SOURCEFREF                                                                                                  AS FicheId,
                       CLFLINE.TRCODE                                                                                                      AS Trcode,
                       CLFLINE.DATE_                                                                                                       AS FicheDate,
                       ISNULL(PCARD.EDINO, '')                                                                                             AS Edino,
                       CLCARD.CODE                                                                                                         AS ClientCode,
                       CLCARD.DEFINITION_                                                                                                  As ClientName,
                       CLFLINE.TRANNO                                                                                                      AS FicheNo,
                       CASE
                           WHEN TRCODE = 1 THEN CASE
                                                    WHEN CLFLINE.STATUS = 1
                                                        THEN CONCAT(N'Önəri ', ISNULL(CLFLINE.DOCODE, N'Boşluq'))
                                                    WHEN CLFLINE.STATUS = 0
                                                        THEN CONCAT(N'Gerçək ', ISNULL(CLFLINE.DOCODE, N'Boşluq')) END
                           WHEN TRCODE = 33 THEN CASE
                                                     WHEN CLFLINE.CANCELLED = 1 THEN N'Gözləmədə'
                                                     ELSE N'Tamamlanmış' END
                           ELSE CLFLINE.LINEEXP END                                                                                        AS LineDesc,
                       CLFLINE.DOCODE                                                                                                      AS Docode,

                       CASE
                           WHEN SubString(CLCARD.SPECODE5, 1, 2) = 'AU' THEN MAN.LOGICALREF -- if combined 
                           ELSE LAST_VALUE(MAN.LOGICALREF)
                                           OVER (ORDER BY CLFLINE.DATE_ ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) END AS SalesmanId,
                       CASE
                           WHEN SubString(CLCARD.SPECODE5, 1, 2) = 'AU' THEN MAN.CODE -- if combined 
                           ELSE LAST_VALUE(MAN.CODE)
                                           OVER (ORDER BY CLFLINE.DATE_ ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) END AS SalesmanCode,
                       CASE
                           WHEN SubString(CLCARD.SPECODE5, 1, 2) = 'AU' THEN MAN.DEFINITION_ -- if combined 
                           ELSE LAST_VALUE(MAN.DEFINITION_)
                                           OVER (ORDER BY CLFLINE.DATE_ ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) END AS SalesmanName,

                       CASE WHEN CLFLINE.SIGN = 0 THEN CLFLINE.AMOUNT ELSE 0 END                                                           AS Debit,
                       CASE WHEN CLFLINE.SIGN = 1 THEN CLFLINE.AMOUNT ELSE 0 END                                                           AS Credit,
                       CLFLINE.AMOUNT                                                                                                      AS Amount,
                       'AZN'                                                                                                               As CurrencyCode
                FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         LEFT JOIN LG_XXX_CLCARD PCARD WITH (NOLOCK) ON PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN LOGODB.dbo.LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF
                WHERE --CLFLINE.CANCELLED = 0 AND CLFLINE.STATUS = 0 AND
                    CLFLINE.DATE_ BETWEEN @beginDate AND @endDate
                  AND CLCARD.LOGICALREF = @clientId
            )