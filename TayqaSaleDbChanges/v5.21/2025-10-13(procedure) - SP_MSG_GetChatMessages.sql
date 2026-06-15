CREATE OR ALTER proc [dbo].[SP_MSG_GetChatMessages] @userId int, @currentUserId int, @skipCount int, @fetchCount int as
begin
    WITH Messages AS (SELECT m.Message             AS Message,
                             MAX(m.MessageType)    AS MessageType,
                             MAX(m.ReadState)      AS ReadState,
                             MAX(m.CreationTime)   AS CreationTime,
                             m.TargetUserId        AS UserId,
                             MAX(u.UserName)       AS Username,
                             MAX(m.TargetTenantId) AS TenantId,
                             MAX(m.TenantId)       AS TargetTenantId,
                             MAX(m.UserId)         AS TargetUserId,
                             MAX(ca.SecureUrl)     AS SecureUrl
                      FROM AppChatMessages m
                               JOIN
                           AbpUsers u ON m.TargetUserId = u.Id
                               LEFT JOIN
                           AppChatAttachmets ca ON ca.ReferenceId = m.Id
                      WHERE TargetUserId = @userId and UserId = @currentUserId
                        AND Side = 2
                      GROUP BY m.Message,
                               m.TargetUserId

                      UNION ALL

                      SELECT m.Message        AS Message,
                             m.MessageType    AS MessageType,
                             m.ReadState      As ReadState,
                             m.CreationTime   AS CreationTime,
                             m.TargetUserId   AS UserId,
                             u.UserName       AS Username,
                             u.TenantId       AS TenantId,
                             m.TargetTenantId AS TargetTenantId,
                             m.UserId         AS TargetUserId,
                             ca.SecureUrl     AS SecureUrl
                      FROM AppChatMessages m
                               JOIN AbpUsers u ON m.TargetUserId = u.Id
                               LEFT JOIN AppChatAttachmets ca ON ca.ReferenceId = m.Id
                      WHERE UserId = @userId and TargetUserId = @currentUserId
                        AND Side = 2)
    select *,
           CASE
               WHEN UserId = @currentUserId THEN 1 -- Sender (If UserId matches, set to 1)
               ELSE 2 -- Receiver (Otherwise, set to 2)
               END AS Side
    from Messages
    order by CreationTime desc
    offset @skipCount rows fetch next @fetchCount rows only
end