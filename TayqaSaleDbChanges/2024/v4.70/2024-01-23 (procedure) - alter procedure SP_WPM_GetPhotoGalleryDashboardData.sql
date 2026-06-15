ALTER procedure [dbo].[SP_WPM_GetPhotoGalleryDashboardData] @beginDate date,@endDate date, @currentUserId bigint
as
begin
   DECLARE @sql nvarchar(max);
    SET @sql = '
with MainData as (select distinct Files.SecureUrl    AS Url,
                                  Files.CreatedDate  as Date,
                                  Likes.Status       as LikeStatus,
                                  cast(1 as tinyint) as SourceType

                  FROM CHL_Attachment Files with (nolock)
                           JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                           JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                           JOIN CHL_Question Question with (nolock) ON Details.QuestionId = Question.Id
                           JOIN CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
                           JOIN MD_Client Client with (nolock) on Client.TigerId = Response.ClientId and Response.Firm = Client.Firm
                           JOIN AbpUsers Users with (nolock) on Users.Id = Response.UserId
						   '
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @sql = concat(@sql, '
                           LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1

                  WHERE Files.Type = 3  and cast(Files.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                  union all

                  select distinct Files.SecureUrl    AS Url,
                                  Files.CreatedDate  as Date,
                                  Likes.Status       as LikeStatus,
                                  cast(2 as tinyint) as SourceType
                  FROM WPM_Attachment Files with (nolock)
                           JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
                           JOIN WPM_TaskAction TaskAction with (nolock) ON TicketActions.ActionId = TaskAction.Id
                           join WPM_TaskActionType ActType with (nolock) on ActType.Id = TaskAction.ActionType
                           JOIN WPM_TaskTicket Tickets with (nolock) ON TicketActions.TaskTicketId = Tickets.Id
                           JOIN WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
                           JOIN MD_Client Client with (nolock) on Client.TigerId = Tickets.ClientId and Client.Firm = Tickets.Firm
                           JOIN AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
						   ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @sql = concat(@sql, '
                           LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                  WHERE TaskAction.ActionType = 1
                    AND Files.Type = 3 and cast(Files.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                  union all

                  select distinct Files.SecureUrl       AS Url,
                                  Files.FileCreatedDate as Date,
                                  Likes.Status          as LikeStatus,
                                  cast(3 as tinyint)    as SourceType
                  from OP_FileUploadLog Files with (nolock)
                           JOIN MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Client.Firm = Files.Firm
                           JOIN AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
						   ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @sql = concat(@sql, '
                           LEFT JOIN MD_PhotoLike Likes with (nolock)
                                     on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
                  where FileCreatedDate is not null and cast(Files.FileCreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
                    and Files.ContentType = 1

                  union all

                  select distinct Files.SecureUrl    AS Url,
                                  Files.CreatedDate  as Date,
                                  Likes.Status       as LikeStatus,
                                  cast(4 as tinyint) as SourceType
                  from IM_InventoryStateHistoryImage Files with (nolock)
                           join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                           join IM_Inventory Inventory with (nolock) on Inventory.Id = History.InventoryId and Inventory.Firm = History.Firm
                           join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
                           join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
						   ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @sql = concat(@sql, '
                           left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                  where cast(Files.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                  union all

                  select distinct Files.SecureUrl       AS Url,
                                  Files.FileCreatedDate as Date,
                                  Likes.Status          as LikeStatus,
                                  cast(5 as tinyint)    as SourceType
                  from OP_FileUploadLog Files with (nolock)
                           join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                           join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
						   ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @sql = concat(@sql, '
                           join OP_ClientVisitLog Visit with (nolock) on Visit.DocId = Files.DocId and Files.ContentType = 2
                           left join MD_PhotoLike Likes with (nolock)
                                     on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit

                  where Files.FilePath is not null and cast(Files.FileCreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
                    and Files.FilePath != ''''),
     Counts as (select iif(MainData.SourceType = 2, count(Url), 0)     as WpmPhotoCount,
                       iif(MainData.SourceType = 1, count(Url), 0)     as ChecklistPhotoCount,
                       iif(MainData.LikeStatus = 0, count(Url), 0)     as DislikedPhotoCount,
                       iif(MainData.LikeStatus = 1, count(Url), 0)     as LikedPhotoCount,
                       iif(MainData.LikeStatus is null, count(Url), 0) as NonLikedPhotoCount
                from MainData
                
                group by MainData.SourceType, MainData.LikeStatus)
select isnull(sum(WpmPhotoCount),0)       as WpmPhotoCount,
       isnull(sum(ChecklistPhotoCount),0) as ChecklistPhotoCount,
       isnull(sum(DislikedPhotoCount),0)  as DislikedPhotoCount,
       isnull(sum(LikedPhotoCount),0)     as LikedPhotoCount,
       isnull(sum(NonLikedPhotoCount),0)  as NonLikedPhotoCount
from Counts')

 print @sql
    execute sp_executesql @sql,
            N' @beginDate date,
			@endDate date,
			@currentUserId bigint',
            @beginDate=@beginDate,
			@endDate=@endDate,
			@currentUserId=@currentUserId
	
end