
CREATE OR ALTER FUNCTION [dbo].[FN_MSG_GetUserConversations]
(
    @currentUserId BIGINT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        c.Id AS ConversationId,

        c.[Type] AS ConversationType,

        CASE
            WHEN c.[Type] = 1 THEN
                (
                    LTRIM(RTRIM(
                        ISNULL(otherUser.[Name], N'') + N' ' + ISNULL(otherUser.Surname, N'')
                    )) COLLATE DATABASE_DEFAULT
                )
            ELSE
                (c.[Name] COLLATE DATABASE_DEFAULT)
        END AS [Name],

        lm.MessageText AS LastMessage,
        lm.Type AS LastMessageType,
        lm.SentDate    AS LastMessageTime,

        (LTRIM(RTRIM(
            ISNULL(senderUser.[Name], N'') + N' ' + ISNULL(senderUser.Surname, N'')
        )) COLLATE DATABASE_DEFAULT) AS LastMessageSenderUserName,

        lm.SenderUserId AS LastMessageSenderUserId,

        CASE
            WHEN c.[Type] = 1 THEN other.MemberId
            ELSE NULL
        END AS UserId,

        ISNULL(uc.UnreadCount, 0) AS UnreadCount,

        CASE
            WHEN c.[Type] = 1 THEN ISNULL(ucs.IsOnline, 0)
            ELSE NULL
        END AS IsOnline,

        CASE
            WHEN c.[Type] = 1 THEN ucs.LastOnlineTime
            ELSE NULL
        END AS LastOnlineTime

    FROM dbo.MSG_Conversation c
    INNER JOIN dbo.MSG_ConversationMember me
        ON me.ConversationId = c.Id
       AND me.MemberId = @currentUserId

    OUTER APPLY
    (
        SELECT TOP (1) m.MemberId
        FROM dbo.MSG_ConversationMember m
        WHERE m.ConversationId = c.Id
          AND m.MemberId <> @currentUserId
        ORDER BY m.Id
    ) other

    LEFT JOIN dbo.AbpUsers otherUser
        ON otherUser.Id = other.MemberId

    LEFT JOIN dbo.MSG_UserChatStatus ucs
        ON ucs.UserId = other.MemberId

    OUTER APPLY
    (
        SELECT TOP (1)
            mm.MessageText,
            mm.SentDate,
			mm.Type,
            mm.SenderUserId
        FROM dbo.MSG_ConversationMessage mm
        WHERE mm.ConversationId = c.Id
        ORDER BY
            ISNULL(mm.SentDate, '19000101') DESC,
            mm.Id DESC
    ) lm

    LEFT JOIN dbo.AbpUsers senderUser
        ON senderUser.Id = lm.SenderUserId

    OUTER APPLY
    (
        SELECT COUNT(1) AS UnreadCount
        FROM dbo.MSG_ConversationMessage mmu
        WHERE mmu.ConversationId = c.Id
          AND mmu.SenderUserId <> @currentUserId
          AND (
                me.LastReadTime IS NULL
                OR mmu.SentDate > me.LastReadTime
              )
    ) uc
);
GO
