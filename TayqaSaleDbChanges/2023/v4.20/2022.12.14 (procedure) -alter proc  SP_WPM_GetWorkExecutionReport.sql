 
ALTER procedure [dbo].[SP_WPM_GetWorkExecutionReport] @startDate datetime, @endDate datetime, @searchForCreationDate bit,
                                                       @Firm smallint, @UserIds nvarchar(1000) = null, @Categories nvarchar(1000) = null,
                                                       @Subcategories nvarchar(1000) = null, @Groups nvarchar(1000) = null, @ConfirmationType bit = null,
                                                       @UserSpecodes nvarchar(100) = null, @CurrentUserId int
as
begin

-- Created by: TayqaTech for TayqaSale (Kanan Mammadov)
-- Date: 01.01.2022
-- Description: Returns the master report data of work execution results

    declare @Query nvarchar(max)

    set @Query = '
select Firm.Nr                                                                                  as FirmNr,
       Firm.Name                                                                                as FirmName,
       Users.UserName                                                                           as UserName,
       Users.Id                                                                                 as UserId,
       concat(Users.Name, '' '', Users.Surname)                                                 as UserFullName,
       count(Clients.ClientId)                                                                  as WorkExecutionCount,
       sum(iif(Tickets.Id is null, 1, 0))                                                       as NotStatertedCount,
       sum(iif(Tickets.FinalizedDate is null and Tickets.CreatedDate is not null, 1, 0))        as ProceededCount,
       sum(iif(Tickets.FinalizedDate is not null, 1, 0))                                        as CompletedCount,
       sum(iif(Tasks.ConfirmationType = 0, 1, 0))                                               as PendingApprovalCount,
       sum(iif(ConfirmStatus.Status = 1, 1, 0))                                    as ApprovedCount,
       sum(iif(ConfirmStatus.Status = 2, 1, 0))                                    as RejectedCount,
       sum(iif(ConfirmStatus.Status is null and Tasks.ConfirmationType = 0, 1, 0)) as WaitingApprovalCount

from WPM_UserTask TaskUsers with (nolock)
         join AbpUsers Users with (nolock) on Users.Id = TaskUsers.UserId and Users.IsDeleted = 0
         join F_GetPermittedUsers(@CurrentUserId) PermittedUsers on PermittedUsers.UserId = Users.Id
         join WPM_Task Tasks with (nolock) on Tasks.Id = TaskUsers.TaskId and Tasks.Type = 5 and Tasks.IsDeleted = 0 and Tasks.Status = 0
         join MD_Firm Firm with (nolock) on Firm.Nr = Tasks.Firm and Firm.IsActive = 1
         join F_GetAllPermittedClient() PermittedClients on PermittedClients.UserId = TaskUsers.UserId and PermittedClients.Firm = Tasks.Firm
         join WPM_TaskClient Clients with (nolock) on Clients.TaskId = TaskUsers.TaskId and Clients.ClientId = PermittedClients.ClientId
         join WPM_TaskSchedule Schedule with (nolock) on Schedule.PeriodType = 1 and Schedule.TaskId = Tasks.Id
         left join WPM_WorkExecutionClientMappingStatus ConfirmStatus with (nolock) on ConfirmStatus.TaskClientId = Clients.Id
         left join UIM_UserProperty Specodes with (nolock) on Specodes.Firm = Firm.Nr and Specodes.UserId = Users.Id
         left join WPM_TaskTicket Tickets with (nolock) on Tickets.ClientId = Clients.ClientId and Tickets.UserId = TaskUsers.UserId
    and Tickets.TaskId = Tasks.Id and Tickets.Firm = Tasks.Firm

where Firm.Nr = @Firm  and '


declare @WhereFilter nvarchar (max)

if @searchForCreationDate = 0 set @WhereFilter = '
(Schedule.StartDate <= @endDate and @startDate <= Schedule.EndDate) -- partial overlap at end  '

if @searchForCreationDate = 1 set @WhereFilter =  '
(Tasks.CreatedDate between @startDate and @endDate) -- partial overlap at end '

set @Query = CONCAT(@Query, @WhereFilter)


    if @UserIds is not null and @UserIds != '' set @Query = CONCAT(@Query, '
	AND (Users.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @UserIds, ''',', ''','')))')

    if @Categories is not null and @Categories != ''
        set @Query = CONCAT(@Query, '
		AND (Tasks.CategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Categories, ''',', ''','')))')

    if @Subcategories is not null and @Subcategories != ''
        set @Query = CONCAT(@Query, '
		AND (Tasks.SubcategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Subcategories, ''',', ''','')))')

    if @Groups is not null and @Groups != ''
        set @Query = CONCAT(@Query, '
		AND (Tasks.GroupReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @Groups, ''',', ''','')))')

    if @ConfirmationType is not null set @Query = concat(@Query, '
	and Tasks.ConfirmationType = @ConfirmationType')


    if @UserSpecodes is not null
        set @Query = concat(@Query,
                            '
							and (Specodes.Specode1 like ''%''+@UserSpecodes+''%'' or Specodes.Specode2 like ''%''+@UserSpecodes+''%'' or Specodes.Specode3 like ''%''+@UserSpecodes+''%''		 or Specodes.Specode4 like ''%''+@UserSpecodes+''%'' or Specodes.Specode5 like ''%''+@UserSpecodes+''%'')')


    set @Query = CONCAT(@Query, '
	group by Users.UserName, concat(Users.Name, '' '', Users.Surname), Firm.Name, Firm.Nr, Users.Id')


  print @Query

    exec sp_executesql @Query, N'
	@startDate datetime,
	@endDate datetime,
	@searchForCreationDate bit,
	@Firm smallint,
	@UserIds nvarchar(1000) = null,
	@Categories nvarchar(1000) = null,
	@Subcategories nvarchar(1000) = null,
	@Groups nvarchar(1000) = null,
	@ConfirmationType bit = null,
	@UserSpecodes nvarchar(100) = null,
	@CurrentUserId int',
         @startDate = @startDate,
         @endDate = @endDate,
         @searchForCreationDate =@searchForCreationDate,
         @Firm = @Firm,
         @UserIds = @UserIds,
         @Categories = @Categories,
         @Subcategories = @Subcategories,
         @Groups = @Groups,
         @ConfirmationType = @ConfirmationType,
         @UserSpecodes = @UserSpecodes,
         @CurrentUserId =@CurrentUserId

end
go