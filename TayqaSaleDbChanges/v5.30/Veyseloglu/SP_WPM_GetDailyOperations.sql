ALTER procedure [dbo].[SP_WPM_GetDailyOperations](
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
        '
DECLARE @LastInsertDate DATETIME;

 --Son insert olunmuş sətirin tarixini götürürük
SELECT @LastInsertDate = MAX(RegisteredDate)
FROM WPM_Spec_TaskTicketActionReport;



declare @PermittedUsers table
                        (
                            UserId bigint
                        )
insert into @PermittedUsers (UserId)
select UserId
from F_GetPermittedUsers(@currentUserId);

select FirmName,
       Firm,
       ClientId,
       ClientEdino,
       TaskId,
       TaskTicketActionId,
       StopReasonId,
       IsCompleted,
       UserName,
       ClientName,
       ClientCode,
       Note,
       Message,
       TaskName,
       CategoryId,
       CategoryName,
       SubcategoryId,
       SubCategoryName,
       GroupId,
       GroupName,
       ActionTypeName,
       ActionParams,
       ClientLatitude,
       ClientLongitude,
       CreatedLatitude,
       CreatedLongitude,
       FinalizedLatitude,
       FinalizedLongitude,
       TaskTicketCreationTime,
       TaskTicketFinalizedDate,
       TaskTicketActionCreatedDate,
       TaskTicketActionFinalizedDate,
       ActionTypeId,
       Specode1,
       Specode2,
       Specode3,
       Specode4,
       Specode5,
       report.UserId,
       TotalDurationAtClient,
       StartDistance,
       FinishDistance,
       IsAttachmentExists,
	   Answer
from WPM_Spec_TaskTicketActionReport report with(nolock)
         join @PermittedUsers PermittedUsers on PermittedUsers.UserId = report.UserId


            where Firm = @firm
            and TaskTicketActionCreatedDate between @createdDateStart and @createdDateEnd
'

    if @taskIdNameNote is not null
        set @Query = concat(@Query,
                            ' and (TaskName like ''%''+@taskIdNameNote+''%'' or Message like ''%''+@taskIdNameNote+''%'') ')

    if @actionTypes is not null
        set @Query =
                concat(@Query, ' and (ActionTypeId in (select ltrim(Value) from F_SplitList(''', @actionTypes, ''',',
                       ''','')))  ')

    if @clientNameCodeEdino is not null
        set @Query = concat(@Query,
                            ' and (ClientCode like ''%''+@clientNameCodeEdino+''%'' or ClientName like ''%''+@clientNameCodeEdino+''%''  or ClientEdino like ''%''+@clientNameCodeEdino+''%'') ')

    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specode1 like ''%''+@userSpecodes+''%'' or Specode2 like ''%''+@userSpecodes+''%''  or Specode3 like ''%''+@userSpecodes+''%'' or Specode4 like ''%''+@userSpecodes+''%''   or Specode5 like ''%''+@userSpecodes+''%'') ')

    if @users is not null
        set @Query = concat(@Query, ' and (report.UserId in (select ltrim(Value) from F_SplitList(''', @users, ''',',
                            ''','')))  ')

    if @taskActionMessage is not null
        set @Query = concat(@Query, ' and (Message like ''%''+@taskActionMessage+''%'') ')

    if @categories is not null
        set @Query =
                concat(@Query, ' and (CategoryId in (select ltrim(Value) from F_SplitList(''', @categories, ''',', ''','')))  ')

    if @subcategories is not null
        set @Query =
                concat(@Query, ' and (SubCategoryId in (select ltrim(Value) from F_SplitList(''', @subcategories, ''',', ''','')))  ')

    if @groups is not null
        set @Query = concat(@Query, ' and (GroupId in (select ltrim(Value) from F_SplitList(''', @groups, ''',',
                            ''','')))  ')

    if @status is not null
        set @Query = concat(@Query,
                            case
                                when @status = 1 then ' and (TaskTicketFinalizedDate is not null and StopReasonId is null) '
                                when @status = 2 then ' and (StopReasonId is not null) '
                                when @status = 3 then ' and (TaskTicketFinalizedDate is null) '
                                end)


    set @Query = concat(@Query, '  order by isnull(@sorting, ''TaskTicketCreationTime desc'')')

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
              @users nvarchar(200) = null ,
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
