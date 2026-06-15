Create Or ALTER PROCEDURE [dbo].[SP_MGM_GetUserStories]@firm Smallint, @userId BIGINT, @seenByUserId BIGINT
AS
BEGIN
    WITH cte
             AS
             (SELECT Attachments.Id                         AS Id
                   , 2                                      AS SourceType
                   , CONCAT(Users.Name, ' ', Users.Surname) AS UserFullName
                   , Attachments.SecureUrl                  AS Url
                   , Clients.Code                           AS ClientCode
                   , Clients.Name                           AS ClientName
                   , Attachments.CreatedDate                AS Date
                   , Comments.Id                               CommentCount
                   , Likes.Id                                  ReactionCount
                   , Likes.CreatorUserId                    AS UserId
                   , IIF(StoryLog.ImageUrl IS NULL, 0, 1)   AS IsStorySeen
              FROM WPM_Attachment Attachments WITH (NOLOCK)
                       JOIN WPM_TaskTicketAction Action WITH (NOLOCK)
                            ON Attachments.ReferenceId = Action.Id
                       JOIN WPM_TaskTicket Ticket WITH (NOLOCK)
                            ON Ticket.Id = Action.TaskTicketId
                       JOIN MD_Client Clients WITH (NOLOCK)
                            ON Clients.TigerId = Ticket.ClientId
                                AND Clients.Firm = Ticket.Firm
                       JOIN AbpUsers Users WITH (NOLOCK)
                            ON Users.Id = Ticket.UserId
                       LEFT JOIN (SELECT DISTINCT ImageUrl
                                  FROM MSG_UserStoryLog WITH (NOLOCK)
                                  where SeenByUserId = @seenByUserId) StoryLog
                                 ON StoryLog.ImageUrl COLLATE Azeri_Latin_100_CI_AS = Attachments.SecureUrl
                       LEFT JOIN MD_PhotoLike Likes
                                 ON Likes.ReferenceId = Attachments.Id
                                     AND Likes.SourceType = 2

                       LEFT JOIN MD_PhotoComment Comments
                                 ON Attachments.Id = Comments.ReferenceId
                                     AND Comments.SourceType = 2
                       LEFT JOIN MD_StopReason Reasons
                                 ON Reasons.Id = Comments.ReasonId
                       LEFT JOIN WPM_TaskAction type with (nolock) on Action.ActionId = type.Id
              WHERE Users.Id = @userId and Ticket.Firm=@firm
                AND Attachments.Type = 3
                AND Attachments.CreatedDate >= CAST(GETDATE() AS DATE)
                AND type.ActionType not in (2, 49, 50)

              UNION ALL


              --Checklist question answer images

              SELECT Attachments.Id                         AS Id
                   , 1                                      AS SourceType
                   , CONCAT(Users.Name, ' ', Users.Surname) AS UserFullName
                   , Attachments.SecureUrl                  AS Url
                   , Clients.Code                           AS ClientCode
                   , Clients.Name                           AS ClientName
                   , Attachments.CreatedDate                AS Date
                   , Comments.Id                               CommentCount
                   , Likes.Id                                  ReactionCount
                   , Likes.CreatorUserId                    AS UserId
                   , IIF(StoryLog.ImageUrl IS NULL, 0, 1)   AS IsStorySeen

              FROM CHL_Attachment Attachments WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponseDetail ResponseDetail WITH (NOLOCK)
                            ON Attachments.ReferenceId = ResponseDetail.Id
                       JOIN CHL_UserSurveyResponse Response WITH (NOLOCK)
                            ON Response.Id = ResponseDetail.UserSurveyResponseId
                       JOIN MD_Client Clients WITH (NOLOCK)
                            ON Response.ClientId = Clients.TigerId
                                AND Clients.Firm = Response.Firm
                       JOIN AbpUsers Users WITH (NOLOCK)
                            ON Users.Id = Response.UserId
                       LEFT JOIN (SELECT DISTINCT ImageUrl
                                  FROM MSG_UserStoryLog WITH (NOLOCK)
                                  where SeenByUserId = @seenByUserId) StoryLog
                                 ON StoryLog.ImageUrl COLLATE Azeri_Latin_100_CI_AS = Attachments.SecureUrl
                       LEFT JOIN MD_PhotoLike Likes
                                 ON Likes.ReferenceId = Attachments.Id
                                     AND Likes.SourceType = 1

                       LEFT JOIN MD_PhotoComment Comments
                                 ON Attachments.Id = Comments.ReferenceId
                                     AND Comments.SourceType = 1
                       LEFT JOIN MD_StopReason Reasons
                                 ON Reasons.Id = Comments.ReasonId
              WHERE Users.Id = @userId and Response.Firm=@firm
                AND Attachments.Type = 3
                AND Attachments.CreatedDate >= CAST(GETDATE() AS DATE)


              UNION ALL

              --Photos from Clients and Visit
              SELECT Files.Id                               AS Id
                   , CASE ContentType
                         WHEN 1 THEN 5
                         WHEN 2 THEN 3
                  END                                       AS SourceType
                   , CONCAT(Users.Name, ' ', Users.Surname) AS UserFullName
                   , Files.SecureUrl                        AS Url
                   , Clients.Code                           AS ClientCode
                   , Clients.Name                           AS ClientName
                   , Files.FileCreatedDate                  AS Date
                   , Comments.Id                               CommentCount
                   , Likes.Id                                  ReactionCount
                   , Likes.CreatorUserId                    AS UserId
                   , IIF(StoryLog.ImageUrl IS NULL, 0, 1)   AS IsStorySeen
              FROM OP_FileUploadLog Files WITH (NOLOCK)
                       JOIN MD_Client Clients WITH (NOLOCK)
                            ON Files.Firm = Clients.Firm
                                AND Clients.TigerId = Files.ClientId
                       JOIN AbpUsers Users WITH (NOLOCK)
                            ON Users.Id = Files.UploadedUserId
                       LEFT JOIN (SELECT DISTINCT ImageUrl
                                  FROM MSG_UserStoryLog WITH (NOLOCK)
                                  where SeenByUserId = @seenByUserId) StoryLog
                                 ON StoryLog.ImageUrl COLLATE Azeri_Latin_100_CI_AS = Files.SecureUrl
                       LEFT JOIN MD_PhotoLike Likes WITH (NOLOCK)
                                 ON Likes.ReferenceId = Files.Id
                                     AND Likes.SourceType IN (3, 5)

                       LEFT JOIN MD_PhotoComment Comments WITH (NOLOCK)
                                 ON Files.Id = Comments.ReferenceId
                                     AND Comments.SourceType IN (3, 5)
                       LEFT JOIN MD_StopReason Reasons WITH (NOLOCK)
                                 ON Reasons.Id = Comments.ReasonId
              WHERE Users.Id = @userId
                AND Files.ContentType IN (1, 2)
                AND Files.FileCreatedDate >= CAST(GETDATE() AS DATE) and Files.Firm=@firm

              UNION ALL

              --Photos from Inventory
              SELECT Files.Id                               AS Id
                   , 4                                      AS SourceType
                   , CONCAT(Users.Name, ' ', Users.Surname) AS UserFullName
                   , Files.SecureUrl                        AS Url
                   , Clients.Code                           AS ClientCode
                   , Clients.Name                           AS ClientName
                   , Files.CreatedDate                      AS Date
                   , Comments.Id                               CommentCount
                   , Likes.Id                                  ReactionCount
                   , Likes.CreatorUserId                    AS UserId
                   , IIF(StoryLog.ImageUrl IS NULL, 0, 1)   AS IsStorySeen
              FROM IM_InventoryStateHistoryImage Files WITH (NOLOCK)
                       JOIN IM_InventoryStateHistory History WITH (NOLOCK)
                            ON History.Id = Files.InventoryStateHistoryId
                       JOIN MD_Client Clients WITH (NOLOCK)
                            ON Clients.TigerId = History.ClientTigerId
                                AND History.Firm = Clients.Firm
                       JOIN AbpUsers Users WITH (NOLOCK)
                            ON Users.Id = History.CreatorUserId
                       LEFT JOIN (SELECT DISTINCT ImageUrl
                                  FROM MSG_UserStoryLog WITH (NOLOCK)
                                  where SeenByUserId = @seenByUserId) StoryLog
                                 ON StoryLog.ImageUrl COLLATE Azeri_Latin_100_CI_AS = Files.SecureUrl
                       LEFT JOIN MD_PhotoLike Likes WITH (NOLOCK)
                                 ON Likes.ReferenceId = Files.Id
                                     AND Likes.SourceType = 4
                       LEFT JOIN MD_PhotoComment Comments WITH (NOLOCK)
                                 ON Comments.ReferenceId = Files.Id
                                     AND Comments.SourceType = 4
                       LEFT JOIN MD_StopReason Reasons WITH (NOLOCK)
                                 ON Reasons.Id = Comments.ReasonId
              WHERE Users.Id = @userId and History.Firm=@firm
                AND Files.CreatedDate >= CAST(GETDATE() AS DATE))
    SELECT distinct Id
                  , Data.SourceType
                  , UserFullName
                  , ClientCode
                  , ClientName
                  , Date                                                   AS Date
                  , COUNT(DISTINCT CommentCount)                           AS CommentCount
                  , CAST(IIF(UserReaction.IsLikedStatus = 1, 1, 0) AS BIT) AS IsLiked
                  , CAST(TotalReactions.LikeCount AS SMALLINT)             AS LikeCount
                  , CAST(TotalReactions.DislikeCount AS SMALLINT)          AS DislikeCount
                  , UserReaction.CreationTime                              AS ReactionDate
                  , Url
                  , IsStorySeen
                  , MIN(IIF(UserId IN (@seenByUserId), 0, 1))              AS CanLiked
    FROM cte data
             LEFT JOIN (SELECT ReferenceId,
                               SourceType,
                               SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS LikeCount,
                               SUM(CASE WHEN Status = 0 THEN 1 ELSE 0 END) AS DislikeCount
                        FROM MD_PhotoLike WITH (NOLOCK)
                        GROUP BY ReferenceId, SourceType) AS TotalReactions
                       ON TotalReactions.ReferenceId = Data.Id
                           AND TotalReactions.SourceType = Data.SourceType

             LEFT JOIN (SELECT ReferenceId,
                               SourceType,
                               Status AS IsLikedStatus,
                               CreationTime
                        FROM MD_PhotoLike WITH (NOLOCK)
                        WHERE CreatorUserId = @seenByUserId) AS UserReaction
                       ON UserReaction.ReferenceId = Data.Id
                           AND UserReaction.SourceType = Data.SourceType

    GROUP BY Id
           , Data.SourceType
           , UserFullName
           , ClientCode
           , ClientName
           , Date
           , Url
           , IsStorySeen
           , UserReaction.CreationTime
           , UserReaction.IsLikedStatus
           , TotalReactions.LikeCount, TotalReactions.DislikeCount
    order by Date asc
END


