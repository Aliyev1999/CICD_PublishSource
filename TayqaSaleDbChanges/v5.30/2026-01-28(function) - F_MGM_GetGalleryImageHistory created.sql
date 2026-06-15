CREATE OR ALTER     function [dbo].[F_MGM_GetGalleryImageHistory](@photoUrl nvarchar(max))
RETURNS TABLE
AS
RETURN
with TargetPhoto as (select Id, SourceType
                     from (select Id, SecureUrl, 1 SourceType
                           from Chl_Attachment with (nolock)
                           union all
                           select Id, SecureUrl, 2 SourceType
                           from Wpm_Attachment with (nolock) 
                           union all
                           select Id, SecureUrl, 3 SourceType
                           from Op_FileUploadLog with (nolock) 
                           union all
                           select Id, SecureUrl, 4 SourceType
                           from Im_InventoryStateHistoryImage with (nolock)
						   union all 
						   select Id, SecureUrl, 5 SourceType
                           from Op_FileUploadLog with (nolock) ) AllPhotos
					 where SecureUrl = @photoUrl ),
Data as(
select UserLike.UserName                                                     Username,
       LikeData.CreationTime Date,
       cast(iif(LikeData.Status = 1, 1, 2) as tinyint)                       ReactionStatus,
       null                                                                  Reason,
       null                                                                  Comment,
	   profiePhoto.SecureUrl                                                    ProfileImage
from Md_PhotoLike LikeData with (nolock)
         join TargetPhoto Photo on Photo.Id = LikeData.ReferenceId and Photo.SourceType = LikeData.SourceType
         join AbpUsers UserLike with (nolock) on UserLike.Id = LikeData.CreatorUserId
		 left join AbpUserProfilePhoto profiePhoto on LikeData.CreatorUserId = profiePhoto.UserId 

union all

select UserComment.UserName                                                     Username,
        CommentData.CreationTime Date,
       cast(0 as tinyint)                                                       ReactionStatus,
       StopReason.Description                                                   Reason,
       CommentData.Comment                                                      Comment,
       profiePhoto.SecureUrl                                                    ProfileImage
from Md_PhotoComment CommentData with (nolock)
         join TargetPhoto Photo on Photo.Id = CommentData.ReferenceId and Photo.SourceType = CommentData.SourceType
         join AbpUsers UserComment with (nolock) on UserComment.Id = CommentData.CreatorUserId
		 left join AbpUserProfilePhoto profiePhoto on CommentData.CreatorUserId = profiePhoto.UserId
         left join Md_StopReason StopReason on StopReason.Id = CommentData.ReasonId and StopReason.IsActive=1 and StopReason.IsDeleted=0)
Select top 10000000 * from Data order by Date desc
