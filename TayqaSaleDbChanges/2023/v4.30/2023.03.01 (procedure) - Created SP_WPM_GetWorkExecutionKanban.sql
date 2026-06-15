CREATE procedure [dbo].[SP_WPM_GetWorkExecutionKanban] @startDate datetime, @endDate datetime, @searchForTaskCreationDate bit, @idNameMessage nvarchar(max),
                                                      @status tinyint, @firm smallint, @clientNameCodeOrEdino nvarchar(max), @userIds nvarchar(max),
                                                      @categories nvarchar(max), @subcategories nvarchar(max), @groups nvarchar(max), @followers nvarchar(max),
                                                      @confirmationType tinyint, @approvalStatus tinyint, @userSpecodes nvarchar(max), @clientSpecodes nvarchar(max),
                                                      @type bit, @isAssigned bit, @currentUserId int
AS
BEGIN

--Author: by TayqaTech for TayqaSale on 2023.01.13 (Kanan Mammadov)
--Description: this query returns the results of kanban view in Service Portal
--Ticket: TSC-4207 

    declare @isAdmin bit = cast((select dbo.FN_UIM_CheckUserIsAdmin(@currentUserId)) as bit)
    declare @joinCondition nvarchar(2000) =
        ' join F_GetAllPermittedUsersPermittedClients(@currentUserId) PermittedClients on PermittedClients.Firm = Client.Firm and PermittedClients.ClientId = Client.TigerId'

    declare @Query nvarchar(max)
    set @Query = '

