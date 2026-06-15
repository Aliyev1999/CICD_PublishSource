CREATE PROCEDURE [dbo].[SP_WPM_GetWorkExecutionPhotoGalleryReportWithPhotos] 
@firm smallint null,
@currentUserId bigint,
@startDate date null,
@endDate date null,
@creatorUserIds nvarchar(max) null,
@executiveUserIds nvarchar(max) null,
@photoSourceType tinyint null,
@taskName nvarchar(max) null,
@clientCodeNameOrEdino nvarchar(max) null,
@taskStatus tinyint null,
@customerSpecodes12345 nvarchar(max) null,
@userSpecodes12345 nvarchar(max) null,
@categories nvarchar(max) null,
@subcategories nvarchar(max) null,
@groups nvarchar(max) null,
@isCreatedDate bit,
@maxResultCount int,
@sorting nvarchar(500) null,
@skipCount int =0

as 
begin

declare @Query nvarchar(max) =

    'with MainData as (select    concat(Creator.Name, '' '', Creator.Surname)                 as CreatorNameSurname,
								 concat(Executor.Name, '' '', Executor.Surname)               as ExecutorNameSurname,
								 Executor.UserName                                            as ExecutiveUsername,
								 Executor.Id                                                  as ExecutiveUserId,
								 Creator.UserName                                             as CreatorUserUsername,
								 Client.Code                                                  as ClientCode,
								 Client.Name                                                  as ClientName,
								 Client.TigerId                                               as ClientId,
								 Tasks.CreatedDate                                            as TaskCreationDate,
								 Schedule.StartDate                                           as TaskStartDate,
								 Schedule.EndDate                                             as TaskEndDate,
								 Mapping.SourceType                                           as ImageSource,
								 Tasks.Name                                                   as TaskName,
								 case
									 when Tickets.Id is null then CAST(1 as int)
									 when Tickets.CreatedDate is not null and Tickets.FinalizedDate is null then CAST(2 as int)
									 when Tickets.FinalizedDate is not null then CAST(3 as int)
									 end                                                      as TaskStatus,
								 Images.SecureUrl                                             as SecureUrl,
								 cast(Images.Type as tinyint)                                 as PhotoType,
								 Tasks.Id                                                     as Id,
                         dense_rank() over (order by Tasks.Id, Executor.Id, Client.TigerId)   as UniqueId
    
                  from (select Tasks.Id as TaskId, Image.SecureUrl, 1 as Type
                        from WPM_Task Tasks with (nolock)
                                 join WPM_Attachment Image on Image.ReferenceId = Tasks.Id and Image.Type=1
						where Tasks.Firm = @firm
                        union
                        select Ticket.TaskId as TaskId, Image.SecureUrl, 3 as Type
                        from WPM_TaskTicket Ticket
                                 join WPM_TaskTicketAction Action on Action.TaskTicketId = Ticket.Id
                                 join WPM_Attachment Image on Image.ReferenceId = Action.Id
						where Ticket.Firm = @firm) Images
    
                           join WPM_Task Tasks with (nolock) on Tasks.Id = Images.TaskId and Tasks.IsDeleted = 0 and Tasks.Firm = @firm
                           join (select distinct TaskId, max(SourceType) as SourceType
                                 from WPM_PhotoTaskMapping with (nolock)
                                 group by TaskId) Mapping on Mapping.TaskId = Tasks.Id
                           join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Tasks.Id
                           join AbpUsers Creator with (nolock) on Creator.Id = Tasks.CreatedUserId
                           join WPM_TaskClient TaskClient with (nolock) on TaskClient.TaskId = Tasks.Id
                           join WPM_UserTask TaskUser with (nolock) on TaskUser.TaskId = Tasks.Id
                           join AbpUsers Executor with (nolock) on Executor.Id = TaskUser.UserId
						   join F_GetPermittedUsers(@CurrentUserId) PermittedUsers on PermittedUsers.UserId = Tasks.CreatedUserId
                           join F_GetAllPermittedClient() Permitted on Permitted.UserId = Executor.Id and Permitted.ClientId = TaskClient.ClientId and Permitted.Firm = Tasks.Firm
                           join MD_Client Client with (nolock) on Client.TigerId = Permitted.ClientId and Client.Firm = Permitted.Firm and Client.IsDeleted = 0
                           left join WPM_TaskTicket Tickets with (nolock)
                                     on Tickets.TaskId = TaskClient.TaskId and Tickets.ClientId = TaskClient.ClientId and Tickets.UserId = Executor.Id
									 
						where 1=1 '

declare @WhereFilter nvarchar(max)
if @isCreatedDate = 0 set @WhereFilter = ' and (cast(Schedule.StartDate as date)<= @endDate and @startDate <=cast( Schedule.EndDate as date))  '
if @isCreatedDate = 1 set @WhereFilter = 'and (cast(Tasks.CreatedDate as date) between @startDate and @endDate)  '
set @Query = CONCAT(@Query, @WhereFilter)


-- User variables
if @creatorUserIds is not null
    set @Query = concat(@Query, ' and (Tasks.CreatedUserId in (select ltrim(Value) from F_SplitList(''', @creatorUserIds, ''',', ''',''))) ')

if @executiveUserIds is not null
    set @Query = concat(@Query, ' and (TaskUser.UserId in (select ltrim(Value) from F_SplitList(''', @executiveUserIds, ''',', ''',''))) ')

