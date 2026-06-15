
CREATE OR ALTER FUNCTION [dbo].[FN_MSG_GetConversationMessages] (@conversationId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CM.Id AS ServerMessageId,
        CM.SenderUserId,
        U.Name + ' ' + U.Surname AS SenderUserName,
        CM.MessageText,
        CM.SentDate,
        CM.Type,
        CM.Latitude,
        CM.Longitude,
        CM.ContactPersonName,
        CM.ContactPersonPhoneNumber,
        CM.State,
        (
            SELECT STRING_AGG(MA.SecureUrl, ', ')
            FROM MSG_MessageAttachment MA
            WHERE MA.MessageId = CM.Id
        ) AS AttachmentsSecureUrls
    FROM MSG_ConversationMessage CM
    JOIN AbpUsers U
        ON CM.SenderUserId = U.Id
    WHERE CM.ConversationId = @conversationId
);
