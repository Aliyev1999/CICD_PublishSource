
ALTER procedure [dbo].[SP_RM_GetPhotoGallery] @beginDate datetime, @endDate datetime, @userId bigint, @firm smallint, @takeCount int,
                                              @skipCount int
AS
BEGIN

    select DateTime,
           CreatorUserName,
           CreatorUserFullName,
           Photo,
           SecureUrl,
           ClientCode,
           ClientId,
           ClientName,
           LikeStatus,
           StarCount,
           CommentedUserName,
           CommentedUserFullName,
           CommentReason,
           CommentText,
           TaskId,
           Type
    from (select Files.CreatedDate                                                          as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, ' ', Users.Surname)                                     as CreatorUserFullName,
                 Url                                                                        as Photo,
                 SecureUrl                                                                  as SecureUrl,
                 Clients.Code                                                               as ClientCode,
                 Clients.TigerId                                                            as ClientId,
                 Clients.Name                                                               as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, ' ', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, ' ', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, ' ', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 Tickets.TaskId                                                             as TaskId,
                 2                                                                          as Type

          from WPM_Attachment Files
                   join WPM_TaskTicketAction Reference on Files.ReferenceId = reference.Id
				   JOIN WPM_TaskAction TaskAction with (nolock) ON Reference.ActionId = TaskAction.Id
                   join WPM_TaskTicket Tickets on Tickets.Id = Reference.TaskTicketId
				   JOIN WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
                   join MD_Client Clients on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm and Clients.Firm = @firm
                   join AbpUsers Users on Users.Id = Tickets.UserId
                   left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                   left join MD_PhotoComment Comments on files.Id = Comments.ReferenceId and Comments.SourceType = 2
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

          where Files.CreatedDate between @beginDate and @endDate
            and Files.Type = 3 and TaskAction.ActionType=1
            and Users.Id = @userId

          union all

          select Files.CreatedDate                                                          as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, ' ', Users.Surname)                                     as CreatorUserFullName,
                 Url                                                                        as Photo,
                 SecureUrl                                                                  as SecureUrl,
                 Clients.Code                                                               as ClientCode,
                 Clients.TigerId                                                            as ClientId,
                 Clients.Name                                                               as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, ' ', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, ' ', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, ' ', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 cast(0 as int)                                                             as TaskId,
                 1                                                                          as Type
          from CHL_Attachment Files with (nolock)
                   join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                   join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                   join AbpUsers Users with (nolock) on Users.Id = Response.UserId and Users.Id = @userId
                   join MD_Client Clients with (nolock)
                        on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm and Clients.Firm = @firm
                   left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                   left join MD_PhotoComment Comments on files.Id = Comments.ReferenceId and Comments.SourceType = 1
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

          where Files.Type = 3
            and Files.CreatedDate between @beginDate and @endDate 
            and Users.Id = @userId

          union all
          select Files.FileCreatedDate                                                      as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, ' ', Users.Surname)                                     as CreatorUserFullName,
                 Files.FilePath                                                             as Photo,
                 SecureUrl                                                                  as SecureUrl,
                 Client.Code                                                                as ClientCode,
                 Client.TigerId                                                             as ClientId,
                 Client.Name                                                                as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, ' ', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, ' ', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, ' ', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 ''                                                                         as TaskId,
                 3                                                                          as Type
          from OP_FileUploadLog Files with (nolock)
                   join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                   join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                   join OP_ClientVisitLog Visit with (nolock) on Visit.DocId = Files.DocId and Files.ContentType = 2
                   left join MD_PhotoLike Likes on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit
                   left join MD_PhotoStar Stars on (Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) -- Visit
                   left join MD_PhotoComment Comments
                             on (Files.Id = Comments.ReferenceId and Files.ContentType = 2 and Comments.SourceType = 3) -- Visit
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join WPM_PhotoTaskMapping Mapping with (nolock) on (Mapping.AttachmentId = Files.Id and Mapping.SourceType = 5) --Visit
          where Files.FileCreatedDate  between @beginDate and @endDate   and Files.ContentType=2
            and Users.Id = @UserId
          union all

          select Files.CreatedDate                                                          as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, ' ', Users.Surname)                                     as CreatorUserFullName,
                 Files.ImagePath                                                            as Photo,
                 Files.SecureUrl                                                            as SecureUrl,
                 Client.Code                                                                as ClientCode,
                 Client.TigerId                                                             as ClientId,
                 Client.Name                                                                as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, ' ', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, ' ', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, ' ', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 Mapping.TaskId                                                             as TaskId,
                 4                                                                          as Type
          from IM_InventoryStateHistoryImage Files with (nolock)
                   join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                   join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
                   join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
                   left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                   left join MD_PhotoStar Stars on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
                   left join MD_PhotoComment Comments on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join WPM_PhotoTaskMapping Mapping with (nolock) on Mapping.AttachmentId = Files.Id and Mapping.SourceType = 4
          where Files.CreatedDate  between @beginDate and @endDate
            and Users.Id = @UserId
          union all
          select Files.FileCreatedDate                                                      as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, ' ', Users.Surname)                                     as CreatorUserFullName,
                 Files.FilePath                                                             as Photo,
                 SecureUrl                                                                  as SecureUrl,
                 Client.Code                                                                as ClientCode,
                 Client.TigerId                                                             as ClientId,
                 Client.Name                                                                as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, ' ', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, ' ', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, ' ', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 ''                                                                         as TaskId,
                 5                                                                          as Type
          from OP_FileUploadLog Files with (nolock)
                   join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                   join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                   left join MD_PhotoLike Likes on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
                   left join MD_PhotoStar Stars on (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos
                   left join MD_PhotoComment Comments
                             on (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and Comments.SourceType = 5) -- Client photos
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join WPM_PhotoTaskMapping Mapping with (nolock) on (Mapping.AttachmentId = Files.Id and Mapping.SourceType = 3)
          where Files.FileCreatedDate  between @beginDate  and @endDate  and Files.ContentType=1
            and Users.Id = @UserId) Result

    order by DateTime desc
    offset @skipCount rows fetch next @takeCount rows only
END