if @userSpecodes12345 is not null
    set @Query = concat(@Query,
                        ' and (Specodes.Specode1 like ''%''+@userSpecodes12345+''%'' or Specodes.Specode2 like ''%''+@userSpecodes12345+''%'' or Specodes.Specode3 like ''%''+@userSpecodes12345+''%'' or Specodes.Specode4 like ''%''+@userSpecodes12345+''%'' or Specodes.Specode5 like ''%''+@userSpecodes12345+''%'') ')


-- Task variables 
if @taskStatus = 1 set @Query = concat(@Query, ' and Tickets.Id is null')
if @taskStatus = 2 set @Query = concat(@Query, ' and Tickets.CreatedDate is not null and Tickets.FinalizedDate is null')
if @taskStatus = 3 set @Query = Concat(@Query, ' and Tickets.FinalizedDate is not null')
if @taskName is not null set @Query = concat(@Query, ' and (Tasks.Name like ''%''+@taskName+''%'' ) ')

-- Task properties
if @categories is not null and @Categories != ''
    set @Query = CONCAT(@Query, ' and (Tasks.CategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @categories, ''',', ''','')))')

if @subcategories is not null and @Subcategories != ''
    set @Query =
            CONCAT(@Query, ' and (Tasks.SubcategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @subcategories, ''',', ''','')))')

if @groups is not null and @Groups != ''
    set @Query = CONCAT(@Query, ' and (Tasks.GroupReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @groups, ''',', ''','')))')

if @photoSourceType is not null
    set @Query =
            concat(@Query, ' and (Mapping.SourceType in (select ltrim(Value) from F_SplitList(''', @photoSourceType, ''',', ''',''))) ')


-- Client variables 
if @clientCodeNameorEdino is not null
    set @Query = concat(@Query,
                        ' and (Client.Code like ''%''+@clientCodeNameOrEdino+''%'' or Client.Name like ''%''+@clientCodeNameOrEdino+''%''or Client.Edino like ''%''+@clientCodeNameOrEdino+''%'') ')

if @customerSpecodes12345 is not null
    set @Query = concat(@Query,
                        ' and (Client.SpecialCode like ''%''+@customerSpecodes12345+''%'' or Client.SpecialCode2 like ''%''+@customerSpecodes12345+''%'' or Client.SpecialCode3 like ''%''+@customerSpecodes12345+''%'' or Client.SpecialCode4 like ''%''+@customerSpecodes12345+''%'' or Client.SpecialCode5 like ''%''+@customerSpecodes12345+''%'') ')


set @Query = concat(@Query,
                    '), Data as (select *, max(UniqueId) over () as MaxResultCount from MainData)
                        
                        select Data.CreatorNameSurname,
                               Data.ExecutorNameSurname,
                               Data.ExecutiveUsername,
                               Data.ExecutiveUserId,
                               Data.CreatorUserUsername,
                               Data.ClientCode,
                               Data.ClientName,
                               Data.ClientId,
                               Data.TaskCreationDate,
                               Data.TaskStartDate,
                               Data.TaskEndDate,
                               Data.ImageSource,
                               Data.TaskName,
                               Data.TaskStatus,
                               Data.SecureUrl,
                               cast(Data.PhotoType as tinyint) as PhotoType,
                               Data.Id,
							   cast(Data.MaxResultCount as int) as MaxResultCount
                        from Data
                                 join (select distinct UniqueId')

if @skipCount is not null and @maxResultCount is not null and @sorting is not null
    begin
        declare @SortColumn nvarchar(100) = (select SUBSTRING(@sorting, 1, (CHARINDEX(' ', @sorting + ' ') - 1))) --print cast(@query as ntext)
        set @Query = concat(@Query, ', ' + @SortColumn + ' from Data order by ' + @sorting + ' 
	offset @skipCount rows fetch next @maxResultCount rows only ) Ordering on Ordering.UniqueId = Data.UniqueId 
	order by ' + @sorting )
    end

else
    set @Query = concat(@Query, ' from Data ) Ordering on Ordering.UniqueId = Data.UniqueId
	order by ' + @sorting)

exec sp_executesql @Query,
     N'
                        @firm smallint,
                        @currentUserId bigint,
                        @startDate date,
                        @endDate date,
                        @creatorUserIds nvarchar(max) null,
                        @executiveUserIds nvarchar(max) null,
                        @photoSourceType tinyint null,
                        @taskName nvarchar(max) null,
                        @clientCodeNameOrEdino nvarchar(max) null,
                        @taskStatus tinyint null,
                        @customerSpecodes12345 nvarchar(max) null,
                        @userSpecodes12345 nvarchar(max) null,
                        @categories nvarchar(max) null,
                        @subcategories nvarchar(max) null,
                        @groups nvarchar(max) null,
                        @isCreatedDate bit,
                        @maxResultCount int,
                        @sorting nvarchar(500) null,
                        @skipCount int = 0
                        ',
     @firm = @firm,
     @currentUserId = @currentUserId,
     @startDate = @startDate,
     @endDate = @endDate,
     @creatorUserIds = @creatorUserIds,
     @executiveUserIds = @executiveUserIds,
     @photoSourceType = @photoSourceType,
     @taskName = @taskName,
     @clientCodeNameOrEdino = @clientCodeNameOrEdino,
     @taskStatus = @taskStatus,
     @customerSpecodes12345 = @customerSpecodes12345,
     @userSpecodes12345 = @userSpecodes12345,
     @categories = @categories,
     @subcategories = @subcategories,
     @groups = @groups,
     @isCreatedDate = @isCreatedDate,
     @maxResultCount = @maxResultCount,
     @sorting = @sorting,
     @skipCount = @skipCount

end
