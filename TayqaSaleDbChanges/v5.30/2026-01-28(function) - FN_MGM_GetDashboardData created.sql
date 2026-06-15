CREATE OR ALTER FUNCTION [dbo].[FN_MGM_GetDashboardData](
    @userId BIGINT,
    @begin datetime2,
    @end datetime2
    )
    RETURNS @DashboardData TABLE
                           (
                               total    int,
                               liked    int,
                               disliked int,
                               pending  int
                           )
    AS
    BEGIN
        WITH MainData AS (SELECT Files.SecureUrl   AS Url,
                                 Files.CreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end           as LikeStatus
                          FROM CHL_Attachment Files with (nolock)
                                   JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                                   JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                                   JOIN F_GetPermittedUsers(@userId) ou ON ou.UserId = Response.UserId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Likes.ReferenceId = Files.Id AND Likes.SourceType = 1
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 1
                          WHERE Files.Type = 3
                            AND CAST(Response.CreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE)

						UNION 
	                    
						  SELECT Files.SecureUrl   AS Url,
                                 Files.CreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end           as LikeStatus
                          FROM CHL_Attachment Files with (nolock)
                                   JOIN CHL_UserDynamicSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                                   JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                                   JOIN F_GetPermittedUsers(@userId) ou ON ou.UserId = Response.UserId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Likes.ReferenceId = Files.Id AND Likes.SourceType = 1
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 1
                          WHERE Files.Type = 3
                            AND CAST(Response.CreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE)


                          UNION --ALL

                          SELECT Files.SecureUrl   AS Url,
                                 Files.CreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end           as LikeStatus
                          FROM WPM_Attachment Files with (nolock)
                                   JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
                                   JOIN WPM_TaskTicket Tickets ON Tickets.Id = TicketActions.TaskTicketId
                                   JOIN F_GetPermittedUsers(@userId) ou ON ou.UserId = Tickets.UserId
                                   join WPM_TaskAction actions with (nolock) on actions.Id = TicketActions.ActionId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Likes.ReferenceId = Files.Id AND Likes.SourceType = 2
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 2
                          WHERE Files.Type = 3
                            AND CAST(Tickets.CreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE)
                            and actions.ActionType =1
                          UNION --ALL

                          SELECT Files.SecureUrl       AS Url,
                                 Files.FileCreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end               as LikeStatus
                          FROM OP_FileUploadLog Files with (nolock)
                                   JOIN MD_Client Client with (nolock) ON Client.TigerId = Files.ClientId --AND Client.Firm = 9
                                   JOIN F_GetPermittedUsers(@userId) ou ON ou.UserId = Files.UploadedUserId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Files.Id = Likes.ReferenceId AND Likes.SourceType = 5
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 5
                          WHERE Files.ContentType = 1
                            AND CAST(Files.FileCreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE)

                          UNION 

                          SELECT Files.SecureUrl       AS Url,
                                 Files.FileCreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end               as LikeStatus
                          FROM OP_FileUploadLog Files with (nolock)
                                   JOIN F_GetPermittedUsers(@userId) ou ON ou.UserId = Files.UploadedUserId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Files.Id = Likes.ReferenceId AND Files.ContentType = 2 AND Likes.SourceType = 3
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 3
                          WHERE Files.ContentType = 2
                            AND CAST(Files.FileCreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE)

                          UNION 

                          SELECT Files.SecureUrl   AS Url,
                                 Files.CreatedDate AS Date,
                                 case
                                     when
                                         likes.Status = 1 then 1
                                     when likes.status = 0 then 0
                                     when comment.Comment is not null then 3
                                     else null
                                     end           as LikeStatus
                          FROM IM_InventoryStateHistoryImage Files with (nolock)
                                   join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                                   join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = History.CreatorUserId
                                   LEFT JOIN MD_PhotoLike Likes with (nolock) ON Likes.ReferenceId = Files.Id AND Likes.SourceType = 4
                                   left join MD_PhotoComment comment with (nolock) ON comment.ReferenceId = Files.Id AND comment.SourceType = 4
                          WHERE CAST(History.CreatedDate AS DATE) BETWEEN CAST(@begin AS DATE) AND CAST(@end AS DATE))
        INSERT
        INTO @DashboardData (total, liked, disliked, pending)
SELECT 
            COUNT(*),
            SUM(IIF(hasLike = 1, 1, 0)) AS liked,
            SUM(IIF( hasDislike = 1, 1, 0)) AS disliked,
            SUM(IIF(hasLike = 0 AND hasDislike = 0 AND hasComment = 0, 1, 0)) AS pending
        FROM (
            SELECT 
                Url,
                MAX(IIF(LikeStatus = 1, 1, 0)) AS hasLike,
                MAX(IIF(LikeStatus = 0, 1, 0)) AS hasDislike,
                MAX(IIF(LikeStatus = 3, 1, 0)) AS hasComment
            FROM MainData
            GROUP BY Url
        ) AS grouped

        RETURN;
    END