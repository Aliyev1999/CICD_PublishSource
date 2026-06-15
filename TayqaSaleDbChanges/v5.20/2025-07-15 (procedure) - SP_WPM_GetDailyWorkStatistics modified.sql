CREATE OR ALTER procedure [dbo].[SP_WPM_GetDailyWorkStatistics](
    @minDate date null,
    @maxDate date null,
    @users nvarchar(500) null,
    @taskNameOrMessage nvarchar(200) null,
    @userCode nvarchar(200) null,
    @userSpecodes nvarchar(200) null,
    @clientNameOrCode nvarchar(200) null,
    @taskStatus int null,
    @stopReasons nvarchar(200) null,
    @categories nvarchar(200) null,
    @subCategories nvarchar(200) null,
    @groups nvarchar(200) null,
    @currentUserId BIGINT
)
As
Begin
    declare @Query nvarchar(max) ='
select cast(Ticket.UserId as bigint)                                                                                  as UserId,
       concat(Users.Name, '' '', Users.Surname)                                                                       as UserFullName,
	   Users.UserName																								  as UserName,
	   Users.Code																									  as UserCode,
       Specodes.Specode2                                                                                              as UserSpecode2,
       Ticket.TaskId                                                                                                  as TaskId,
       Task.Name                                                                                                      as TaskName,
       TaskCategory.Id                                                                                                as CategoryId,
       TaskCategory.Name                                                                                              as CategoryName,
       TaskSubCategory.Id                                                                                             as SubcategoryId,
       TaskSubCategory.Name                                                                                           as SubCategoryName,
       TaskGroup.Id                                                                                                   as GroupId,
       TaskGroup.Name                                                                                                 as GroupName,
       Ticket.Firm                                                                                                    as Firm,
       isnull(Completed.Completed, 0)                                                                                 as CompletedActionCount,
       isnull(ActCount.ActionCount, 0) - isnull(Completed.Completed, 0)                                               as UncompletedActionCount,
       ActionGroup.Name                                                                                               as StartGroupField,
       Ticket.StopReasonId                                                                                            as StopReasonId,
       Ticket.Id                                                                                                      as TaskTicketid,
       TaskClient.OrderNumber                                                                                         as ClientOrderNo,
       Ticket.ClientId                                                                                                as ClientId,
       Client.Code                                                                                                    as ClientCode,
       Client.Name                                                                                                    as ClientName,
       StopReason.Name                                                                                                as StopReasonName,
       Ticket.CreatedDate                                                                                             as StartDate,
       Ticket.FinalizedDate                                                                                           as FinalizedDate,
       Ticket.IsCompleted                                                                                             as IsCompleted,
       ActCount.ActionCount                                                                                           as ActionCount,
       Ticket.CreatedLatitude                                                                                         as CreatedLatitude,
       Ticket.CreatedLongitude                                                                                        as CreatedLongitude,
       Ticket.CreatedNote                                                                                             as CreatedNote,
       Ticket.FinalizedNote                                                                                           as FinalizedNote,
       Ticket.FinalizedLatitude                                                                                       as FinalizedLatitude,
       Ticket.FinalizedLongitude                                                                                      as FinalizedLongitude,
       Client.Latitude                                                                                                as ClientLatitude,
       Client.Longitude                                                                                               as ClientLongitude,
       iif(Ticket.ManualRouteClientId is not null and Ticket.ManualRouteClientId > 0, cast(1 as bit), cast(0 as bit)) as NonRoute,
       null                                                                                                           as MinimumDuration,
       null                                                                                                           as MaximumDuration,
       isnull(
               round(
                       iif(
                                       Client.Latitude = 0 or Client.Latitude is null OR Ticket.CreatedLatitude=0 or
                                       Ticket.CreatedLatitude is null,
                                       -1,
                                          iif   ( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(Ticket.CreatedLatitude, Ticket.CreatedLongitude, 4326))<1,1,( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(Ticket.CreatedLatitude, Ticket.CreatedLongitude, 4326)))
            ) / 1000
                           ),
                       5
                   ),
               1
           )                                                                                                          as StartDistance,

       isnull(
               round(
                       iif(
                                       Client.Latitude = 0 or Client.Latitude is null OR Ticket.FinalizedLatitude=0 or
                                       Ticket.FinalizedLatitude is null,
                                       -1,
                                      iif   ( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(Ticket.FinalizedLatitude, Ticket.FinalizedLongitude, 4326))<1,1,( geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(
                geography::Point(Ticket.FinalizedLatitude, Ticket.FinalizedLongitude, 4326)))
            ) / 1000


                           ),
                       5
                   ),
               1
           )                                                                                                          as FinishDistance,
       Ticket.TicketActionCount                                                                                       as TicketActionCount
