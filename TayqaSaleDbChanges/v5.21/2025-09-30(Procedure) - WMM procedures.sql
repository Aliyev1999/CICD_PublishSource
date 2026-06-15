CREATE proc [dbo].[SP_WMM_AddPermission] @PermissionName nvarchar(500)
as
begin

    set @PermissionName = trim(@PermissionName);

    if @PermissionName = '' or @PermissionName is null
        raiserror ('Invalid permission name is passed', 16, 1);
    else
        begin
            declare @ParentPermissionName nvarchar(500);
            declare @ParentPermissionId int;

            -- check if the permission name contains a dot, indicating it's a child permission
            if charindex('.', @PermissionName) > 0
                begin
                    -- extract the parent permission name
                    set @ParentPermissionName = substring(@PermissionName, 1, len(@PermissionName) - charindex('.', reverse(@PermissionName)));

                    -- get the ParentId. if not found, @ParentPermissionId will be null.
                    select @ParentPermissionId = Id
                    from WMM_Permission with (nolock)
                    where name = @ParentPermissionName;

                    -- if parent permission name exists but no corresponding id was found, raise an error
                    if @ParentPermissionId is null
                        begin
                            raiserror ('Parent permission ''%s'' not not found for ''%s''.', 16, 1, @ParentPermissionName, @PermissionName);
                        end;
                end
            else
                begin
                    -- if it's a top-level permission (no dot), its parent is null
                    set @ParentPermissionId = null;
                end;

            declare @MaxPermissionId int = (select isnull(max(Id), 0) from WMM_Permission with (nolock));

            insert into WMM_Permission (Id, ParentId, Name, Description, Creationtime, CreatorUserId)
            values (@MaxPermissionId + 1, @ParentPermissionId, @PermissionName, @PermissionName, getdate(), 2);

        end;
end;

Go

CREATE   proc [dbo].[SP_WMM_CheckTaskStatusCanBeChange]
	 
	@taskId int,
	@reasonId int,
	@newStatusId int,
	@note nvarchar(500)
AS
BEGIN

CREATE TABLE #Messages
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Message NVARCHAR(MAX)
);
 
 INSERT INTO #Messages (Message)
 VALUES 
 ('Olmaz.'),
 ('SP_WMM_CheckTaskStatusCanBeChange adli prosedur imkan vermir.'),
 ('Ceyhun, sen cani yene geri qaytarma.'),
 ('Tapsiriq tipindeki Status deyisiminde ozel kontrolu sondur duzelecek'),
 (N'Kənan, səncə necə olacaq bu işlərin axırı  ?.');

 SELECT Message
FROM #Messages
ORDER BY Id;

END
GO



CREATE proc [dbo].[SP_WMM_GetPanelCardStatuses] @projectId INT,
                                                          @currentUserId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Now DATETIME2(0) = SYSDATETIME();
    DECLARE @Since DATETIME2(0) = DATEADD(DAY, -30, @Now);

    WITH ActiveStatuses AS (SELECT s.Id, s.Category
                            FROM dbo.WMM_ProjectTaskStatus AS s
                            WHERE s.IsActive = 1
                              AND s.IsDeleted = 0),
         ProjectTasks AS (SELECT wt.Id, wt.StatusId, wt.CompletionTime, wt.ReminderDate
                          FROM dbo.WMM_Task AS wt
                          WHERE wt.ProjectId = @projectId
                            AND wt.IsActive = 1
                            AND wt.IsDeleted = 0)
    SELECT WaitingCount    =
               (SELECT COUNT(*)
                FROM dbo.WMM_TaskRequest AS tr
                WHERE tr.ProjectId = @projectId and Status = 1
                  AND NOT EXISTS (SELECT 1
                                  FROM dbo.WMM_Task AS t
                                  WHERE t.TaskRequestId = tr.Id
                                    AND t.IsDeleted = 0)),

           AcceptedCount   = ISNULL(SUM(IIF(s.Category = 1, 1, 0)), 0),
           InProgressCount = ISNULL(SUM(IIF(s.Category = 2, 1, 0)), 0),
           DoneCount       = ISNULL(SUM(IIF(s.Category = 3
                                                AND pt.CompletionTime >= @Since, 1, 0)), 0),
           OverdueCount    = ISNULL(SUM(IIF(s.Category <> 3
                                                AND pt.ReminderDate IS NOT NULL
                                                AND pt.ReminderDate < @Now, 1, 0)), 0)
    FROM ProjectTasks AS pt
             INNER JOIN ActiveStatuses AS s
                        ON pt.StatusId = s.Id;
