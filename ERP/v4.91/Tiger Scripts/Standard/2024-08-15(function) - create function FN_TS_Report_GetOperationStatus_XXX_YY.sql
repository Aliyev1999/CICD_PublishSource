CREATE Function dbo.FN_TS_Report_GetOperationStatus_XXX_YY(@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                Select ORFICHE.LOGICALREF                AS OperationId,
                       ILog.DocType                      AS DocType,
                       ILog.DocId                        AS DocId,
                       ORFICHE.FICHENO                   AS FicheNo,
                       ORFICHE.DATE_                     AS Date,
                       ORFICHE.NETTOTAL                  AS NetTotal,
                       SLSMAN.LOGICALREF                 AS SalesmanId,
                       SLSMAN.DEFINITION_                AS SalesmanName,
                       SLSMAN.CODE                       AS SalesmanCode,
                       0                                 AS Status,
                       CARD.CODE                         AS ClientCode,
                       CARD.SPECODE4                     AS ClientSpecode4,
                       ORFICHE.CLIENTREF                 AS ClientId,
                       CARD.DEFINITION_                  AS ClientName,
                       'AZN'                             As CurrencyCode
                From LG_XXX_YY_ORFICHE ORFICHE With (NoLock) -- RETURN INVOICES
                         Inner Join LG_XXX_CLCARD CARD With (NoLock) On CARD.LOGICALREF = ORFICHE.CLIENTREF
                         INNER JOIN LG_SLSMAN SLSMAN With (NoLock) ON SLSMAN.LOGICALREF = ORFICHE.SALESMANREF and SLSMAN.FIRMNR = @firm
                         INNER JOIN TayqaSale..OP_GeneralLog GLog with (nolock) on GLog.TigerId = ORFICHE.LOGICALREF AND ImportResult = 0
                         INNER JOIN TayqaSale..OP_IncomingLog ILog with (nolock) on GLog.RequestId = ILog.Id

                Where ORFICHE.DATE_ Between @beginDate And @endDate
            )

GO