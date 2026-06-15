ALTER procedure [dbo].[SP_IM_GetInventoryWarehouseRepairDemands]
(
	@inventoryId int,
	@firm smallint,
	@startDate datetime,
	@endDate datetime,
	@repairDemandId int,
	@registrationNr nvarchar(100),
	@warehouses nvarchar(500),
	@creatorUserList nvarchar(500),
	@repairDemandStatus nvarchar(500),
	@issueReasonList nvarchar(500),
	@hasConsumption bit,
	@inventorySerialNr nvarchar(100),
	@itemSpecialCodes nvarchar(500),
	@printStatus tinyint,
	@isDocumented bit,
	@currentUser int,
	@sort nvarchar(100),
	@skipCount int,
	@takeCount int,
	@totalCount int out
)
As
Begin
	SET NOCOUNT ON;

	declare @UserType nvarchar(100) = (select Type  
                                       from F_GetRootTypeOfAllUsersIncludingInActive()  
                                       where UserId = @currentUser)
  
    declare @sql nvarchar(max) =  
        '    
		declare @Result table 
						(Id int, Firm nvarchar(255), FirmNr smallint, RegistrationNr nvarchar(255), Warehouse nvarchar(255), WarehouseNr int,
						 CreatorUserName nvarchar(255), CreationTime datetime, HasProblems bit, HasImages bit, Status tinyint,IsDocumented bit,
						 HasConsumptions bit, Repairer nvarchar(255), CancelledDate datetime, CancelledUserFullName nvarchar(255), CancelReason nvarchar(255), TotalIssueCount int, ResolvedIssueCount int);

        with IssueCounts AS (
            SELECT
                DemandId,
                COUNT(*) AS TotalIssueCount,
                COUNT(CASE WHEN IsResolved = 1 THEN 1 END) AS ResolvedIssueCount
            FROM IM_WarehouseRepairIssue issue
			JOIN IM_StaticContent sc on issue.IssueId = sc.Id
			Where sc.IsDeleted = 0
            GROUP BY issue.DemandId
        ), Data as  (select    
                             Demands.Id																				as Id,    
							 Demands.CreatorUserId																	as CreatorUserId,
                             Firm.Name																				as Firm,  
							 Firm.Nr																				as FirmNr,
                             Inventory.RegistrationNr															    as RegistrationNr, 
							 Warehouse.Name																			as Warehouse,
							 Warehouse.Nr																			as WarehouseNr,
                             concat(CreatorUsers.Name ,'' '', CreatorUsers.Surname)								    as CreatorUserName,    
                             Demands.CreationTime																    as CreationTime,   
                             Demands.Status																		    as Status, 
                             Demands.IsDocumented																    as IsDocumented,    
                             CASE WHEN (select top 1 Id from IM_WarehouseRepairAttachment a
											where a.Type = 1 and a.ReferenceId = Demands.Id) IS NOT NULL 
								  THEN cast(1 as bit) ELSE cast(0 as bit) END										AS HasImages,    
                             CASE WHEN issue.Id IS NOT NULL THEN cast(1 as bit) ELSE cast(0 as bit) END			    AS HasProblems,
							 iif(Concumption.HasConsumptions = 1,CAST(1 AS BIT),CAST(0 AS BIT))                     AS HasConsumptions,
							 (AssignedUser.Name + '' '' + AssignedUser.Surname)										As Repairer,  
                             Demands.CancelledDate																    as CancelledDate,    
                             concat(CancelledUser.Name,'' '',CancelledUser.Surname)									as CancelledUserFullName,  
                             CancelReason.Name																	    as CancelReason,
							 COALESCE(IssueCounts.TotalIssueCount, 0)												AS TotalIssueCount,
							 COALESCE(IssueCounts.ResolvedIssueCount, 0)											AS ResolvedIssueCount
                               from IM_WarehouseRepairDemand Demands with (nolock)    
                               join IM_WarehouseRepairIssue issue on Demands.Id = issue.DemandId    
                               join MD_Firm Firm with (nolock) on Firm.Nr = Demands.Firm    
                               join AbpUsers CreatorUsers with (nolock) on CreatorUsers.Id = Demands.CreatorUserId 
                               join IM_Inventory Inventory with (nolock) on Demands.InventoryId = Inventory.Id    
                               join MD_Item Items with (nolock) on Items.TigerId = Inventory.TigerId and Items.Firm = Firm.Nr
							   join MD_Warehouse Warehouse with (nolock) on Demands.WarehouseNr = Warehouse.Nr and Demands.Firm = Warehouse.Firm
							   left join AbpUsers CancelledUser with (nolock) on CancelledUser.Id = Demands.CancelledUserId
							   left join AbpUsers AssignedUser with (nolock) on AssignedUser.Id = (select top 1 AssignedUserId from IM_WarehouseRepairTask where DemandId = Demands.Id order by CreationTime desc)
                               left join IM_StaticContent CancelReason on Demands.CancelReasonId = CancelReason.Id
							   left join IM_WarehouseRepairTask task on Demands.Id = task.DemandId    
							   left join (select distinct DemandId from IM_WarehouseRepairTask  where Status=11) t on t.DemandId=Demands.Id
							   left join (select distinct DemandId from IM_WarehouseRepairTask  where Status<>11 and Status <> 10) ActiveTask on ActiveTask.DemandId=Demands.Id  
                               LEFT JOIN ( SELECT DISTINCT DemandId, 1 AS HasConsumptions FROM IM_WarehouseRepairConsumption C WITH (NOLOCK)
										   join IM_WarehouseRepairTask T with(nolock) on C.TaskId=T.Id) Concumption ON Demands.Id = Concumption.DemandId  
							   left join IM_WarehouseRepairConsumption consumption with (nolock) on task.Id= consumption.TaskId
							   LEFT JOIN IssueCounts ON Demands.Id = IssueCounts.DemandId
							   
                               where  1 = 1    
        '  
	if @startDate is not null and @endDate is not null
		set @sql = concat(@sql, ' and (Demands.CreationTime BETWEEN @startDate AND @endDate)')

	if @firm is not null
		set @sql = concat(@sql, ' and (Demands.Firm = @firm)')  
  
    if @repairDemandId is not null  
        set @sql = concat(@sql, ' and (Demands.Id = @repairDemandId)')  

    if @inventoryId is not null  
	    set @sql = concat(@sql, ' and (Demands.InventoryId = @inventoryId)')  

    if @printStatus is not null and @printStatus = 1  
        set @sql = CONCAT(@sql, 'and (Demands.IsPrinted=1 and (consumption.IsPrinted=0 or consumption.IsPrinted is null)) ')  
    
	if @printStatus is not null and @printStatus = 2  
      set @sql = CONCAT(@sql, 'and (Demands.IsPrinted=0 and consumption.IsPrinted=1) ')  
    
	if @printStatus is not null and @printStatus = 3  
        set @sql = CONCAT(@sql, 'and (Demands.IsPrinted=1 and consumption.IsPrinted=1) ')  
    
	if @registrationNr is not null  
        set @sql = concat(@sql, ' and (RegistrationNr like ''%''+@registrationNr+''%'')')  

    if @repairDemandStatus is not null  
        set @sql = concat(@sql, ' AND (Demands.Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @repairDemandStatus, ''',', ''','')))')  
  
    if @issueReasonList is not null  
        set @sql = concat(@sql, ' AND (issue.IssueId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @issueReasonList, ''',', ''','')))')  
  
    if @inventorySerialNr is not null  
        set @sql = concat(@sql, ' and (Inventory.SerialNr like ''%''+@inventorySerialNr+''%'')')  
  
    if @itemSpecialCodes is not null  
        set @sql = concat(@sql,  
                          ' and (Items.SpecialCode like ''%''+@itemSpecialCodes+''%'' or    
       Items.SpecialCode2 like ''%''+@itemSpecialCodes+''%'' or    
       Items.SpecialCode3 like ''%''+@itemSpecialCodes+''%'' or    
       Items.SpecialCode4 like ''%''+@itemSpecialCodes+''%'' or    
       Items.SpecialCode5 like ''%''+@itemSpecialCodes+''%'')')

    if @creatorUserList is not null  
        set @sql = concat(@sql, ' AND (CreatorUsers.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @creatorUserList, ''',', ''','')))')

	if @warehouses is not null
		set @sql = concat(@sql, ' AND (Warehouse.Nr IN (SELECT LTRIM(Value) FROM F_SplitList(''', @warehouses, ''',', ''','')))')

	if @hasConsumption is not null  
        set @sql = concat(@sql, ' and (HasConsumptions = @hasConsumption)')

	if @isDocumented is not null  
        set @sql = concat(@sql, ' and (Demands.IsDocumented = @isDocumented)')  

    SET @sql = CONCAT(@sql, '),
		DistinctData AS (
			SELECT DISTINCT Id, Firm, FirmNr, RegistrationNr, Warehouse, WarehouseNr, CreatorUserName, 
							CreationTime, HasProblems, HasImages, Status, IsDocumented, HasConsumptions,
							Repairer, CancelledDate, CancelledUserFullName, CancelReason, TotalIssueCount,
							ResolvedIssueCount
			FROM Data
			INNER JOIN F_GetAllPermittedUsers(@currentUser) u on u.UserId = Data.CreatorUserId
		)')

	 set @sql = concat(@sql, 'insert into @Result (Id, Firm, FirmNr, RegistrationNr, Warehouse, WarehouseNr, CreatorUserName, 
												   CreationTime, HasProblems, HasImages, Status, IsDocumented, HasConsumptions,
												   Repairer, CancelledDate, CancelledUserFullName, CancelReason, TotalIssueCount, ResolvedIssueCount)
							  select * from DistinctData where 1=1
							  
							  set @totalCount = (select count(*) from @Result) -- getting total count
							  
							  select * from @Result where 1=1')

    IF @sort IS NOT NULL
	BEGIN
		SET @sort = UPPER(LEFT(@sort, 1)COLLATE SQL_Latin1_General_CP1_CI_AS) + LOWER(SUBSTRING(@sort, 2, LEN(@sort) - 1));
		SET @sql = CONCAT(@sql, ' ORDER BY ', @sort);
	END
	ELSE
		SET @sql = CONCAT(@sql, ' ORDER BY CreationTime DESC');
         
    if @skipCount is not null or @takeCount is not null  
        set @sql = concat(@sql, ' offset @skipCount rows fetch next @takeCount rows only')  

    EXEC sp_executesql @sql,  
         N' @inventoryId int,    
            @firm smallint, 
            @endDate datetime,    
            @startDate datetime,    
            @repairDemandId int,    
            @registrationNr nvarchar(500),    
            @creatorUserList nvarchar(500),   
            @repairDemandStatus nvarchar(500),    
			@issueReasonList nvarchar(500),    
            @hasConsumption bit,    
            @inventorySerialNr nvarchar(500),
            @itemSpecialCodes nvarchar(500),    
            @isDocumented bit,    
            @printStatus tinyint, 
            @currentUser int,    
            @UserType nvarchar(100),  
            @skipCount INT,    
            @takeCount INT,    
            @sort NVARCHAR(50),
			@totalCount int output',  
         @inventoryId=@inventoryId,  
         @firm=@firm, 
         @endDate = @endDate,  
         @startDate=@startDate,  
         @repairDemandId=@repairDemandId,  
         @registrationNr=@registrationNr,  
         @creatorUserList=@creatorUserList,
         @repairDemandStatus=@repairDemandStatus,  
         @issueReasonList=@issueReasonList,  
         @hasConsumption = @hasConsumption,  
         @inventorySerialNr=@inventorySerialNr,
         @itemSpecialCodes=@itemSpecialCodes,  
         @isDocumented=@isDocumented,  
         @printStatus=@printStatus,
         @currentUser= @currentUser,  
         @UserType=@UserType,  
         @skipCount=@skipCount,  
         @takeCount=@takeCount,  
         @sort=@sort,
		 @totalCount=@totalCount output
		 
	SET NOCOUNT OFF;
	print(@sql)
End
GO