with Data as (

select Tasks.Id                                                                         as Id,
       Tasks.Name                                                                       as Name,
       concat(Tasks.Message, '' - '', Client.Name collate SQL_Latin1_General_CP1_CI_AS) as Description,
       Users.UserName                                                                   as UserName,
       Users.Name + '' '' +Users.Surname                                                as UserFullName,
       case
           when Tickets.Id is null then cast(1 as tinyint)
           when Tickets.Id is not null and Tickets.FinalizedDate is null then cast(2 as tinyint)
           when Tickets.FinalizedDate is not null and ((ConfirmStatus.Status is not null and Tasks.ConfirmationType = 0) or Tasks.ConfirmationType = 1) and
                StopReasonId is null then cast(3 as tinyint)
           when ConfirmStatus.Status is null and Tasks.ConfirmationType = 0 and Tickets.FinalizedDate is not null then cast(4 as tinyint)
           when Tickets.FinalizedDate is not null and ((ConfirmStatus.Status is not null and Tasks.ConfirmationType = 0) or Tasks.ConfirmationType = 1) and
                StopReasonId is not null then cast(5 as tinyint)
           end                                                                        as Status,
       Photos.SecureUrl																  as ProfileUrl
from WPM_Task Tasks with (nolock)
                       join MD_Firm Firm with (nolock) on Firm.Nr = Tasks.Firm and Firm.IsActive = 1 and Tasks.Type = 5
                       join WPM_TaskClient TaskClients with (nolock) on TaskClients.TaskId = Tasks.Id
                       join MD_Client Client with (nolock) on Client.TigerId = TaskClients.ClientId and Client.Firm = Firm.Nr and Client.IsDeleted = 0'

    if @isAdmin = 0 set @Query = concat(@Query, @joinCondition)


    set @Query = concat(@Query, '
                       inner join WPM_TaskSchedule Schedule with (nolock) on Schedule.PeriodType = 1 and Schedule.TaskId = Tasks.Id
                       left join WPM_UserTask TaskUsers with (nolock) on TaskUsers.TaskId = Tasks.Id
                       left join AbpUsers Users with (nolock) on Users.Id = TaskUsers.UserId
                       left join AbpUserProfilePhoto Photos with (nolock) on Photos.UserId = Users.Id
                       left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = Users.Id and Specodes.Firm = Tasks.Firm
                       left join WPM_WorkExecutionClientMappingStatus ConfirmStatus with (nolock) on ConfirmStatus.TaskClientId = TaskClients.Id
                       left join WPM_TaskTicket Tickets with (nolock) on Tickets.ClientId = TaskClients.ClientId and Tickets.UserId = TaskUsers.UserId and Tickets.TaskId = Tasks.Id

    where Tasks.IsDeleted=0
        and Tasks.Firm = @firm
	')

    declare @WhereFilter nvarchar(max)
    if @searchForTaskCreationDate = 0 set @WhereFilter = ' and (Schedule.StartDate <= @endDate and @startDate <= Schedule.EndDate)   '
    if @searchForTaskCreationDate = 1 set @WhereFilter = ' and (Tasks.CreatedDate between @startDate and @endDate) '
    set @Query = CONCAT(@Query, @WhereFilter)

    if @idNameMessage is not null
        set @Query =
                concat(@Query,
                       ' and (Tasks.Id like ''%''+@idNameMessage+''%'' or Tasks.Name like ''%''+@idNameMessage+''%'' or Tasks.Message like ''%''+@idNameMessage+''%'')')

    if @clientNameCodeOrEdino is not null
        set @Query = concat(@Query,
                            ' and (Client.Code like ''%''+@clientNameCodeOrEdino+''%'' or Client.Name like ''%''+@clientNameCodeOrEdino+''%'' or Client.Edino like ''%''+@clientNameCodeOrEdino+''%'')')

    if @categories is not null and @categories != ''
        set @Query = CONCAT(@Query, ' AND (Tasks.CategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @categories, ''',', ''','')))')

    if @subcategories is not null and @subcategories != ''
        set @Query = CONCAT(@Query, ' AND (Tasks.SubcategoryReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @subcategories, ''',', ''','')))')

    if @groups is not null and @groups != ''
        set @Query = CONCAT(@Query, ' AND (Tasks.GroupReason IN (SELECT LTRIM(Value) FROM F_SplitList(''', @groups, ''',', ''','')))')

    if @clientSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Client.SpecialCode like ''%''+@clientSpecodes+''%'' or Client.SpecialCode2 like ''%''+@clientSpecodes+''%'' or Client.SpecialCode3 like ''%''+@clientSpecodes+''%''	or Client.SpecialCode4 like ''%''+@clientSpecodes+''%'' or Client.SpecialCode5 like ''%''+@clientSpecodes+''%'')')

    if @UserSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specodes.Specode1 like ''%''+@UserSpecodes+''%'' or Specodes.Specode2 like ''%''+@UserSpecodes+''%'' or Specodes.Specode3 like ''%''+@UserSpecodes+''%''	or Specodes.Specode4 like ''%''+@UserSpecodes+''%'' or Specodes.Specode5 like ''%''+@UserSpecodes+''%'')')

    if @followers is not null
        set @Query = concat(@Query, ' and ( Tasks.Id in (select TaskId from WPM_TaskFollowers with (nolock) where UserId in (SELECT LTRIM(Value) FROM F_SplitList(''',
                            @followers, ''',', ''',''))))')

    if @userIds is not null and @userIds != ''
        set @Query = CONCAT(@Query, ' AND (TaskUsers.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @userIds, ''',', ''','')))')

    if @confirmationType is not null set @Query = concat(@Query, ' and Tasks.ConfirmationType = @confirmationType')

    if @isAssigned = 0 set @Query = concat(@Query, ' and TaskUsers.Id is null ')
    if @isAssigned = 1 set @Query = concat(@Query, ' and TaskUsers.Id is not null ')

    set @Query = CONCAT(@Query, ' ) select * from Data where Status is not null ')


    if @status is not null set @Query = concat(@Query, ' AND (Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @status, ''',', ''','')))')

    print @Query

    exec sp_executesql @Query, N'@startDate datetime, @endDate datetime, @searchForTaskCreationDate bit, @idNameMessage nvarchar(max),
                                               @status tinyint, @firm smallint, @clientNameCodeOrEdino nvarchar(max), @userIds nvarchar(max), @categories nvarchar(max),
                                               @subcategories nvarchar(max), @groups nvarchar(max), @followers nvarchar(max), @confirmationType tinyint,
                                               @approvalStatus tinyint, @userSpecodes nvarchar(max), @clientSpecodes nvarchar(max), @type bit, @isAssigned bit, @currentUserId int',
         @startDate = @startDate, @endDate = @endDate, @searchForTaskCreationDate = @searchForTaskCreationDate, @idNameMessage=@idNameMessage,
         @status =@status, @firm =@firm, @clientNameCodeOrEdino =@clientNameCodeOrEdino, @userIds =@userIds, @categories =@categories,
         @subcategories =@subcategories, @groups = @groups, @followers = @followers, @confirmationType = @confirmationType,
         @approvalStatus =@approvalStatus, @userSpecodes =@userSpecodes, @clientSpecodes =@clientSpecodes, @type =@type, @isAssigned =@isAssigned, @currentUserId=@currentUserId

    --select 1040               Id,
    --       'is emri 1'        Name,
    --       'is emri mesaji 1' Description,
    --       'Novruz Aliyev'    UserFullName,
    --       'skywalker'        Username,
    --       '1'                Status

    -- nullable olmayan saheler. SearchForTaskCreationDate,@startDate, @endDate
    -- status 1 NotStarted, 2 Proceeded, 3 Completed, 4 PendingApproval ,5 Terminated


    -- confirmationType null all, 0 PendingApproval, 1 NotAwaitingApproval
    -- approvalStatus null all, 1 Confirmed, 2 Reject, 3 Waiting, 4 PartialValidation

END