alter Function [dbo].[FN_TS_Report_GetDailySaleRelatedAction_XXX_YY](@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (

-- Date: 28.04.2022 
-- Written by TayqaTech (Kanan Mammadov) for TayqaSale
-- The query returns the list of sale and related operations

                Select CLFLINE.SALESMANREF                                       AS SalesmanId,
                       MAN.CODE                                                  As SalesmanCode,
                       MAN.DEFINITION_                                           As SalesmanName,
                       CLFLINE.DATE_                                             As FicheDate,
                       IsNull(PCARD.EDINO, '')                                   AS Edino,
                       CLFLINE.LINEEXP                                           AS LineDesc,
                       CLFLINE.SOURCEFREF                                        AS FicheId,
                       CLFLINE.DOCODE                                            As Docode,
                       CLCARD.CODE                                               As ClientCode,
                       CLCARD.DEFINITION_                                        As ClientName,
                       CLFLINE.TRANNO                                            As FicheNo,
                       CLFLINE.TRCODE                                            AS Trcode,
                       Case When CLFLINE.SIGN = 0 Then CLFLINE.AMOUNT Else 0 End As Debit,
                       Case When CLFLINE.SIGN = 1 Then CLFLINE.AMOUNT Else 0 End As Credit,
                       CLFLINE.AMOUNT                                            As Amount,
                       'AZN'                                                     As CurrencyCode,
                       DIV.NR                                                    as DivisionNr,
                       DIV.NAME                                                  as DivisionName,
                       CLFLINE.DATE_                                             As Date
                From LG_XXX_YY_CLFLINE CLFLINE With (NoLock)
                         INNER JOIN L_CAPIDIV DIV WITH (NOLOCK) ON DIV.NR = CLFLINE.BRANCH AND DIV.FIRMNR = CAST(XXX AS INT)
                         Inner Join LG_XXX_CLCARD CLCARD With (NoLock) On CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                         Left Join LG_XXX_CLCARD PCARD With (NoLock) On PCARD.LOGICALREF = CLCARD.PARENTCLREF
                         LEFT JOIN LG_SLSMAN MAN WITH (NOLOCK) ON MAN.LOGICALREF = CLFLINE.SALESMANREF AND MAN.FIRMNR = CAST(XXX AS INT)
                Where CLFLINE.CANCELLED = 0
                  And CLFLINE.DATE_ Between @beginDate And @endDate

            )
go