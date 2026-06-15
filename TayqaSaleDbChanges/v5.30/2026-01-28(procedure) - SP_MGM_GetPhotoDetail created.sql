
CREATE OR ALTER  PROCEDURE [dbo].[SP_MGM_GetPhotoDetail] @userId BIGINT,
                                              @likeUserId BIGINT,
                                              @url NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    declare @galleryJson nvarchar(max)
    declare @Json nvarchar(max)

    declare @GalleryData table
                         (
                             photoUrl      nvarchar(500),
                             id            int,
                             sourceType    tinyint,
                             clientCode    nvarchar(100),
                             clientName    nvarchar(250),
                             locationType  tinyint,
                             userId        bigint,
                             userName      nvarchar(200),
                             date          bigint,
                             isLiked       bit,
                             hasComment    bit,
                             reactionCount smallint,
                             commentCount  smallint,
                             canLike       BIT
                         );
-------------------------------------------------------------------------------------------------------------------------------------------

    with MainData as (select distinct Files.SecureUrl    AS Url,
                                      Files.CreatedDate  as Date,
                                      Likes.Status       as LikeStatus,
                                      cast(1 as tinyint) as SourceType

                      FROM CHL_Attachment Files with (nolock)
                               JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                               JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                               LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                      WHERE Files.SecureUrl = @url

                      union all

                      select distinct Files.SecureUrl    AS Url,
                                      Files.CreatedDate  as Date,
                                      Likes.Status       as LikeStatus,
                                      cast(2 as tinyint) as SourceType
                      FROM WPM_Attachment Files with (nolock)
                               JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
                               JOIN WPM_TaskAction TaskAction with (nolock) ON TicketActions.ActionId = TaskAction.Id
                               LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                      WHERE Files.SecureUrl = @url

                      union all

                      select distinct Files.SecureUrl       AS Url,
                                      Files.FileCreatedDate as Date,
                                      Likes.Status          as LikeStatus,
                                      cast(3 as tinyint)    as SourceType
                      from OP_FileUploadLog Files with (nolock)
                               LEFT JOIN MD_PhotoLike Likes with (nolock)
                                         on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
                      where Files.SecureUrl = @url

                      union all

                      select distinct Files.SecureUrl    AS Url,
                                      Files.CreatedDate  as Date,
                                      Likes.Status       as LikeStatus,
                                      cast(4 as tinyint) as SourceType
                      from IM_InventoryStateHistoryImage Files with (nolock)
                               left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                      where Files.SecureUrl = @url

                      union all

                      select distinct Files.SecureUrl       AS Url,
                                      Files.FileCreatedDate as Date,
                                      Likes.Status          as LikeStatus,
                                      cast(5 as tinyint)    as SourceType
                      from OP_FileUploadLog Files with (nolock)
                               left join MD_PhotoLike Likes with (nolock)
                                         on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit
                      where Files.SecureUrl = @url)
            ,
         Counts as (select iif(MainData.LikeStatus = 0, count(Url), 0)     as DislikedPhotoCount,
                           iif(MainData.LikeStatus = 1, count(Url), 0)     as LikedPhotoCount,
                           iif(MainData.LikeStatus is null, count(Url), 0) as NonLikedPhotoCount,
                           Maindata.Url                                    AS Url
                    from MainData

                    group by MainData.SourceType, MainData.LikeStatus, Maindata.Url),

         -------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------
         Data as (select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         concat(Users.Name, ' ', Users.Surname) as UserName,
                         Users.Id                               as UserId,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Likes.CreationTime                     as ReactionDate,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         2                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Tickets.CreatedLongitude               as OperationLongitude,
                         Tickets.CreatedLatitude                as OperationLatitude
                  from WPM_Attachment Files with (nolock)

                           join WPM_TaskTicketAction Reference with (nolock) on Files.ReferenceId = reference.Id
                           join WPM_TaskTicket Tickets with (nolock) on Tickets.Id = Reference.TaskTicketId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm
								                           join AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
                           join F_GetPermittedUsers(@userId) StructureUsers
                                on StructureUsers.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                           left join MD_PhotoStar Stars with (nolock)
                                     on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                           left join MD_PhotoComment Comments with (nolock)
                                     on files.Id = Comments.ReferenceId and Comments.SourceType = 2
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId

                  WHERE Files.SecureUrl = @url

                  union all

                  select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         concat(Users.Name, ' ', Users.Surname) as UserName,
                         Users.Id                               as UserId,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Likes.CreationTime                     as ReactionDate,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         1                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Response.CreatedLongitude              as OperationLongitude,
                         Response.CreatedLatitude               as OperationLatitude
                  from CHL_Attachment Files with (nolock)
                           join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                           join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                           join AbpUsers Users with (nolock) on Users.Id = Response.UserId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm
                           join F_GetPermittedUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 1
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 1
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                  where Files.SecureUrl = @url

                  union ALL

                  select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         concat(Users.Name, ' ', Users.Surname) as UserName,
                         Users.Id                               as UserId,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Likes.CreationTime                     as ReactionDate,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         1                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Response.CreatedLongitude              as OperationLongitude,
                         Response.CreatedLatitude               as OperationLatitude
                  from CHL_Attachment Files with (nolock)
                           join CHL_UserDynamicSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                           join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                           join AbpUsers Users with (nolock) on Users.Id = Response.UserId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm
                           join F_GetPermittedUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 1
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 1
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                  where Files.SecureUrl = @url

                  union all

                  select Client.Code                                      as ClientCode,
                         Client.Name                                      as ClientName,
                         concat(Users.Name, ' ', Users.Surname)           as UserName,
                         Users.Id                                         as UserId,
                         Likes.Status                                     as LikeStatus,
                         Stars.StarCount                                  as StarCount,
                         Files.FilePath                                   as PhotoAddress,
                         Files.SecureUrl                                  as SecureUrl,
                         Comments.Comment                                 as Comment,
                         Files.FileCreatedDate                            as CreationDate,
                         Reasons.Description                              as Reason,
                         Files.Id                                         as AttachmentId,
                         Likes.CreatorUserId                              as LikeUserId,
                         Likes.CreationTime                               as ReactionDate,
                         Comments.CreatorUserId                           as CommentUserId,
                         Stars.CreatorUserId                              as StarUserId,
                         case ContentType when 1 then 5 when 2 then 3 end as SourceType,
                         Client.Longitude                                 as ClientLongitude,
                         Client.Latitude                                  as ClientLatitute,
                         Files.Longitude                                  as OperationLongitude,
                         Files.Latitude                                   as OperationLatitude
                  from OP_FileUploadLog Files with (nolock)
                           join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId
                           join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                           join F_GetPermittedUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock) on
                          (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) or -- Visit
                          (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos

                           left join MD_PhotoStar Stars with (nolock) on
                          (Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) or -- Visit
                          (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos

                           left join MD_PhotoComment Comments with (nolock) on
                          (Files.Id = Comments.ReferenceId and Files.ContentType = 2 and
                           Comments.SourceType = 3) or -- Visit
                          (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and
                           Comments.SourceType = 5) -- Client photos
                           left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

                  where Files.SecureUrl = @url

                  union all

                  select Client.Code                            as ClientCode,
                         Client.Name                            as ClientName,
                         concat(Users.Name, ' ', Users.Surname) as UserName,
                         Users.Id                               as UserId,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.ImagePath                        as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Likes.CreationTime                     as ReactionDate,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         4                                      as SourceType,
                         Client.Longitude                       as ClientLongitude,
                         Client.Latitude                        as ClientLatitute,
                         null                                   as OperationLongitude,
                         null                                   as OperationLatitude
                  from IM_InventoryStateHistoryImage Files with (nolock)
                           join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                           join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId
                           join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
                           join F_GetPermittedUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId

                  where Files.SecureUrl = @url)

    SELECT AttachmentId                                              AS Id,
           SourceType                                                AS SourceType,
           ClientCode                                                AS ClientCode,
           ClientName                                                AS ClientName,
           CASE
               WHEN ROUND(IIF(
                                          ClientLatitute = 0 OR ClientLatitute IS NULL OR
                                          OperationLatitude = 0 OR OperationLatitude IS NULL,
                                          NULL,
                                          IIF(geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                      geography::Point(OperationLatitude, OperationLongitude, 4326)) < 1,
                                              1,
                                              geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                      geography::Point(OperationLatitude, OperationLongitude, 4326))
                                              )
                              ), 5) < 300
                   THEN CAST(1 AS TINYINT)

               WHEN ROUND(IIF(
                                          ClientLatitute = 0 OR ClientLatitute IS NULL OR
                                          OperationLatitude = 0 OR OperationLatitude IS NULL,
                                          NULL,
                                          IIF(geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                      geography::Point(OperationLatitude, OperationLongitude, 4326)) < 1,
                                              1,
                                              geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                      geography::Point(OperationLatitude, OperationLongitude, 4326))
                                              )
                              ), 5) > 300
                   THEN CAST(2 AS TINYINT)

               ELSE 1
               END                                                   AS LocationType,
           UserName,
            CreationDate AS Date,
           (
					SELECT TOP 1 CAST(1 AS BIT)
					FROM MD_PhotoLike l WITH (NOLOCK)
					WHERE l.ReferenceId = Data.AttachmentId
					  AND l.SourceType = Data.SourceType
					  AND l.CreatorUserId = @userId
					  AND l.Status = 1
				)
                                                                     AS IsLiked,
           CAST(MAX(IIF(Comment IS NOT NULL, 1, 0)) AS BIT)          AS HasComment,
           (SELECT COUNT(Id)
            FROM MD_PhotoComment pc with (nolock)
            WHERE pc.ReferenceId = Data.AttachmentId
              and pc.SourceType = Data.SourceType)                   AS CommentCount,
           CAST(
                   CASE
                       WHEN EXISTS(
                               SELECT 1
                               FROM MD_PhotoLike l WITH (NOLOCK)
                               WHERE l.ReferenceId = Data.AttachmentId
                                 AND l.SourceType = Data.SourceType
                                 AND l.CreatorUserId = @userId
                           )
                           THEN 0
                       ELSE 1
                       END AS BIT
               )
                                                                     AS CanLike,
            ReactionDate AS ReactionDate,
           (SELECT COUNT(1)
            FROM MD_PhotoLike L WITH (NOLOCK)
            WHERE L.ReferenceId = Data.AttachmentId
              AND L.SourceType = Data.SourceType
              AND L.Status = 1)                                      AS LikeCount,

           (SELECT COUNT(1)
            FROM MD_PhotoLike L WITH (NOLOCK)
            WHERE L.ReferenceId = Data.AttachmentId
              AND L.SourceType = Data.SourceType
              AND L.Status = 0)                                      AS DislikeCount

    FROM Data
    GROUP BY AttachmentId, SourceType, ClientCode, ClientName, ClientLatitute, ClientLongitude, OperationLatitude, OperationLongitude,
             UserName, UserId,  CreationDate, ReactionDate


END;