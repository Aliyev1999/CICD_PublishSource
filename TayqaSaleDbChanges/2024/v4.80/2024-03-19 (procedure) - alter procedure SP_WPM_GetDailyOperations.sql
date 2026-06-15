ALTER   procedure [dbo].[SP_WPM_GetDailyOperations](
    @firm smallint,
    @createdDateStart datetime,
    @createdDateEnd datetime,
    @finalizedDateStart datetime null,
    @finalizedDateEnd datetime null,
    @taskIdNameNote nvarchar(200) null,
    @actionTypes nvarchar(200) null,
    @clientNameCodeEdino nvarchar(200) null,
    @sorting nvarchar(100) null,
    @userSpecodes nvarchar(200) null,
    @status tinyint null,
    @users nvarchar(200) null,
    @taskActionMessage nvarchar(200) null,
    @categories nvarchar(200) null,
    @subcategories nvarchar(200) null,
    @groups nvarchar(200) null,
    @currentUserId BIGINT
)
As
Begin

    declare @Query nvarchar(max) =
        'with Data as (
            select Firm.Name                                                                                                       as FirmName,
                   Firm.Nr                                                                                                         as Firm,
                   Client.TigerId                                                                                                  as ClientId,
                   Client.Edino                                                                                                    as ClientEdino,
                   Task.Id                                                                                                         as TaskId,
                   TicketAction.Id                                                                                                 as TaskTicketActionId,
                   Ticket.StopReasonId                                                                                             as StopReasonId,
                   Ticket.IsCompleted                                                                                              as IsCompleted,
                   Users.UserName                                                                                                  as UserName,
                   Client.Name                                                                                                     as ClientName,
                   Client.Code                                                                                                     as ClientCode,
                   TicketAction.Note                                                                                               as Note,
                   TaskAction.Message                                                                                              as Message,
                   Task.Name                                                                                                       as TaskName,
                   TaskCategory.Id                                                                                                 as CategoryId,
                   TaskCategory.Name                                                                                               as CategoryName,
                   TaskSubCategory.Id                                                                                              as SubcategoryId,
                   TaskSubCategory.Name                                                                                            as SubCategoryName,
                   TaskGroup.Id                                                                                                    as GroupId,
                   TaskGroup.Name                                                                                                  as GroupName,
                   ActionType.Name                                                                                                 as ActionTypeName,
                   TicketAction.ActionParams                                                                                       as ActionParams,
                   Client.Latitude                                                                                                 as ClientLatitude,
                   Client.Longitude                                                                                                as ClientLongitude,
                   TicketAction.CreatedLatitude                                                                                    as CreatedLatitude,
                   TicketAction.CreatedLongitude                                                                                   as CreatedLongitude,
                   TicketAction.FinalizedLatitude                                                                                  as FinalizedLatitude,
                   TicketAction.FinalizedLongitude                                                                                 as FinalizedLongitude,
                   Ticket.CreatedDate                                                                                              as TaskTicketCreationTime,
                   Ticket.FinalizedDate                                                                                            as TaskTicketFinalizedDate,
                   TicketAction.CreatedDate                                                                                        as TaskTicketActionCreatedDate,
                   TicketAction.FinalizedDate                                                                                      as TaskTicketActionFinalizedDate,
                   CAST(DATEDIFF(minute, TicketAction.CreatedDate,TicketAction.FinalizedDate) as float) as TotalDurationAtClient,
isnull(
    round(
        iif(
            Client.Latitude = 0 or Client.Latitude is null OR TicketAction.CreatedLatitude=0 or TicketAction.CreatedLatitude is null,
            -1,
            iif   ( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(TicketAction.CreatedLatitude, TicketAction.CreatedLongitude, 4326))<1,1,( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(TicketAction.CreatedLatitude, TicketAction.CreatedLongitude, 4326)))
            ) / 1000
        ), 
        5
    ), 
    1
) as StartDistance,

