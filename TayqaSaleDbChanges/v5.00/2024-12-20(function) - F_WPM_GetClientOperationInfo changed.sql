CREATE OR ALTER FUNCTION [dbo].[F_WPM_GetClientOperationInfo](@givenDate DATE, @userId INT, @firm SMALLINT, @clientId INT)
    RETURNS TABLE AS RETURN
            (
                 SELECT tat.Id ActionTypeId,
                       tat.Name AS ActionName,
                       ta.Message ActionMessage,
                       tta.Id AS TicketActionId,
                       tta.Note AS ActionNote,
                       tta.ActionParams,
                       ActionReferenceId,
                       tta.CreatedDate,
                       tta.CreatedLatitude,
                       tta.CreatedLongitude,
                       tta.FinalizedDate,
                       tta.FinalizedLatitude,
                       tta.FinalizedLongitude,
					    Cast(ISNULL(CASE
						WHEN tat.Id = 9 AND TRY_CONVERT(UNIQUEIDENTIFIER, ActionReferenceId) IS NOT NULL
						 THEN (SELECT Id FROM CHL_UserSurveyResponse WHERE UId = ActionReferenceId)
						WHEN tat.Id in (7,10,11,12,13,14,15,31,32,33,43) AND TRY_CONVERT(UNIQUEIDENTIFIER, ActionReferenceId) is not null
						 THEN (select top 1 Id from OP_IncomingLog where DocId=ActionReferenceId)
						WHEN tat.Id in (8) AND TRY_CONVERT(UNIQUEIDENTIFIER, ActionReferenceId) is not null
						 THEN (select top 1 Id from OP_ClientVisitLog where DocId=ActionReferenceId)
						END, 0) AS INT) as RequestId
                    FROM WPM_TaskTicket tt WITH (NOLOCK)
                             JOIN WPM_TaskTicketAction tta WITH (NOLOCK) ON tta.TaskTicketId = tt.Id
                             JOIN WPM_TaskAction ta WITH (NOLOCK) ON tta.ActionId = ta.Id
                             JOIN WPM_TaskActionType tat WITH (NOLOCK) ON ta.ActionType = tat.Id
                             OUTER APPLY (
                        SELECT ActionReferenceId
                            FROM OpenJSON(tta.ActionParams, '$.reference')
                                          WITH (ActionReferenceId NVARCHAR(40) '$')
                    ) Ref
                    WHERE CAST(tta.CreatedDate AS DATE) = @givenDate
                      AND tt.Firm = @firm
                      AND tt.ClientId = @clientId
                      AND tt.UserId = @userId
                    ORDER BY tta.CreatedDate DESC
                    OFFSET 0 ROWS
            )
