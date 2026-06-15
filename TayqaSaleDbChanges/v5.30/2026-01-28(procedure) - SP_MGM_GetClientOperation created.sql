CREATE OR ALTER PROCEDURE [dbo].[SP_MGM_GetClientOperation] @userId INT, @givenDate DATE
AS
BEGIN
    SET NOCOUNT ON;
	SELECT distinct tat.Id				AS ActionTypeId,
					tat.Name            AS ActionName,
					tt.ClientId			AS ClientId,
					tt.Firm				AS Firm,
					tt.UserId           AS UserId
	FROM WPM_TaskTicket tt WITH (NOLOCK)

		JOIN F_GetAllPermittedClient() pc ON tt.UserId = pc.UserId AND tt.Firm = pc.Firm AND tt.ClientId = pc.ClientId
		JOIN WPM_TaskTicketAction tta WITH (NOLOCK) ON tta.TaskTicketId = tt.Id
        JOIN WPM_TaskAction ta WITH (NOLOCK) ON tta.ActionId = ta.Id
        JOIN WPM_TaskActionType tat WITH (NOLOCK) ON ta.ActionType = tat.Id

	 WHERE CAST(tta.CreatedDate AS DATE) = @givenDate

	ORDER BY ActionTypeId, ActionName, ClientId, Firm DESC OFFSET 0 ROWS
END
