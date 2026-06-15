ALTER FUNCTION [dbo].[F_SM_GetClientOperationInfo](@givenDate DATE, @userId INT, @firm SMALLINT, @clientId INT)
    RETURNS TABLE AS RETURN
            (
                SELECT ugd.ActionTypeId,
                       CASE
                           WHEN ugd.ActionTypeId >= 1 AND ugd.ActionTypeId <= 11 THEN ugd.ActionLogId
                           WHEN ugd.ActionTypeId = 30 THEN vl.Id
                           ELSE NULL END AS RequestId,
                       act.Type          AS ActionName,
                       ugd.GpsDate          CreatedDate,
                       ugd.Latitude         CreatedLatitude,
                       ugd.Longitude        CreatedLongitude,
                       s.Name               SalesmanName,
                       s.Code               SalesmanCode,
                       CASE
                           WHEN ugd.ActionTypeId IN (6, 7)
                               THEN (SELECT TOP 1 CAST(JSON_VALUE(ImportResult, '$.ERPDocInfo.Total') AS FLOAT) AS 'Price'
                                     FROM OP_ERPIntegrationtResultLog WITH (NOLOCK)
                                     WHERE GeneralId =
                                           (SELECT TOP 1 Id FROM OP_GeneralLog WHERE RequestId = ugd.ActionLogId))
                           WHEN ugd.ActionTypeId IN (1, 2, 3, 4, 5, 11)
                               THEN (SELECT TOP 1 Cast(JSON_VALUE(ImportResult, '$.ERPDocInfo.GrossAmount') AS FLOAT) AS 'Price'
                                     FROM OP_ERPIntegrationtResultLog WITH (NOLOCK)
                                     WHERE GeneralId =
                                           (SELECT TOP 1 Id FROM OP_GeneralLog WHERE RequestId = ugd.ActionLogId))
                           END           AS Price
                FROM OP_UserActionGpsData ugd WITH (NOLOCK)
                         LEFT JOIN OP_IncomingLog il WITH (NOLOCK) ON ugd.ActionLogId = il.Id AND ugd.ActionTypeId IN
                                                                                                  (1, 2, 3, 4, 5, 6, 7,
                                                                                                   8, 9, 10, 11)
                         LEFT JOIN OP_ClientVisitLog vl WITH (NOLOCK)
                                   ON vl.Id = ugd.ActionLogId and ugd.ActionTypeId = 30
                         LEFT JOIN MD_Salesman s WITH (NOLOCK) ON il.Firm = s.Firm AND il.SalesmanRef = s.TigerId
                         JOIN SYS_UserActionType act WITH (NOLOCK) ON ugd.ActionTypeId = act.Id AND act.Status = 1
                WHERE CAST(GpsDate AS DATE) = @givenDate
                  AND ugd.Firm = @firm
                  AND ugd.ClientId = @clientId
                  AND ugd.UserId = @userId
                ORDER BY ugd.GpsDate DESC
                OFFSET 0 ROWS
            )