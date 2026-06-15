
Create procedure SP_WPM_GetPhotoGalleryReport 
(
	@startDate date, 
	@endDate date, 
	@firm smallint, 
	@userId int, 
	@skipCount int, 
	@takeCount int, 
	@totalImageCount int out
)
As
Begin
	set @totalImageCount = 1;
	declare @Result table 
					(ClientCode nvarchar(255), ClientName nvarchar(255), CreatedUserName nvarchar(255), LikeStatus bit, StarCount tinyint,
					 PhotoAddress nvarchar(max), SecureUrl nvarchar(max), Comment nvarchar(max), CreationDate datetime, Reason nvarchar(255),
					 AttachmentId int, LikeUserId bigint, CommentUserId bigint, StarUserId bigint, SourceType int);
insert into @Result
	select *
        from (select Clients.Code           as ClientCode,
                     Clients.Name           as ClientName,
                     Users.UserName         as CreatedUserName,
                     Likes.Status           as LikeStatus,
                     Stars.StarCount        as StarCount,
                     Files.Url              as PhotoAddress,
                     Files.SecureUrl        as SecureUrl,
                     Comments.Comment       as Comment,
                     Files.CreatedDate      as CreationDate,
                     Reasons.Description    as Reason,
                     Files.Id               as AttachmentId,
                     Likes.CreatorUserId    as LikeUserId,
                     Comments.CreatorUserId as CommentUserId,
                     Stars.CreatorUserId    as StarUserId,
                     2                      as SourceType
              from WPM_Attachment Files

                       join WPM_TaskTicketAction Reference on Files.ReferenceId = reference.Id
                       join WPM_TaskTicket Tickets on Tickets.Id = Reference.TaskTicketId
                       join MD_Client Clients on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm and Clients.Firm = @firm
                       join AbpUsers Users on Users.Id = Tickets.UserId
                       join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers on StructureUsers.UserId = Users.Id
                       left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                       left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                       left join MD_PhotoComment Comments on files.Id = Comments.ReferenceId and Comments.SourceType = 2
                       left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

              where cast(Files.CreatedDate as date) between @startDate and @endDate
                and Files.Type = 3

              union all

              select Clients.Code           as ClientCode,
                     Clients.Name           as ClientName,
                     Users.UserName         as CreatedUserName,
                     Likes.Status           as LikeStatus,
                     Stars.StarCount        as StarCount,
                     Files.Url              as PhotoAddress,
                     Files.SecureUrl        as SecureUrl,
                     Comments.Comment       as Comment,
                     Files.CreatedDate      as CreationDate,
                     Reasons.Description    as Reason,
                     Files.Id               as AttachmentId,
                     Likes.CreatorUserId    as LikeUserId,
                     Comments.CreatorUserId as CommentUserId,
                     Stars.CreatorUserId    as StarUserId,
                     1                      as SourceType
              from CHL_Attachment Files with (nolock)
                       join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                       join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                       join AbpUsers Users with (nolock) on Users.Id = Response.UserId
                       join MD_Client Clients with (nolock)
                            on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm and Clients.Firm = @firm
                       join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                       left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                       left join MD_PhotoStar Stars on Stars.ReferenceId = Files.Id and Stars.SourceType = 1
                       left join MD_PhotoComment Comments on Comments.ReferenceId = Files.Id and Comments.SourceType = 1
                       left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId
					   --join SPEC_UserSurveyMapping map on map.SurveyId = Response.SurveyId and Response.UserId = map.UserId
              where Files.Type = 3
                and cast(Files.CreatedDate as date) between @startDate and @endDate


              union all

              select Client.Code                                      as ClientCode,
                     Client.Name                                      as ClientName,
                     Users.UserName                                   as CreatedUserName,
                     Likes.Status                                     as LikeStatus,
                     Stars.StarCount                                  as StarCount,
                     Files.FilePath                                   as PhotoAddress,
                     Files.SecureUrl                                  as SecureUrl,
                     Comments.Comment                                 as Comment,
                     Files.FileCreatedDate                            as CreationDate,
                     Reasons.Description                              as Reason,
                     Files.Id                                         as AttachmentId,
                     Likes.CreatorUserId                              as LikeUserId,
                     Comments.CreatorUserId                           as CommentUserId,
                     Stars.CreatorUserId                              as StarUserId,
                     case ContentType when 1 then 5 when 2 then 3 end as SourceType
              from OP_FileUploadLog Files with (nolock)
                       join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                       join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                       join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                       left join MD_PhotoLike Likes on 
									(Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) or -- Visit
                                    (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos

                       left join MD_PhotoStar Stars on 
					   				(Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) or -- Visit
                                    (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos

                       left join MD_PhotoComment Comments on
					   				(Files.Id = Comments.ReferenceId and Files.ContentType = 2 and Comments.SourceType = 3) or -- Visit
                                    (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and Comments.SourceType = 5) -- Client photos
                       left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

              where cast(Files.FileCreatedDate as date) between @startDate and @endDate

              union all

              select Client.Code            as ClientCode,
                     Client.Name            as ClientName,
                     Users.UserName         as CreatedUserName,
                     Likes.Status           as LikeStatus,
                     Stars.StarCount        as StarCount,
                     Files.ImagePath        as PhotoAddress,
                     Files.SecureUrl        as SecureUrl,
                     Comments.Comment       as Comment,
                     Files.CreatedDate      as CreationDate,
                     Reasons.Description    as Reason,
                     Files.Id               as AttachmentId,
                     Likes.CreatorUserId    as LikeUserId,
                     Comments.CreatorUserId as CommentUserId,
                     Stars.CreatorUserId    as StarUserId,
                     4                      as SourceType
              from IM_InventoryStateHistoryImage Files with (nolock)
                       join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                       join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
                       join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
                       join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                       left join MD_PhotoLike Likes on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                       left join MD_PhotoStar Stars on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
                       left join MD_PhotoComment Comments on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
                       left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

              where cast(Files.CreatedDate as date) between @startDate and @endDate) Result

		set @totalImageCount = (select count(*) from @Result)

		select * from @Result where 1 = 1
        order by CreationDate desc
        offset @skipCount rows fetch next @takeCount rows only

End