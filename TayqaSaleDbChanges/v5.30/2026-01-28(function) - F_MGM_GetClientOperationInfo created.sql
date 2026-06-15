CREATE OR ALTER function [dbo].[F_MGM_GetClientOperationInfo](@givenDate date, @userId int)
    returns table as return(WITH RankedDocs AS (SELECT ugd.ActionTypeId,
                                                       CASE
                                                           WHEN ugd.ActionTypeId >= 1 AND ugd.ActionTypeId <= 11
                                                               THEN ugd.ActionLogId
                                                           WHEN ugd.ActionTypeId = 30 THEN vl.Id
                                                           ELSE NULL
                                                           END                                                        AS RequestId,
                                                       act.Type                                                       AS ActionName,
                                                       ugd.GpsDate                                                    AS CreatedDate,
                                                       ugd.Latitude                                                   AS CreatedLatitude,
                                                       ugd.Longitude                                                  AS CreatedLongitude,
                                                       ugd.ClientId,
                                                       taskAction.Id                                                  AS ASDASD,
                                                       ugd.UserId,
                                                       CASE
						                                    WHEN log.ImportResult = 970 and
                                                                (isnull(Line2.Amount, 0) - ISNULL(LineResultAmount.Amount, 0)) =
                                                                0 THEN N'Ləğv edildi'
                                                           WHEN log.ImportResult = 969 THEN N'İmtina edildi'
                                                           WHEN ingLog.Id IS NOT NULL THEN N'Gözləmədə'
                                                           WHEN ActionTypeId IN (6,7) THEN ''
                                                           ELSE cast(concat(GrossWeight.GrossWeight, ' KG') as nvarchar(max))
                                                           END                                                        AS Note,

                                                       CASE
                                                           WHEN ugd.ActionTypeId IN (6, 7)
                                                               THEN isnull((SELECT TOP 1 CAST(JSON_VALUE(ImportResult, '$.ERPDocInfo.Total') AS FLOAT)
                                                                     FROM OP_ERPIntegrationtResultLog WITH (NOLOCK)
                                                                     WHERE GeneralId = (SELECT TOP 1 Id
                                                                                        FROM OP_GeneralLog WITH (NOLOCK)
                                                                                        WHERE RequestId = ugd.ActionLogId)),0)
                                                           WHEN ugd.ActionTypeId IN (1, 2, 3, 4, 5, 11)
                                                               THEN (SELECT TOP 1 CAST(JSON_VALUE(ImportResult, '$.ERPDocInfo.GrossAmount') AS FLOAT)
                                                                     FROM OP_ERPIntegrationtResultLog WITH (NOLOCK)
                                                                     WHERE GeneralId = (SELECT TOP 1 Id
                                                                                        FROM OP_GeneralLog WITH (NOLOCK)
                                                                                        WHERE RequestId = ugd.ActionLogId))
                                                           END                                                        AS Price,
                                                       log.Id                                                         AS LogId,
                                                       il.DocId,
                                                       ROW_NUMBER() OVER (PARTITION BY il.DocId ORDER BY log.Id DESC) AS rn
                                                FROM OP_UserActionGpsData ugd WITH (NOLOCK)
                                                         JOIN SYS_UserActionType act WITH (NOLOCK)
                                                              ON ugd.ActionTypeId = act.Id AND act.Status = 1
                                                         LEFT JOIN OP_IncomingLog il WITH (NOLOCK)
                                                                   ON ugd.ActionLogId = il.Id
                                                                       AND ugd.ActionTypeId IN
                                                                           (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
                                                         LEFT JOIN OP_ThirdPartyIncomingLog ingLog on il.Id = ingLog.Id
                                                        JOIN OP_GeneralLog log
                                                                   ON log.RequestId = il.Id
                                                         LEFT JOIN OP_RequestQueue rqueue with (nolock) on rqueue.Id = ingLog.Id
                                                         LEFT JOIN (select Id, sum(Amount) as Amount
                                                                    from OP_ThirdPartyIncomingLogCommonLineExtension with (nolock)
                                                                    group by Id) Line2 on ingLog.Id = Line2.Id
                                                         LEFT JOIN (select Id, sum(Amount) as Amount
                                                                    from OP_ThirdPartyCommonLineResultLog with (nolock)
                                                                    group by Id) LineResultAmount
                                                                   on ingLog.Id = LineResultAmount.Id
                                                         LEFT JOIN WPM_TaskTicketAction taskAction
                                                         CROSS APPLY OPENJSON(taskAction.ActionParams, '$.reference')
                                                                              WITH (UId NVARCHAR(50) '$') ref
                                                    ON il.DocId = ref.UId
                                                         LEFT JOIN (SELECT Id,
                                                                           ROUND(SUM(Unit.GrossWeight * Line.Amount), 2) AS GrossWeight
                                                                    FROM OP_IncomingLogCommonLineExtension Line WITH (NOLOCK)
                                                                             JOIN MD_ItemUnit Unit WITH (NOLOCK)
                                                                                  ON Line.ItemId = Unit.TigerItemId AND Line.ItemUnitCode = Unit.Code
                                                                    GROUP BY Id) GrossWeight ON GrossWeight.Id = il.Id
                                                         LEFT JOIN OP_ClientVisitLog vl WITH (NOLOCK)
                                                                   ON vl.Id = ugd.ActionLogId AND ugd.ActionTypeId = 30
                                                         LEFT JOIN MD_Salesman s WITH (NOLOCK)
                                                                   ON il.Firm = s.Firm AND il.SalesmanRef = s.TigerId
                                               WHERE CAST(COALESCE(ugd.SendDate, ugd.GpsDate) AS DATE) = @givenDate

                                                  AND ugd.UserId = @userId
                                                  AND taskAction.Id IS NULL)
                            SELECT *
                            FROM RankedDocs
                            WHERE rn = 1
                            ORDER BY CreatedDate DESC
                            OFFSET 0 ROWS)