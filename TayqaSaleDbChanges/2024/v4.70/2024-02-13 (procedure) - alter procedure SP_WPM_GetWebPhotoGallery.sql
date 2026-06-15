
ALTER procedure [dbo].[SP_WPM_GetWebPhotoGallery] @withTask bit = null,
                                                  @minDate datetime =null,
                                                  @maxDate datetime = null,
                                                  @clientNameOrCodeOrEdino nvarchar(max) =null,
                                                  @userSpecodes nvarchar(max) =null,
                                                  @clientSpecodes nvarchar(max)=null,
                                                  @userIds nvarchar(max)=null, --2,3,43
                                                  @likeStatus tinyint, --        Like = 1,Dislike = 2, Unvoted = 3, All = 4,
                                                  @taskStatus tinyint =null, --        NotStarted = 1, Proceeding = 2, Completed = 3,Stopped = 4
                                                  @photoSourceType tinyint =null, --         CheckList = 1,WorkPlan = 2,Visit=3,Inventory=4,Client=5
                                                  @taskActionMessage nvarchar(max)=null,
                                                  @stars nvarchar(max)=null, --2,3
                                                  @reasons nvarchar(max)=null, --2,3
                                                  @categories nvarchar(max)=null, --2,3
                                                  @subcategories nvarchar(max)=null, --2,3
                                                  @groups nvarchar(max)=null, --2,3
                                                  @surveyNameOrCode nvarchar(max)=null,
                                                  @questionNameOrCode nvarchar(max)=null,
                                                  @questionGroupName nvarchar(max)=null,
                                                  @questionAttachmentReasonValue nvarchar(max)=null,
                                                  @questionAttachmentReasonIds nvarchar(max)=null,--2,3
                                                  @taskName nvarchar(max)=null,
                                                  @skipCount int,
                                                  @takeCount int,
												  @currentUserId bigint,
                                                  @totalCount int out
