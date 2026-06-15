CREATE   procedure [dbo].[SP_RM_GetPhotoReport] @userId bigint, @firm smallint,@attachmentId int ,@sourceType tinyint
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

	   SET @Query =
            '
    select DateTime,
           CreatorUserName,
           CreatorUserFullName,
           Photo,
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
    from ('
	IF @sourceType =2
	SET @Query = CONCAT(@Query, ' select Files.CreatedDate															as DateTime,
										 Users.UserName                                                             as CreatorUserName,
										 concat(Users.Name, '' '', Users.Surname)                                     as CreatorUserFullName,
										 Url                                                                        as Photo,
										 Clients.Code                                                               as ClientCode,
										 Clients.TigerId                                                            as ClientId,
										 Clients.Name                                                               as ClientName,
										 Likes.Status                                                               as LikeStatus,
										 Stars.StarCount                                                            as StarCount,
										 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
										 case
											 when LikedUser.Id is not null then concat(LikedUser.Name, '' '', LikedUser.Surname)
											 when CommentedUser.Id is not null then concat(CommentedUser.Name, '' '', CommentedUser.Surname)
											 when StarredUser.Id is not null then concat(StarredUser.Name, '' '', StarredUser.Surname)
											 else null
											 end                                                                    as CommentedUserFullName,
										 Reasons.Description                                                        as CommentReason,
										 Comments.Comment                                                           as CommentText,
										 TasksMapping.TaskId                                                        as TaskId,
										 2                                                                          as Type

          from WPM_Attachment Files
                   join WPM_TaskTicketAction Reference on Files.ReferenceId = reference.Id
                   join WPM_TaskTicket Tickets on Tickets.Id = Reference.TaskTicketId
                   join MD_Client Clients on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm and Clients.Firm = @firm
                   join AbpUsers Users on Users.Id = Tickets.UserId
                   left join WPM_PhotoTaskMapping TasksMapping on TasksMapping.AttachmentId = Files.Id
                   left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                   left join MD_PhotoComment Comments on files.Id = Comments.ReferenceId and Comments.SourceType = 2
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

          where   Files.Type = 3
            and Users.Id = @userId
			and Files.Id=@attachmentId ')

		IF @sourceType =1
		SET @Query = CONCAT(@Query, '
          select Files.CreatedDate                                                          as DateTime,
                 Users.UserName                                                             as CreatorUserName,
                 concat(Users.Name, '' '', Users.Surname)                                     as CreatorUserFullName,
                 Url                                                                        as Photo,
                 Clients.Code                                                               as ClientCode,
                 Clients.TigerId                                                            as ClientId,
                 Clients.Name                                                               as ClientName,
                 Likes.Status                                                               as LikeStatus,
                 Stars.StarCount                                                            as StarCount,
                 coalesce(LikedUser.UserName, CommentedUser.UserName, StarredUser.UserName) as CommentedUserName,
                 case
                     when LikedUser.Id is not null then concat(LikedUser.Name, '' '', LikedUser.Surname)
                     when CommentedUser.Id is not null then concat(CommentedUser.Name, '' '', CommentedUser.Surname)
                     when StarredUser.Id is not null then concat(StarredUser.Name, '' '', StarredUser.Surname)
                     else null
                     end                                                                    as CommentedUserFullName,
                 Reasons.Description                                                        as CommentReason,
                 Comments.Comment                                                           as CommentText,
                 TasksMapping.TaskId                                                        as TaskId,
                 1                                                                          as Type
          from CHL_Attachment Files with (nolock)
                   join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                   join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                   join AbpUsers Users with (nolock) on Users.Id = Response.UserId and Users.Id = @userId
                   join MD_Client Clients with (nolock)
                        on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm and Clients.Firm = @firm
                   left join WPM_PhotoTaskMapping TasksMapping on TasksMapping.AttachmentId = Files.Id
                   left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                   left join MD_PhotoComment Comments on files.Id = Comments.ReferenceId and Comments.SourceType = 1
                   left join AbpUsers LikedUser on LikedUser.Id = Likes.CreatorUserId
                   left join AbpUsers CommentedUser on CommentedUser.Id = Comments.CreatorUserId
                   left join AbpUsers StarredUser on StarredUser.Id = Stars.CreatorUserId
                   left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

          where Files.Type = 3
            and Users.Id = @userId
			and Files.Id=@attachmentId')
		SET @Query = CONCAT(@Query, ' ) Result

    order by DateTime desc')
	
    PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
								 @userId bigint,
								 @attachmentId int,
								 @sourceType tinyint',
         @firm=@firm,
         @userId=@userId,
         @attachmentId = @attachmentId,
         @sourceType = @sourceType
END
