Create or ALTER FUNCTION [dbo].[F_MGM_GetNoteConfirmationReminder](@firm smallint, @UserId INT,
    @ClientId BIGINT,
    @OperationType INT,
    @OperationId INT
	)
    RETURNS TABLE
        AS
        RETURN(SELECT isnull(taskaction.Note, '') AS Note,
                      action.Message              as Message,
                      CASE
                          WHEN taskaction.ActionParams LIKE '%true%' THEN CAST(1 AS BIT)
                          WHEN actiontype.Id in (6, 48) then null
                          ELSE 0
                          END                     AS IsConfirmed


               FROM WPM_TaskTicket task WITH (NOLOCK)
                        JOIN WPM_TaskTicketAction taskaction WITH (NOLOCK)
                             ON taskaction.TaskTicketId = task.Id
                        JOIN WPM_TaskAction action WITH (NOLOCK)
                             ON taskaction.ActionId = action.Id
                        JOIN WPM_TaskActionType actiontype WITH (NOLOCK)
                             ON action.ActionType = actiontype.Id
               WHERE ActionType.Id = @OperationType
                 AND taskaction.Id = @OperationId
                 AND task.UserId =   @UserId
                 AND task.ClientId = @ClientId
                 and task.Firm = @firm);