as
begin

    declare @Query nvarchar(max) =('
    declare @Result table
                    (Id int, Url nvarchar(max), ReferenceId int, CreatedDate datetime, SourceType tinyint, ClientName nvarchar(max), ClientCode nvarchar(max),
    UserFullName nvarchar(max), LikeStatus bit, LikeDislikeDate datetime, LikeDislikeUser nvarchar(max),
                TaskCount int, Firm smallint, SourceRef nvarchar(max),  StarCount tinyint, SourceDetail nvarchar(max), ClientId int,  UserId bigint, SourceDetailMessage nvarchar(max));

    with MainData as (
   --CheckList
select distinct Files.Id                                           as Id,
                Files.SecureUrl                                    as Url,
                Files.ReferenceId                                  as ReferenceId,
                Files.CreatedDate                                  as CreatedDate,
                cast(1 as tinyint)                                 as SourceType,
                Client.Name                                        as ClientName,
                Client.Code                                        as ClientCode,
                concat(Users.Name, '' '', Users.Surname)           as UserFullName,
                Likes.Status                                       as LikeStatus,
                Likes.CreationTime                                 as LikeDislikeDate,
                concat(LikeUser.Name, '' '', LikeUser.Surname)     as LikeDislikeUser,
                isnull(TaskCountMain.TaskCount, 0)                 as TaskCount,
                Response.Firm                                      as Firm,
                Survey.Name                                        as SourceRef,
                isnull(Stars.StarCount, 0)                         as StarCount,
                Question.Name COLLATE SQL_Latin1_General_CP1_CI_AS as SourceDetail,
                Response.ClientId                                  as ClientId,
                Response.UserId                                    as UserId,
                ''''                                               as SourceDetailMessage,
                Client.Edino                                       as ClientEdino
FROM CHL_Attachment Files with (nolock)
         JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
         JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
         JOIN CHL_Question Question with (nolock) ON Details.QuestionId = Question.Id
         JOIN CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
         JOIN MD_Client Client with (nolock) on Client.TigerId = Response.ClientId and Response.Firm = Client.Firm
         JOIN AbpUsers Users with (nolock) on Users.Id = Response.UserId ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @Query =
                    CONCAT(@Query, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @Query = concat(@Query, ' 
		 left join MD_PhotoComment Comments with (nolock) on Files.Id = Comments.ReferenceId and Comments.SourceType = 1
         left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
         left join CHL_UserSurveyResponseDetailAttachmentReason AtachReas with (nolock)
                   on AtachReas.UserSurveyResponseDetailId = Files.ReferenceId and AtachReas.AttachmentId = Files.Id
         LEFT JOIN CHL_QuestionGroup qgroup with (nolock) on qgroup.Id = Question.QuestionGroupId
         LEFT JOIN CHL_Answer Answer with (nolock) ON Details.AnswerId = Answer.Id
         LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
         LEFT JOIN MD_PhotoStar Stars with (nolock) on files.Id = Stars.ReferenceId and Stars.SourceType = 1
         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
         LEFT JOIN (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    StopReasonId,
                                    IsCompleted as IsCompleted,
                                     iif( TT.TaskId IS NOT NULL ,1,0) as IsStarted
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)
                             join WPM_Task Task with (nolock) on Mapping.TaskId = Task.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 1) TaskCount
                   on TaskCount.AttachmentId = Files.Id and TaskCount.Firm = Response.Firm
         Left join (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    COUNT(Mapping.TaskId) as TaskCount
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)
                             join WPM_Task Task with (nolock) on Mapping.TaskId = Task.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 1
                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Response.Firm

WHERE Files.Type = 3
  and cast(Files.CreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date) ')
    if @taskStatus is not null and @withTask = 1
        set @Query = concat(@Query, case @taskStatus
                                        when 1 then ' and (TaskCount.IsStarted=0)'
                                        when 2 then ' and (TaskCount.IsCompleted=0)'
                                        when 3 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is null)'
                                        when 4 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is not null)'
            end)

    if @surveyNameOrCode is not null and @surveyNameOrCode != ''
        set @Query = concat(@Query, ' and (Survey.Name like ''%''+@surveyNameOrCode+''%'' or Survey.Code like ''%''+@surveyNameOrCode+''%'') ')
    if @questionNameOrCode is not null and @questionNameOrCode != ''
        set @Query =
                concat(@Query,
                       ' and (Question.Name COLLATE SQL_Latin1_General_CP1_CI_AS like ''%''+@questionNameOrCode+''%'' or Question.Code like ''%''+@questionNameOrCode+''%'') ')
    if @questionGroupName is not null and @questionGroupName != ''
        set @Query = concat(@Query, ' and (qgroup.Name like ''%''+@questionGroupName+''%'' or qgroup.Code like ''%''+@questionGroupName+''%'') ')
    if @questionAttachmentReasonIds is not null and @questionAttachmentReasonIds != ''
        set @Query = CONCAT(@Query, ' and (AtachReas.ReasonId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @questionAttachmentReasonIds, ''',',
                            ''','')))')

    if @reasons is not null and @reasons != ''
        set @Query =
                CONCAT(@Query, ' and (Reasons.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @reasons, ''',', ''','')))')
    set @Query = concat(@Query, '
        union all
    --WorkPlan
        --WorkPlan
select distinct Files.Id                                          as Id,
                Files.SecureUrl                                   as Url,
                Files.ReferenceId                                 as ReferenceId,
                Files.CreatedDate                                 as CreatedDate,
                cast(2 as tinyint)                                as SourceType,
                Client.Name                                       as ClientName,
                Client.Code                                       as ClientCode,
                concat(Users.Name, '' '', Users.Surname)          as UserFullName,
                Likes.Status                                      as LikeStatus,
                Likes.CreationTime                                as LikeDislikeDate,
                concat(LikeUser.Name, '' '', LikeUser.Surname)    as LikeDislikeUser,
                isnull(TaskCountMain.TaskCount, 0)                as TaskCount,
                Tickets.Firm                                      as Firm,
                Task.Name                                         as SourceRef,
                isnull(Stars.StarCount, 0)                        as StarCount,
                Task.Message COLLATE SQL_Latin1_General_CP1_CI_AS as SourceDetail,
                Tickets.ClientId                                  as ClientId,
                Tickets.UserId                                    as UserId,
                TaskAction.Message                                as SourceDetailMessage,
                Client.Edino                                      as ClientEdino
FROM WPM_Attachment Files with (nolock)
         JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
         JOIN WPM_TaskAction TaskAction with (nolock) ON TicketActions.ActionId = TaskAction.Id
         JOIN WPM_TaskTicket Tickets with (nolock) ON TicketActions.TaskTicketId = Tickets.Id
         JOIN WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
         JOIN MD_Client Client with (nolock) on Client.TigerId = Tickets.ClientId and Client.Firm = Tickets.Firm
         JOIN AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
		 ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @Query =
                    CONCAT(@Query, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @Query = concat(@Query, ' 
         LEFT JOIN MD_PhotoComment Comments with (nolock) on Files.Id = Comments.ReferenceId and Comments.SourceType = 2
         LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
         LEFT JOIN MD_PhotoStar Stars with (nolock) on files.Id = Stars.ReferenceId and Stars.SourceType = 2
         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
         LEFT JOIN MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
         LEFT JOIN (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    StopReasonId,
                                    IsCompleted                      as IsCompleted,
                                    iif(TT.TaskId IS NOT NULL, 1, 0) as IsStarted
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)
	
                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							where  Mapping.SourceType = 2) TaskCount
                   on TaskCount.AttachmentId = Files.Id and TaskCount.Firm = Tickets.Firm
         Left join (SELECT distinct Mapping.AttachmentId,
                                    Mapping.Firm,
                                    COUNT(distinct Mapping.TaskId) as TaskCount
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where  Mapping.SourceType = 2
                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Tickets.Firm
WHERE TaskAction.ActionType = 1
  and cast(Files.CreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date)
  AND Files.Type = 3 ')

    if @taskStatus is not null and @withTask = 1
        set @Query = concat(@Query, case @taskStatus
                                        when 1 then ' and (TaskCount.IsStarted=0)'
                                        when 2 then ' and (TaskCount.IsCompleted=0 )'
                                        when 3 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is null)'
                                        when 4 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is not null)'
            end)
    -- Task properties
    if @categories is not null and @categories != '' and @photoSourceType = 2
        set @Query = CONCAT(@Query, ' and (Task.CategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @categories, ''',', ''','')))')

    if @subcategories is not null and @subcategories != '' and @photoSourceType = 2
        set @Query =
                CONCAT(@Query, ' and (Task.SubcategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @subcategories, ''',', ''','')))')

    if @groups is not null and @groups != '' and @photoSourceType = 2
        set @Query = CONCAT(@Query, ' and (Task.GroupReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @groups, ''',', ''','')))')
    if @taskName is not null and @taskName != '' set @Query = concat(@Query, ' and (Task.Name like ''%''+@taskName+''%'' ) ');
    if @taskActionMessage is not null and @taskActionMessage != ''
        set @Query = concat(@Query, ' and (TaskAction.Message like ''%''+@taskActionMessage+''%'' ) ')
    if @reasons is not null and @reasons != ''
        set @Query =
                CONCAT(@Query, ' and (Reasons.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @reasons, ''',', ''','')))')
    set @Query = concat(@Query, '

        union all
    --ClientPhotos
 select distinct Files.Id                                        as Id,
                Files.SecureUrl                                 as Url,
                Files.Id                                        as ReferenceId,
                Files.FileCreatedDate                           as CreatedDate,
                CAST(5 as tinyint)                              as SourceType,
                Client.Name                                     as ClientName,
                Client.Code                                     as ClientCode,
                concat(Users.Name, '' '', Users.Surname)        as UserFullName,
                Likes.Status                                    as LikeStatus,
                Likes.CreationTime                              as LikeDislikeDate,
                concat(LikeUser.Name, '' '', LikeUser.Surname)  as LikeDislikeUser,
                isnull(TaskCountMain.TaskCount, 0)              as TaskCount,
                Files.Firm                                      as Firm,
                Reasons.Name                                    as SourceRef,
                isnull(Stars.StarCount, 0)                      as StarCount,
                Files.Note COLLATE SQL_Latin1_General_CP1_CI_AS as SourceDetail,
                Files.ClientId                                  as ClientId,
                Files.UploadedUserId                            as UserId,
                ''''                                            as SourceDetailMessage,
                Client.Edino                                    as ClientEdino
from OP_FileUploadLog Files with (nolock)
         JOIN MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Client.Firm = Files.Firm
         JOIN AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
		 ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @Query =
                    CONCAT(@Query, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @Query = concat(@Query, ' 
         LEFT JOIN MD_PhotoLike Likes with (nolock)
                   on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
         LEFT JOIN MD_PhotoStar Stars with (nolock)
                   on (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos
         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
         left join MD_PhotoComment Comments with (nolock)
                   on (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and Comments.SourceType = 5)
         left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
         LEFT JOIN (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    StopReasonId,
                                    IsCompleted                      as IsCompleted,
                                    iif(TT.TaskId IS NOT NULL, 1, 0) as IsStarted
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 5) TaskCount
                   on TaskCount.AttachmentId = Files.Id and TaskCount.Firm = Files.Firm
         Left join (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    COUNT(distinct Mapping.TaskId) as TaskCount
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 5
                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Files.Firm


where FileCreatedDate is not null
  and cast(Files.FileCreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date)
  and Files.ContentType = 1  ')
    if @taskStatus is not null and @withTask = 1
        set @Query = concat(@Query, case @taskStatus
                                        when 1 then ' and (TaskCount.IsStarted=0)'
                                        when 2 then ' and (TaskCount.IsCompleted=0)'
                                        when 3 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is null)'
                                        when 4 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is not null)'
            end)
    if @reasons is not null
        set @Query =
                CONCAT(@Query, ' and (Reasons.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @reasons, ''',', ''','')))')

    set @Query = concat(@Query, '
        union all
    --Inventory
        Select distinct Files.Id                                       as Id,
                Files.SecureUrl                                as Url,
                Files.Id                                       as ReferenceId,
                History.CreatedDate                            as CreatedDate,
                cast(4 as tinyint)                             as SourceType,
                Client.Name                                    as ClientName,
                Client.Code                                    as ClientCode,
                concat(Users.Name, '' '', Users.Surname)       as UserFullName,
                Likes.Status                                   as LikeStatus,
                Likes.CreationTime                             as LikeDislikeDate,
                concat(LikeUser.Name, '' '', LikeUser.Surname) as LikeDislikeUser,
                isnull(TaskCountMain.TaskCount, 0)             as TaskCount,
                History.Firm                                   as Firm,
                Inventory.RegistrationNr                       as SourceRef,
                isnull(Stars.StarCount, 0)                     as StarCount,
                '''' COLLATE SQL_Latin1_General_CP1_CI_AS      as SourceDetail,
                History.ClientTigerId                          as ClientId,
                History.CreatorUserId                          as UserId,
                Reason.Description                             as SourceDetailMessage,
                Client.Edino                                   as ClientEdino
from IM_InventoryStateHistoryImage Files with (nolock)
         join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
         join IM_Inventory Inventory with (nolock) on Inventory.Id = History.InventoryId and Inventory.Firm = History.Firm
         join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
         join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
		 ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @Query =
                    CONCAT(@Query, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @Query = concat(@Query, ' 
         left join IM_StaticContent Reason with (nolock) on Reason.Id = History.InventoryStateId and Reason.Type = 3
         left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
         left join MD_PhotoStar Stars with (nolock) on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
         left join MD_PhotoComment Comments with (nolock) on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
         left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
         LEFT JOIN (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    StopReasonId,
                                    IsCompleted                      as IsCompleted,
                                    iif(TT.TaskId IS NOT NULL, 1, 0) as IsStarted
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 4) TaskCount
                   on TaskCount.AttachmentId = Files.Id and TaskCount.Firm = History.Firm
         Left join (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    COUNT(distinct Mapping.TaskId) as TaskCount
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType = 4
                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = History.Firm
where cast(History.CreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date)')
    if @taskStatus is not null and @withTask = 1
        set @Query = concat(@Query, case @taskStatus
                                        when 1 then ' and (TaskCount.IsStarted=0)'
                                        when 2 then ' and (TaskCount.IsCompleted=0)'
                                        when 3 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is null)'
                                        when 4 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is not null)'
            end)
    if @reasons is not null
        set @Query =
                CONCAT(@Query, ' and (Reasons.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @reasons, ''',', ''','')))')
    set @Query = concat(@Query, '
        union all
    --Visits
     Select distinct Files.Id                                       as Id,
                Files.SecureUrl                                as Url,
                Visit.Id                                       as ReferenceId,
                Visit.CreatedDate                              as CreatedDate,
                cast(3 as tinyint)                             as SourceType,
                Client.Name                                    as ClientName,
                Client.Code                                    as ClientCode,
                concat(Users.Name, '' '', Users.Surname)       as UserFullName,
                Likes.Status                                   as LikeStatus,
                Likes.CreationTime                             as LikeDislikeDate,
                concat(LikeUser.Name, '' '', LikeUser.Surname) as LikeDislikeUser,
                isnull(TaskCountMain.TaskCount, 0)             as TaskCount,
                Files.Firm                                     as Firm,
                ''''                                           as SourceRef,
                isnull(Stars.StarCount, 0)                     as StarCount,
                '''' COLLATE SQL_Latin1_General_CP1_CI_AS      as SourceDetail,
                Files.ClientId                                 as ClientId,
                Files.UploadedUserId                           as UserId,
                Visit.Note                                     as SourceDetailMessage,
                Client.Edino                                   as ClientEdino
from OP_FileUploadLog Files with (nolock)
         join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
         join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
		 ')
		 IF (dbo.FN_UIM_CheckUserIsAdmin(@currentUserId) = 0)
        BEGIN
            SET @Query =
                    CONCAT(@Query, ' join F_UIM_GetOrganizationTreeUsers(@currentUserId) otu on Users.Id = otu.UserId')
        END
         
		    set @Query = concat(@Query, ' 
         join OP_ClientVisitLog Visit with (nolock) on Visit.DocId = Files.DocId and Files.ContentType = 2
         left join MD_PhotoLike Likes with (nolock) on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit
         left join MD_PhotoStar Stars with (nolock) on (Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) -- Visit
         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
         left join MD_PhotoComment Comments with (nolock)
                   on (Files.Id = Comments.ReferenceId and Files.ContentType = 2 and Comments.SourceType = 3) -- Client photos
         left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
         LEFT JOIN (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    StopReasonId,
                                    IsCompleted                      as IsCompleted,
                                    iif(TT.TaskId IS NOT NULL, 1, 0) as IsStarted
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId 
							 where Mapping.SourceType=3) TaskCount
                   on TaskCount.AttachmentId = Files.Id and TaskCount.Firm = Files.Firm
         Left join (SELECT DISTINCT Mapping.AttachmentId,
                                    Mapping.Firm,
                                    COUNT(distinct Mapping.TaskId) as TaskCount
                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                             join WPM_Task Task with (nolock) on Mapping.TaskId = Task.Id
                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId
				     where Mapping.SourceType=3
                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Files.Firm
where Files.FilePath is not null
  and cast(Visit.CreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date)
          and Files.FilePath != ''''')
    if @taskStatus is not null and @withTask = 1
        set @Query = concat(@Query, case @taskStatus
                                        when 1 then ' and (TaskCount.IsStarted=0)'
                                        when 2 then ' and (TaskCount.IsCompleted=0)'
                                        when 3 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is null)'
                                        when 4 then ' and (TaskCount.IsCompleted=1 and TaskCount.StopReasonId is not null)'
            end)
    if @reasons is not null
        set @Query =
                CONCAT(@Query, ' and (Reasons.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @reasons, ''',', ''','')))')

    set @Query = concat(@Query, '),
	NextData as (
    select  MainData.Id, MainData.Url, MainData.ReferenceId, MainData.CreatedDate, MainData.SourceType, MainData.ClientName, MainData.ClientCode,
    MainData.UserFullName, MainData.LikeStatus, MainData.LikeDislikeDate, MainData.LikeDislikeUser,
                MainData.TaskCount, MainData.Firm, MainData.SourceRef,  MainData.StarCount, MainData.SourceDetail, MainData.ClientId,  MainData.UserId, MainData.SourceDetailMessage
    from MainData
    left join UIM_UserProperty Specodes with(nolock) on MainData.UserId=Specodes.UserId  and MainData.Firm=Specodes.Firm
	left join MD_Client CSpecodes with(nolock) on MainData.ClientId=CSpecodes.TigerId and MainData.Firm=CSpecodes.Firm
    where 1=1 ')


    if @clientNameOrCodeOrEdino is not null
        set @Query = concat(@Query,
                            ' and (MainData.ClientCode like ''%''+@clientNameOrCodeOrEdino+''%'' or MainData.ClientName like ''%''+@clientNameOrCodeOrEdino +''%'' or MainData.ClientEdino like ''%''+@clientNameOrCodeOrEdino +''%'') ')
    if @userIds is not null
        set @Query = concat(@Query, ' and MainData.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(@userIds, '','')) ')
    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specodes.Specode1 like ''%''+@userSpecodes+''%'' or Specodes.Specode2 like ''%''+@userSpecodes+''%'' or Specodes.Specode3 like ''%''+@userSpecodes+''%'' or Specodes.Specode4 like ''%''+@userSpecodes+''%''or Specodes.Specode5 like ''%''+@userSpecodes+''%'') ')
    if @clientSpecodes is not null
        set @Query = concat(@Query,
                            ' and (CSpecodes.SpecialCode like ''%''+@clientSpecodes+''%'' or CSpecodes.SpecialCode2 like ''%''+@clientSpecodes+''%'' or CSpecodes.SpecialCode3 like ''%''+@clientSpecodes+''%''
                            or CSpecodes.SpecialCode4 like ''%''+@clientSpecodes+''%'' or CSpecodes.SpecialCode5 like ''%''+@clientSpecodes+''%''
                            ) ');
    if @withTask is not null
        set @Query = concat(@Query, case @withTask
                                        when 1 then ' and MainData.TaskCount!=0 '
                                        when 0 then ' and MainData.TaskCount=0 '
            end);
    if @stars is not null
        set @Query = CONCAT(@Query, ' and (MainData.StarCount IN (SELECT LTRIM(Value) FROM F_SplitList(''', @stars, ''',', ''','')))')
    if @photoSourceType is not null
        set @Query = concat(@Query, ' and @photoSourceType =MainData.SourceType ')
    if @likeStatus is not null and @likeStatus <> 4
        set @Query = concat(@Query,
                            case @likeStatus
                                when 1 then ' and MainData.LikeStatus=1 '
                                when 2 then ' and MainData.LikeStatus=0'
                                when 3 then ' and MainData.LikeStatus is null'
                                end)

    set @Query = concat(@Query, ')
	insert into @Result (Id, Url, ReferenceId, CreatedDate, SourceType, ClientName, ClientCode, UserFullName, LikeStatus, LikeDislikeDate, LikeDislikeUser,
                TaskCount, Firm, SourceRef,  StarCount, SourceDetail, ClientId,  UserId, SourceDetailMessage)

    select * from NextData

set @totalCount = (select count(*) from @Result) -- get total count


select * from @Result
')

    if @skipCount is not null or @takeCount is not null
        set @Query = concat(@Query, ' ORDER BY  CreatedDate desc offset @skipCount rows fetch next @takeCount rows only')

    PRINT CAST(@Query AS NTEXT);
    exec sp_executesql @Query, N'  @withTask bit ,
    @minDate datetime,
    @maxDate datetime,
    @clientNameOrCodeOrEdino nvarchar(max),
    @userSpecodes nvarchar(max),
    @clientSpecodes nvarchar(max),
    @userIds nvarchar(max),
    @likeStatus tinyint,
    @taskStatus tinyint ,
    @photoSourceType tinyint ,
    @taskActionMessage nvarchar(max),
    @stars nvarchar(max),
    @reasons nvarchar(max),
	@currentUserId bigint,
    @categories nvarchar(max),
    @subcategories nvarchar(max),
    @groups nvarchar(max),
    @surveyNameOrCode nvarchar(max),
    @questionNameOrCode nvarchar(max),
    @questionGroupName nvarchar(max),
    @questionAttachmentReasonValue nvarchar(max),
    @questionAttachmentReasonIds nvarchar(max),
    @taskName nvarchar(max),
    @skipCount int,
    @takeCount int,
	@totalCount int out',
         @withTask=@withTask,
         @minDate=@minDate,
         @maxDate=@maxDate,
         @clientNameOrCodeOrEdino=@clientNameOrCodeOrEdino,
         @userSpecodes=@userSpecodes,
         @clientSpecodes=@clientSpecodes,
         @userIds=@userIds,
         @likeStatus=@likeStatus,
         @taskStatus=@taskStatus,
         @photoSourceType=@photoSourceType,
         @taskActionMessage=@taskActionMessage,
         @stars=@stars,
         @reasons=@reasons,
		 @currentUserId=@currentUserId,
         @categories=@categories,
         @subcategories=@subcategories,
         @groups=@groups,
         @surveyNameOrCode=@surveyNameOrCode,
         @questionNameOrCode=@questionNameOrCode,
         @questionGroupName=@questionGroupName,
         @questionAttachmentReasonValue=@questionAttachmentReasonValue,
         @questionAttachmentReasonIds=@questionAttachmentReasonIds,
         @taskName=@taskName,
         @skipCount=@skipCount,
         @takeCount=@takeCount,
         @totalCount=@totalCount out

end