from WPM_TaskTicket Ticket with (nolock)
         join WPM_Task Task with (nolock) on Task.Id = Ticket.TaskId
         join AbpUsers Users with (nolock) on Users.Id = Ticket.UserId
         join F_DTM_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.Id = Users.Id
         join MD_Firm Firm with (nolock) on Firm.Nr = Ticket.Firm
         join MD_Client Client with (nolock) on Client.TigerId = Ticket.ClientId and Client.Firm = Ticket.Firm
         left join WPM_TaskClient TaskClient with (nolock) on TaskClient.ClientId = Ticket.ClientId and TaskClient.TaskId = Ticket.TaskId
         left join WPM_ActionGroup ActionGroup with (nolock) on Ticket.StartActionGroupId = ActionGroup.Id
         left join MD_StopReason TaskCategory with (nolock) on TaskCategory.Id = Task.CategoryReason and TaskCategory.Type = 13
         left join MD_StopReason TaskSubCategory with (nolock) on TaskSubCategory.Id = Task.SubcategoryReason and TaskSubCategory.Type = 14
         left join MD_StopReason TaskGroup with (nolock) on TaskGroup.Id = Task.GroupReason and TaskGroup.Type = 15
         left join MD_StopReason StopReason with (nolock) on StopReason.Id = Ticket.StopReasonId and StopReason.Type = 1
         left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = Users.Id and Specodes.Firm = Ticket.Firm
         left join (select TaskId, count(taskAction.Id) as ActionCount
                    from WPM_Task task
                             left join WPM_TaskAction taskAction with (nolock) on task.Id = taskAction.TaskId
                    group by TaskId) ActCount on ActCount.TaskId = Task.Id
         left join (select TaskTicketId, count(ActionId) as Completed
                    from WPM_TaskTicket Ticket with (nolock)
                             join WPM_TaskTicketAction Actions with (nolock) on Actions.TaskTicketId = Ticket.Id
                    where Actions.FinalizedDate is not null
                    group by TaskTicketId) Completed on Completed.TaskTicketId = Ticket.Id
where cast(Ticket.CreatedDate as date) between cast(@minDate as date) and cast(@maxDate as date) 
		 '
    if @taskNameOrMessage is not null
        set @Query = concat(@Query,
                            ' and (Task.Name like ''%''+@taskNameOrMessage+''%'' or Task.Message like ''%''+@taskNameOrMessage+''%'') ')

    if @categories is not null
        set @Query =
                concat(@Query, ' and (TaskCategory.Id in (select ltrim(Value) from F_SplitList(''', @categories, ''',',
                       ''','')))  ')

    if @users is not null
        set @Query = concat(@Query, ' and Users.Id IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '',''))')

    if @subcategories is not null
        set @Query =
                concat(@Query, ' and (TaskSubCategory.Id in (select ltrim(Value) from F_SplitList(''', @subcategories,
                       ''',', ''','')))  ')

    if @stopReasons is not null
        set @Query =
                concat(@Query, ' and (StopReason.Id in (select ltrim(Value) from F_SplitList(''', @stopReasons,
                       ''',', ''','')))  ')

    if @groups is not null
        set @Query = concat(@Query, ' and (TaskGroup.Id in (select ltrim(Value) from F_SplitList(''', @groups, ''',',
                            ''','')))  ')
    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specodes.Specode1 like ''%''+@userSpecodes+''%'' or Specodes.Specode2 like ''%''+@userSpecodes+''%'' or Specodes.Specode3 like ''%''+@userSpecodes+''%'' or Specodes.Specode4 like ''%''+@userSpecodes+''%''  or Specodes.Specode5 like ''%''+@userSpecodes+''%'') ')

    if @userCode is not null
        set @Query = concat(@Query,
                            ' and Users.Code like ''%''+@userCode+''%'' ')

    if @clientNameOrCode is not null
        set @Query = concat(@Query,
                            ' and ( Client.Name like ''%''+@clientNameOrCode+''%'' or Client.Code like ''%''+@clientNameOrCode+''%'') ')

    if @taskStatus is not null
        set @Query = concat(@Query, case @taskStatus
                                        when 2 then ' and (Ticket.IsCompleted=0)'--Proceeding
                                        when 3 then ' and (Ticket.IsCompleted=1 and Ticket.StopReasonId is null)'--Completed
                                        when 4 then ' and (Ticket.IsCompleted=1 and Ticket.StopReasonId is not null)'--Stopped
            end)
    set @Query = concat(@Query, ' order by Ticket.CreatedDate  ')

    execute sp_executesql @Query,
            N' @minDate datetime, 
			   @maxDate datetime,
               @users nvarchar(500)= null,
			   @taskNameOrMessage nvarchar(200) =null,
			   @userCode nvarchar(200)= null,
			   @userSpecodes nvarchar(200)= null,
			   @clientNameOrCode nvarchar(200)= null,
			   @taskStatus int= null,
               @stopReasons nvarchar(200) null,
               @categories nvarchar(200) =null,
               @subCategories nvarchar(200)= null,
               @groups nvarchar(200) =null,
               @currentUserId BIGINT',
            @minDate=@minDate,
            @maxDate=@maxDate,
            @users=@users,
            @taskNameOrMessage=@taskNameOrMessage,
            @userCode=@userCode,
            @userSpecodes=@userSpecodes,
            @clientNameOrCode=@clientNameOrCode,
            @taskStatus=@taskStatus,
            @stopReasons=@stopReasons,
            @categories = @categories,
            @subcategories = @subcategories,
            @groups = @groups,
            @currentUserId = @currentUserId
End
go