isnull(
    round(
        iif(
            Client.Latitude = 0 or Client.Latitude is null OR TicketAction.FinalizedLatitude=0 or TicketAction.FinalizedLatitude is null,
            -1,
			iif   ( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(TicketAction.FinalizedLatitude, TicketAction.FinalizedLongitude, 4326))<1,1,( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(TicketAction.FinalizedLatitude, TicketAction.FinalizedLongitude, 4326)))
            ) / 1000

        ), 
        5
    ), 
    1
) as FinishDistance

            from WPM_TaskTicketAction TicketAction with (nolock)
                     join WPM_TaskAction TaskAction with (nolock) on TaskAction.Id = TicketAction.ActionId
                     join WPM_TaskActionType ActionType with (nolock) on ActionType.Id = TaskAction.ActionType
                     join WPM_TaskTicket Ticket with (nolock) on Ticket.Id = TicketAction.TaskTicketId
                     join WPM_Task Task with (nolock) on Task.Id = Ticket.TaskId
                     join MD_Firm Firm with (nolock) on Firm.Nr = Ticket.Firm
                     join MD_Client Client with (nolock) on Client.TigerId = Ticket.ClientId and Client.Firm = Ticket.Firm
                     join AbpUsers Users with (nolock) on Users.Id = Ticket.UserId
                     join F_DTM_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.Id = Users.Id
                     left join MD_StopReason TaskCategory with (nolock) on TaskCategory.Id = Task.CategoryReason and TaskCategory.Type = 13
                     left join MD_StopReason TaskSubCategory with (nolock) on TaskSubCategory.Id = Task.SubcategoryReason and TaskSubCategory.Type = 14
                     left join MD_StopReason TaskGroup with (nolock) on TaskGroup.Id = Task.GroupReason and TaskGroup.Type = 15
                     left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = Users.Id and Specodes.Firm = Ticket.Firm

            where Task.Firm = @firm
            and TicketAction.CreatedDate between @createdDateStart and @createdDateEnd
            '

    if @taskIdNameNote is not null
        set @Query = concat(@Query,
                            ' and (Task.Name like ''%''+@taskIdNameNote+''%'' or Task.Message like ''%''+@taskIdNameNote+''%'') ')

    if @actionTypes is not null
        set @Query =
                concat(@Query, ' and (ActionType.Id in (select ltrim(Value) from F_SplitList(''', @actionTypes, ''',',
                       ''','')))  ')

    if @clientNameCodeEdino is not null
        set @Query = concat(@Query,
                            ' and (Client.Code like ''%''+@clientNameCodeEdino+''%'' or Client.Name like ''%''+@clientNameCodeEdino+''%''                                    or Client.Edino like ''%''+@clientNameCodeEdino+''%'') ')

    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specodes.Specode1 like ''%''+@userSpecodes+''%'' or Specodes.Specode2 like ''%''+@userSpecodes+''%''                                    or Specodes.Specode3 like ''%''+@userSpecodes+''%'' or Specodes.Specode4 like ''%''+@userSpecodes+''%''                                    or Specodes.Specode5 like ''%''+@userSpecodes+''%'') ')

    if @users is not null
        set @Query = concat(@Query, ' and (Users.Id in (select ltrim(Value) from F_SplitList(''', @users, ''',',
                            ''','')))  ')

    if @taskActionMessage is not null
        set @Query = concat(@Query, ' and (TaskAction.Message like ''%''+@taskActionMessage+''%'') ')

    if @categories is not null
        set @Query =
                concat(@Query, ' and (TaskCategory.Id in (select ltrim(Value) from F_SplitList(''', @categories, ''',',''','')))  ')

    if @subcategories is not null
        set @Query =
                concat(@Query, ' and (TaskSubCategory.Id in (select ltrim(Value) from F_SplitList(''', @subcategories,''',', ''','')))  ')

    if @groups is not null
        set @Query = concat(@Query, ' and (TaskGroup.Id in (select ltrim(Value) from F_SplitList(''', @groups, ''',',
                            ''','')))  ')

    if @status is not null
    set @Query = concat(@Query, 
        case
            when @status = 1 then ' and (Ticket.FinalizedDate is not null and Ticket.StopReasonId is null) '
            when @status = 2 then ' and (Ticket.StopReasonId is not null) '
            when @status = 3 then ' and (Ticket.FinalizedDate is null) '
        end)


    set @Query = concat(@Query, ') select * from Data order by isnull(@sorting, ''TaskTicketCreationTime desc'')')

	print @Query

    execute sp_executesql @Query,
            N'@firm smallint,
              @createdDateStart datetime,
              @createdDateEnd datetime,
              @finalizedDateStart datetime = null,
              @finalizedDateEnd datetime = null,
              @taskIdNameNote nvarchar(200) = null,
              @actionTypes nvarchar(200) = null,
              @clientNameCodeEdino nvarchar(200) = null,
              @sorting nvarchar(100) = null,
              @userSpecodes nvarchar(200) = null,
              @status tinyint = null,
              @users nvarchar(200) = null,
              @taskActionMessage nvarchar(200) = null,
              @categories nvarchar(200) = null,
              @subcategories nvarchar(200) = null,
              @groups nvarchar(200) = null,
              @currentUserId int ',
            @firm = @firm,
            @createdDateStart = @createdDateStart,
            @createdDateEnd = @createdDateEnd,
            @finalizedDateStart = @finalizedDateStart,
            @finalizedDateEnd = @finalizedDateEnd,
            @taskIdNameNote = @taskIdNameNote,
            @actionTypes = @actionTypes,
            @clientNameCodeEdino = @clientNameCodeEdino,
            @sorting = @sorting,
            @userSpecodes = @userSpecodes,
            @status = @status,
            @users = @users,
            @taskActionMessage = @taskActionMessage,
            @categories = @categories,
            @subcategories = @subcategories,
            @groups = @groups,
            @currentUserId = @currentUserId
End