END
GO




CREATE proc [dbo].[SP_WMM_GetPendingTaskRequests] @projectId INT,
                                                      @sources NVARCHAR(MAX) = NULL,
                                                      @forwardingUserIds NVARCHAR(MAX) = NULL,
                                                      @reasonIds NVARCHAR(MAX) = NULL,
                                                      @statuses NVARCHAR(MAX) = NULL,
                                                      @sorting NVARCHAR(500) = NULL,
                                                      @maxResultCount INT,
                                                      @skipCount INT = 0,
                                                      @totalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Query NVARCHAR(MAX) = '
DECLARE @Result TABLE (
    RequestNumber INT,
    SourceType TINYINT,
    SourceId INT,
    Forwarder NVARCHAR(256),
    Date DATETIME,
    Status TINYINT,
    TaskNumber NVARCHAR(50)
);

with Data as (
select Request.Id                               as RequestNumber,
       Request.SourceType                       as SourceType,
       Request.SourceId                         as SourceId,
       concat(Users.Name, '' '', Users.Surname) as Forwarder,
       Request.CreationTime                     as Date,
       case
           when Task.Id is null then Request.Status
           when Task.AssignedUserId is null then 4
           when Status.Category = 1 then 5
           when Status.Category = 2 then 6
           when Status.Category = 3 then 7
           end                                  as Status,
       Task.Number                              as TaskNumber
from WMM_TaskRequest Request with (nolock)
         join AbpUsers Users with (nolock) on Users.Id = Request.CreatorUserId
         left join WMM_Task Task with (nolock) on Task.TaskRequestId = Request.Id and Task.IsDeleted = 0
         left join WMM_ProjectTaskStatus Status on Status.Id = Task.StatusId
where Request.ProjectId = @projectId
'

    if @sources is not null
        set @Query = concat(@Query, ' and Request.SourceType in (select trim(Value) from string_split(@sources, '','')) ')

    if @forwardingUserIds is not null
        set @Query = concat(@Query, ' and Users.Id in (select trim(Value) from string_split(@forwardingUserIds, '','')) ')

    if @reasonIds is not null
        set @Query = concat(@Query, ' and Request.ReasonId in (select trim(Value) from string_split(@reasonIds, '','')) ')

    set @Query = concat(@Query, ' )
    insert into @Result (RequestNumber, SourceType, SourceId, Forwarder, Date, Status, TaskNumber)
    select RequestNumber, SourceType, SourceId, Forwarder, Date, Status, TaskNumber  from Data where 1=1 ')

    if @statuses is not null
        set @Query = concat(@Query, ' and Status in (select trim(Value) from string_split(@statuses, '','')) ')

    set @Query = concat(@Query, '

    set @totalCount = (select count(RequestNumber) from @Result)

    select * from @Result ')

    if @maxResultCount is not null
        set @Query = concat(@Query, ' order by ' + isnull(@sorting, 'Date desc') + ' offset @skipCount rows fetch next @maxResultCount rows only')

    EXEC sp_executesql @Query,
         N'@projectId INT,
           @sources NVARCHAR(MAX) = NULL,
           @forwardingUserIds NVARCHAR(MAX) = NULL,
           @reasonIds NVARCHAR(MAX) = NULL,
           @statuses NVARCHAR(MAX) = NULL,
           @sorting NVARCHAR(500) = NULL,
           @maxResultCount INT,
           @skipCount INT = 0,
           @totalCount INT OUTPUT',
         @projectId = @projectId,
         @sources = @sources,
         @forwardingUserIds = @forwardingUserIds,
         @reasonIds = @reasonIds,
         @statuses = @statuses,
         @skipCount = @skipCount,
         @maxResultCount = @maxResultCount,
         @totalCount = @totalCount OUTPUT
END
GO




CREATE proc [dbo].[WMM_InsertTaskHistory]
	@taskId INT,
    @userId BIGINT,
    @fieldType NVARCHAR(255),
    @oldValue NVARCHAR(255),
    @oldString NVARCHAR(MAX),
    @newValue NVARCHAR(255),
    @newString NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO dbo.WMM_TaskHistory (TaskId,CreatorUserId, FieldType, OldValue, OldString, NewValue, NewString)
    VALUES (@taskId, @userId, @fieldType, @oldValue, @oldString, @newValue, @newString);
END;
GO


