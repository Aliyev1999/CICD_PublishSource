CREATE or alter procedure [dbo].[SP_WPM_GetWorkExecutionDetailsReport] @startDate datetime, @endDate datetime, @searchForCreationDate bit, @Firm smallint, @UserId int,
                                                              @CurrentUserId int, @Categories nvarchar(1000) = null, @Subcategories nvarchar(1000) = null,
                                                              @Groups nvarchar(1000) = null, @ConfirmationType bit = null
as
begin

    declare @Query nvarchar(max)

    set @Query = '
select Client.Name                                as ClientName,
       Client.Code                                as ClientCode,
       Client.TigerId                             as ClientId,
       Tasks.Name                                 as WorkExecutionName,
       Schedule.StartDate                         as StartDate,
       Schedule.EndDate                           as EndDate,
       Tickets.CreatedDate                        as CreatedDate,
       Tickets.FinalizedDate                      as FinalizedDate,
       case
           when Tickets.Id is null then CAST(1 as tinyint) 
           when Tickets.CreatedDate is not null and Tickets.FinalizedDate is null then CAST(2 as tinyint) 
           when Tickets.FinalizedDate is not null then CAST(3 as tinyint) 
           end											as Status,
       isnull(TaskActions.TaskActionCount, 0)			as AllActionsCount,
       isnull(TicketActions.TicketActionCount, 0)		as CompletedActionsCount,
	   Tickets.Id										as TaskTicketId,
	   Tickets.CreatedLatitude							as CreatedLatitude,
       Tickets.CreatedLongitude							as CreatedLongitude,
       Tickets.FinalizedLatitude						as FinalizedLatitude,
       Tickets.FinalizedLongitude						as FinalizedLongitude,
	   Users.Name										as UserName,
	   Users.Surname									as UserSurname,
	   Client.Latitude									as ClientLatitude,
	   Client.Longitude									as ClientLongitude,
	   ClientMappingStatus.Status						as ClientMappingStatus,
	   ClientMappingStatus.CreationTime					as ClientMappingStatusChangedDate,
	   ClientConfirerUser.UserName						as ClientMappingStatusChangerUser,
	   CAST(IIF(TaskFollower.Id IS NULL, 0, 1) AS BIT)	as IsFollowerUser,
	   Tasks.ConfirmationType							as ConfirmationType,
	   TaskClient.Id									as TaskClientId

from WPM_UserTask TaskUsers with (nolock)
		 join AbpUsers Users with (nolock) on TaskUsers.UserId = Users.Id
         join WPM_Task Tasks with (nolock) on Tasks.Id = TaskUsers.TaskId and Tasks.Type = 5 and Tasks.IsDeleted = 0
         join F_GetPermittedClientForUser(@userId) PermittedClients on PermittedClients.UserId = TaskUsers.UserId and PermittedClients.Firm = Tasks.Firm
         join WPM_TaskClient TaskClient with (nolock) on TaskClient.TaskId = TaskUsers.TaskId and TaskClient.ClientId = PermittedClients.ClientId
         join MD_Client Client with (nolock) on Client.TigerId = TaskClient.ClientId and Client.Firm = Tasks.Firm
         join WPM_TaskSchedule Schedule with (nolock) on Schedule.PeriodType = 1 and Schedule.TaskId = Tasks.Id
		 left join WPM_WorkExecutionClientMappingStatus  ClientMappingStatus on ClientMappingStatus.TaskClientId = TaskClient.Id
		 left join AbpUsers ClientConfirerUser on ClientMappingStatus.CreatorUserId = ClientConfirerUser.Id
         left join WPM_TaskFollowers TaskFollower on Tasks.Id = TaskFollower.TaskId and TaskFollower.UserId = @CurrentUserId

		 left join WPM_TaskTicket Tickets with (nolock) on Tickets.ClientId = Client.TigerId and Tickets.UserId = TaskUsers.UserId and Tickets.TaskId = Tasks.Id
         left join (select TaskTicketId, count(Id) as TicketActionCount from WPM_TaskTicketAction with (nolock) group by TaskTicketId) TicketActions
                   on TicketActions.TaskTicketId = Tickets.Id
		 left join (select TaskTicketId, count(Id) as TaskActionCount from WPM_TaskTicketActionMapping group by TaskTicketId) TaskActions on TaskActions.TaskTicketId = Tickets.Id
where TaskUsers.UserId = @UserId and Tasks.Firm=@Firm AND '


    declare @WhereFilter nvarchar(max)

    if @searchForCreationDate = 0
        set @WhereFilter = '
(Schedule.StartDate <= @endDate and @startDate <= Schedule.EndDate) -- partial overlap at end  '


    if @searchForCreationDate = 1
        set @WhereFilter = '
(Tasks.CreatedDate between @startDate and @endDate) -- partial overlap at end
   
   '


    set @Query = CONCAT(@Query, @WhereFilter)


--print @Query;

    if @Categories is not null and @Categories != ''
        set @Query = CONCAT(@Query, ' AND (Tasks.CategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Categories, ''',', ''','')))')

    if @Subcategories is not null and @Subcategories != ''
        set @Query = CONCAT(@Query, ' AND (Tasks.SubcategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Subcategories, ''',', ''','')))')

    if @Groups is not null and @Groups != '' set @Query = CONCAT(@Query, ' AND (Tasks.GroupReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Groups, ''',', ''','')))')

    if @ConfirmationType is not null set @Query = concat(@Query, ' and Tasks.ConfirmationType = @ConfirmationType')

    exec sp_executesql @Query, N'@startDate datetime, @endDate datetime, @searchForCreationDate bit, @Firm smallint, @UserId int,
	@CurrentUserId int, @Categories nvarchar(1000), @Subcategories nvarchar(1000), @Groups nvarchar(1000), @ConfirmationType bit',
         @startDate = @startDate, @endDate = @endDate, @searchForCreationDate = @searchForCreationDate, @Firm = @Firm, @UserId = @UserId,
         @CurrentUserId = @CurrentUserId, @Categories = @Categories, @Subcategories = @Subcategories, @Groups = @Groups, @ConfirmationType =@ConfirmationType
end
go

