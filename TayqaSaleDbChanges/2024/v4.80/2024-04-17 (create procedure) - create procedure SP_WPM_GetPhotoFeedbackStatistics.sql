create procedure [dbo].[SP_WPM_GetPhotoFeedbackStatistics] @firm nvarchar(100),
                                                          @users nvarchar(max),
                                                          @startDate datetime,
                                                          @endDate datetime,
                                                          @sourceType nvarchar(100),
                                                          @categories nvarchar(max),
                                                          @subcategories nvarchar(max),
                                                          @groups nvarchar(max),
                                                          @questionNameOrCode nvarchar(100),
                                                          @surveyNameOrCode nvarchar(100),
                                                          @questionGroupName nvarchar(100),
                                                          @taskName nvarchar(100),
                                                          @currentUserId bigint
as
begin
    declare @sql nvarchar(max);
    set @sql = '
with MainData as (select Response.UserId	                                as UserId,
						 Response.ClientId                                  as ClientId,
						 iif(Likes.Status  = 0, count(distinct Url), 0)     as DislikedPhotoCount,
                         iif(Likes.Status  = 1, count(distinct Url), 0)     as LikedPhotoCount,
                         iif(Likes.Status  is null, count(distinct Url), 0) as NonLikedPhotoCount
                  from CHL_Attachment Files with (nolock)
                           join CHL_UserSurveyResponseDetail Details with (nolock) on Files.ReferenceId = Details.Id
                           join CHL_UserSurveyResponse Response with (nolock) on Details.UserSurveyResponseId = Response.Id
                           join CHL_Question Question with (nolock) on Details.QuestionId = Question.Id
                           join CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
						   join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = Response.UserId
                           left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
						   left join CHL_QuestionGroup qgroup with (nolock) on qgroup.Id = Question.QuestionGroupId
                  where Files.Type = 3  and cast(Files.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
				        and @firm = Response.Firm '

    if @surveyNameOrCode is not null and @surveyNameOrCode != ''
        set @sql = concat(@sql, ' and (Survey.Name like ''%''+@surveyNameOrCode+''%'' or Survey.Code like ''%''+@surveyNameOrCode+''%'') ')
    if @sourceType is not null
        set @sql = concat(@sql, ' and (@sourceType = 1) ');
    if @questionNameOrCode is not null and @questionNameOrCode != ''
        set @sql =
                concat(@sql,
                       ' and (Question.Name collate SQL_Latin1_General_CP1_CI_AS like ''%''+@questionNameOrCode+''%'' or Question.Code like ''%''+@questionNameOrCode+''%'') ')
    if @questionGroupName is not null and @questionGroupName != ''
        set @sql = concat(@sql, ' and (qgroup.Name like ''%''+@questionGroupName+''%'' or qgroup.Code like ''%''+@questionGroupName+''%'') ')

    set @sql = concat(@sql, 'group by Response.UserId,Response.ClientId,Likes.Status ')

    set @sql = concat(@sql, '        union all

                  select Tickets.UserId	                                    as UserId,
						 Tickets.ClientId                                   as ClientId,
						 iif(Likes.Status  = 0, count(distinct Url), 0)     as DislikedPhotoCount,
                         iif(Likes.Status  = 1, count(distinct Url), 0)     as LikedPhotoCount,
                         iif(Likes.Status  is null, count(distinct Url), 0) as NonLikedPhotoCount
                  from WPM_Attachment Files with (nolock)
                           join WPM_TaskTicketAction TicketActions with (nolock) on Files.ReferenceId = TicketActions.Id
                           join WPM_TaskAction TaskAction with (nolock) on TicketActions.ActionId = TaskAction.Id
                           join WPM_TaskActionType ActType with (nolock) on ActType.Id = TaskAction.ActionType
                           join WPM_TaskTicket Tickets with (nolock) on TicketActions.TaskTicketId = Tickets.Id
                           join WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
						   join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = Tickets.UserId
                           left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                  where TaskAction.ActionType = 1
                    and Files.Type = 3 and cast(Files.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
					and @firm= Tickets.Firm ')
    if @categories is not null and @categories != '' and @sourceType = 2
        set @sql = concat(@sql, ' and (Task.CategoryReason in (select ltrim(Value) from F_SplitList(''', @categories, ''',', ''','')))')

    if @subcategories is not null and @subcategories != '' and @sourceType = 2
        set @sql =
                concat(@sql, ' and (Task.SubcategoryReason in (select ltrim(Value) from F_SplitList(''', @subcategories, ''',', ''','')))')

    if @groups is not null and @groups != '' and @sourceType = 2
        set @sql = concat(@sql, ' and (Task.GroupReason in (select ltrim(Value) from F_SplitList(''', @groups, ''',', ''','')))')

    if @sourceType is not null
        set @sql = concat(@sql, ' and (@sourceType = 2) ');

    if @taskName is not null and @taskName != '' set @sql = concat(@sql, ' and (Task.Name like ''%''+@taskName+''%'' ) ');

    set @sql = concat(@sql, 'group by Tickets.UserId, Tickets.ClientId,Likes.Status ')
    set @sql = concat(@sql, ' union all

                  select Files.UploadedUserId	                                        as UserId,
						 Files.ClientId                                                 as ClientId,
						 iif(Likes.Status  = 0, count(distinct Files.SecureUrl), 0)     as DislikedPhotoCount,
                         iif(Likes.Status  = 1, count(distinct Files.SecureUrl), 0)     as LikedPhotoCount,
                         iif(Likes.Status  is null, count(distinct Files.SecureUrl), 0) as NonLikedPhotoCount
                  from OP_FileUploadLog Files with (nolock)
				  join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = Files.UploadedUserId
                  left join MD_PhotoLike Likes with (nolock)
                                     on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
                  where FileCreatedDate is not null and cast(Files.FileCreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
                    and Files.ContentType = 1 and @firm=Files.Firm ')
    if @sourceType is not null
        set @sql = concat(@sql, ' and (@sourceType = 5) ');
    set @sql = concat(@sql, 'group by Files.UploadedUserId, Files.ClientId ,Likes.Status ')
    set @sql = concat(@sql, '    union all

                  select  History.CreatorUserId as UserId,
						  History.ClientTigerId as ClientId,
						  iif(Likes.Status  = 0, count(distinct Files.SecureUrl), 0)     as DislikedPhotoCount,
                          iif(Likes.Status  = 1, count(distinct Files.SecureUrl), 0)     as LikedPhotoCount,
                          iif(Likes.Status  is null, count(distinct Files.SecureUrl), 0) as NonLikedPhotoCount
                  from IM_InventoryStateHistoryImage Files with (nolock)
                           join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                           join IM_Inventory Inventory with (nolock) on Inventory.Id = History.InventoryId and Inventory.Firm = History.Firm
						   join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = History.CreatorUserId
                           left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                  where cast(Files.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
				  and @firm=History.Firm
				  ')
    if @sourceType is not null
        set @sql = concat(@sql, ' and (@sourceType = 4) ');
    set @sql = concat(@sql, 'group by History.CreatorUserId, History.ClientTigerId ,Likes.Status ')

    set @sql = concat(@sql, '    union all

                  select Files.UploadedUserId  as UserId,
						 Files.ClientId        as ClientId,
						 iif(Likes.Status  = 0, count(distinct Files.SecureUrl), 0)     as DislikedPhotoCount,
                         iif(Likes.Status  = 1, count(distinct Files.SecureUrl), 0)     as LikedPhotoCount,
                         iif(Likes.Status  is null, count(distinct Files.SecureUrl), 0) as NonLikedPhotoCount
                  from OP_FileUploadLog Files with (nolock)
				  join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = Files.UploadedUserId
                  join OP_ClientVisitLog Visit with (nolock) on Visit.DocId = Files.DocId and Files.ContentType = 2
                  left join MD_PhotoLike Likes with (nolock)
                                     on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit

                  where Files.FilePath is not null and cast(Files.FileCreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
					and @firm=Files.Firm   and Files.FilePath != ''''

					')
    if @sourceType is not null
        set @sql = concat(@sql, ' and (@sourceType = 3) ');
    set @sql = concat(@sql, 'group by Files.UploadedUserId, Files.ClientId ,Likes.Status ')
    set @sql = concat(@sql, '   ),

	 Clients as (select Route.UserId,
						TigerClientId as ClientId
					from MD_Route Route with(nolock)
					join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = Route.UserId
					where Status=0 and cast(Date as date) between cast(@startDate as date) and cast(@endDate as date) and Route.Firm=@firm

					union

					select TaskUser.UserId as UserId,
						   Client.ClientId as ClientId
					from WPM_TaskUser TaskUser with(nolock)
						 join WPM_Task Task with(nolock) on TaskUser.TaskId=Task.Id
						 join WPM_TaskClient Client with(nolock) on Client.TaskId=Task.Id
						 join F_GetAllPermittedUsers(@currentUserId) PUsers on PUsers.UserId  = TaskUser.UserId
					where Task.Type in (1,4) and cast(Task.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date) and Task.Firm=@firm

					),


     Counts as (select sum(DislikedPhotoCount)      as DislikedPhotoCount,
                       sum(LikedPhotoCount)         as LikedPhotoCount,
                       sum(NonLikedPhotoCount)      as NonLikedPhotoCount,
					   iif(MainData.ClientId is null,count(Clients.ClientId),0) as NoPhotoClientCount,
					   coalesce(MainData.UserId,Clients.UserId) as UserId
                from MainData
				full outer join Clients on MainData.ClientId=Clients.ClientId and MainData.UserId=Clients.UserId


     group by MainData.ClientId,coalesce(MainData.UserId,Clients.UserId)),


Last as(
select Users.Id as UserId,
	   concat(Users.Name, '' '', Users.Surname)           as UserFullName,
	   isnull(sum(NonLikedPhotoCount),0)+isnull(sum(DislikedPhotoCount),0)+isnull(sum(LikedPhotoCount),0) as TotalCount,
	   isnull(sum(LikedPhotoCount),0)     as LikedCount,
	   isnull(sum(DislikedPhotoCount),0)  as DislikedCount,
	   isnull(sum(NonLikedPhotoCount),0)  as UnvotedCount,
	   isnull(sum(NoPhotoClientCount),0)  as NoPhotoClientCount
from Counts
	join AbpUsers Users with(nolock) on Counts.UserId=Users.Id ')

    if @users is not null
        set @sql = concat(@sql, ' and Users.Id in (select ltrim(Value) from F_SplitList(@users, '','')) ')
    set @sql = concat(@sql, '

group by Users.Id,concat(Users.Name, '' '', Users.Surname))

select * from Last  

')
if @sourceType is not null
	set @sql=concat(@sql, ' where TotalCount>0')
print cast(@sql as NTEXT)
    execute sp_executesql @sql,
            N'  @firm nvarchar(100),
				@users nvarchar(max),
				@startDate datetime,
				@endDate datetime,
				@sourceType nvarchar(100),
				@categories nvarchar(max),
				@subcategories nvarchar(max),
				@groups nvarchar(max),
				@questionNameOrCode nvarchar(100),
				@surveyNameOrCode nvarchar(100),
				@questionGroupName nvarchar(100),
				@taskName nvarchar(100),
				@currentUserId bigint ',
            @firm =@firm,
            @users =@users,
            @startDate= @startDate,
            @endDate = @endDate,
            @sourceType = @sourceType,
            @categories =@categories,
            @subcategories =@subcategories,
            @groups =@groups,
            @questionNameOrCode =@questionNameOrCode,
            @surveyNameOrCode =@surveyNameOrCode,
            @questionGroupName =@questionGroupName,
            @taskName = @taskName,
            @currentUserId = @currentUserId

end