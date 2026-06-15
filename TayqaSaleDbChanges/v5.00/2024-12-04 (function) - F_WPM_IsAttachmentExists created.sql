CREATE OR ALTER FUNCTION [dbo].[F_WPM_IsAttachmentExists](
    @actionId INT
)
    RETURNS BIT
AS
BEGIN
    DECLARE @exists BIT;

    
    SELECT 
        @exists = 
            CASE
                WHEN actiontype.Id IN (3, 4, 5, 6, 41, 42, 44, 45) THEN 0
                WHEN ticketaction.ActionParams IS NULL AND attachment.Url IS NULL THEN 0
                WHEN JSON_QUERY(ticketaction.ActionParams, '$.reference') = '[]' THEN 0
                ELSE 1
            END
    FROM WPM_TaskTicketAction ticketaction WITH (NOLOCK)
        JOIN WPM_TaskAction action WITH (NOLOCK) 
            ON ticketaction.ActionId = action.Id AND action.Status = 0
        JOIN WPM_TaskActionType actiontype WITH (NOLOCK) 
            ON actiontype.Id = action.ActionType AND actiontype.IsActive = 1
        LEFT JOIN WPM_Attachment attachment WITH (NOLOCK) 
            ON attachment.ReferenceId = ticketaction.Id AND attachment.Type = 3
    WHERE ticketaction.Id = @actionId;

    RETURN ISNULL(@exists, 0);
END;
