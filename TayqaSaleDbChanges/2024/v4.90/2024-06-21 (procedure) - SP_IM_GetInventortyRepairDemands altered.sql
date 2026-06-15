ALTER procedure [dbo].[SP_IM_GetInventortyRepairDemands]       (@inventoryId int null,
                                                         @firm smallint null,  
                                                         @searchForDemandCreationTime bit,  
                                                         @startDate datetime null,  
                                                         @endDate datetime null,  
                                                         @repairDemandId int null,  
                                                         @registrationNr nvarchar(500) null,  
                                                         @creatorUserList nvarchar(500) = 0,  
                                                         @acceptorUserList nvarchar(500) = 0,  
                                                         @clientNameOrCodeOrGroupCode nvarchar(500) null,  
                                                         @repairDemandStatus nvarchar(500) =0,  
                                                         @issueReasonList nvarchar(500) = 0,  
                                                         @hasConsumption bit null,  
                                                         @inventorySerialNr nvarchar(500) null,  
                                                         @clientSpecialCode12345 nvarchar(500) null,  
                                                         @saleChannel nvarchar(500) null,  
                                                         @itemSpecialCode12345 nvarchar(500) null,  
                                                         @isDocumented bit null,  
                                                         @printStatus tinyint null,  
                                                         @applyDateRangeFilter bit null,  
                                                         @loggedInUser int,  
                                                         @skipCount INT NULL,  
                                                         @takeCount INT NULL,  
                                                         @sort NVARCHAR(50) NULL)  
as  
begin  
    declare @UserType nvarchar(100) = (select Type  
                                       from F_GetRootTypeOfAllUsersIncludingInActive()  
                                       where UserId = @loggedInUser)  
  
    declare @sql nvarchar(max) =  
        '    
        with IssueCounts AS (
            SELECT
                DemandId,
                COUNT(*) AS TotalIssueCount,
                COUNT(CASE WHEN IsResolved = 1 THEN 1 END) AS ResolvedIssueCount
            FROM IM_RepairIssue issue
			JOIN IM_StaticContent sc on issue.IssueId = sc.Id
			where sc.IsDeleted = 0
            GROUP BY DemandId
        ), Data as  (select    
                             Demands.Id																				as Id,    
                             Firm.Name																				as Firm,  
							 Firm.Nr																				as FirmNr,    
                             Demands.CreatorUserId																	as CreatorUserId,    
                             Inventory.RegistrationNr															    as RegistrationNr,    
                             Items.Name																			    as ItemName,    
                             Items.Code																			    as ItemCode,    
                             concat(CreatorUsers.Name ,'' '', CreatorUsers.Surname)								    as CreatorUserName,    
                             Demands.CreationTime																    as CreationTime,    
                             Clients.Name																		    as ClientName,    
                             Clients.Code																		    as ClientCode,    
                             Clients.Edino																			as Edino,    
                             concat(ConfirmedUser.Name ,'' '', ConfirmedUser.Surname)							    as ConfirmedUserName,    
                             Demands.ConfirmationTime															    as ConfirmationTime,    
                             concat(RejectUser.Name,'' '',RejectUser.Surname)									    as RejectedUserName,    
                             Demands.RejectionTime																    as RejectionTime,    
                             Demands.Status																		    as Status,    
                             Demands.Note																		    as Note,    
							 Demands.ConfirmedUserDescription													    as ConfirmedUserDescription,    
                             Demands.RejectedUserDescription													    as RejectedUserDescription,    
                             Demands.InventoryId																    as InventoryId,    
                             Demands.CancelledDate																    as CancelledDate,    
                             concat(CancelledUser.Name,'' '',CancelledUser.Surname)									as CancelledUserFullName,    
                             Demands.CancelledUserDescription													    as CancelledUserDescription,    
                             CancelReason.Name																	    as CancelReason,    
                             Demands.IsDocumented																    as IsDocumented,    
                             iif(Concumption.HasConsumptions = 1,CAST(1 AS BIT),CAST(0 AS BIT))                     AS HasConsumptions,    
                             CASE WHEN attachment.Id IS NOT NULL THEN cast(1 as bit) ELSE cast(0 as bit) END		AS HasImages,    
                             CASE WHEN issue.Id IS NOT NULL THEN cast(1 as bit) ELSE cast(0 as bit) END			    AS HasProblems,   
						     iif(t.DemandId is not null,cast(1 as bit),cast(0 as bit))							    AS HasUnAcceptedTask,   
							 InventoryState.Name																	As InventoryState,
							 iif(ActiveTask.DemandId is not null,cast(1 as bit),cast(0 as bit))						As HasActiveTask,
							 (AssignedUser.Name + '' '' + AssignedUser.Surname)										As Repairer,
							 COALESCE(IssueCounts.TotalIssueCount, 0)												AS TotalIssueCount,
							 COALESCE(IssueCounts.ResolvedIssueCount, 0)											AS ResolvedIssueCount
                               from IM_RepairDemand Demands with (nolock)    
                               join IM_RepairIssue issue on Demands.Id = issue.DemandId    
                               join MD_Firm Firm with (nolock) on Firm.Nr = Demands.Firm    
                               join AbpUsers CreatorUsers with (nolock) on CreatorUsers.Id = Demands.CreatorUserId    
                               join MD_Client Clients with (nolock) on Clients.Firm = Demands.Firm and Clients.TigerId = Demands.ClientId    
                               join IM_Inventory Inventory with (nolock) on Demands.InventoryId = Inventory.Id    
                               join MD_Item Items with (nolock) on Items.TigerId = Inventory.TigerId and Items.Firm = Clients.Firm    
                               left join AbpUsers ConfirmedUser with (nolock) on ConfirmedUser.Id = Demands.ConfirmingUserId    
                               left join AbpUsers CancelledUser with (nolock) on CancelledUser.Id = Demands.CancelledUserId    
							   left join AbpUsers AssignedUser with (nolock) on AssignedUser.Id = (select top 1 AssignedUserId from IM_RepairTask where DemandId = Demands.Id order by CreationTime desc)
                               left join AbpUsers RejectUser with (nolock) on RejectUser.Id = Demands.RejectedUserId    
                               left join IM_StaticContent CancelReason on Demands.CancelReasonId = CancelReason.Id
							   left join IM_StaticContent InventoryState on Inventory.StateId = InventoryState.Id    
                               left join IM_RepairTask task on Demands.Id = task.DemandId    
							   left join (select distinct DemandId from IM_RepairTask  where Status=11) t on t.DemandId=Demands.Id
							   left join (select distinct DemandId from IM_RepairTask  where Status<>11 and Status <> 10) ActiveTask on ActiveTask.DemandId=Demands.Id  
                               LEFT JOIN ( SELECT DISTINCT DemandId, 1 AS HasConsumptions FROM IM_RepairConsumption C WITH (NOLOCK) 
							   join IM_RepairTask T with(nolock) on C.TaskId=T.Id) Concumption ON Demands.Id = Concumption.DemandId   
							   left join IM_RepairConsumption consumption with (nolock) on task.Id= consumption.TaskId    
                               left join IM_RepairAttachment attachment with (nolock) on Demands.Id= attachment.ReferenceId and  attachment.Type=1   
							   LEFT JOIN IssueCounts ON Demands.Id = IssueCounts.DemandId
							   
                               where  1 = 1    
        '  
  
    if @firm is not null  
        set @sql = concat(@sql, ' and (Firm.Nr = @firm)')  

    IF @applyDateRangeFilter IS NOT NULL AND @applyDateRangeFilter = 1  
        SET @sql = CONCAT(@sql,  
                          ' AND (',  
                          '(@searchForDemandCreationTime = 1 AND Demands.CreationTime  BETWEEN @startDate  AND  @endDate)',  
                          ' OR ',  
                          '(@searchForDemandCreationTime = 0 AND Demands.ConfirmationTime BETWEEN @startDate AND  @endDate)',  
                          ')')  
  
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
  
    if @clientNameOrCodeOrGroupCode is not null  
        set @sql = concat(@sql,  
                          ' and (Clients.Name like ''%''+@clientNameOrCodeOrGroupCode+''%'' or Clients.Code like ''%''+@clientNameOrCodeOrGroupCode+''%'' or Clients.Edino like ''%''+@clientNameOrCodeOrGroupCode+''%'')')  
    if @repairDemandStatus is not null  
        set @sql = concat(@sql, ' AND (Demands.Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @repairDemandStatus, ''',', ''','')))')  
  
    if @issueReasonList is not null  
        set @sql = concat(@sql, ' AND (issue.IssueId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @issueReasonList, ''',', ''','')))')  
  
    if @inventorySerialNr is not null  
        set @sql = concat(@sql, ' and (Inventory.SerialNr like ''%''+@inventorySerialNr+''%'')')  
  
    if @clientSpecialCode12345 is not null  
        set @sql = concat(@sql,  
                          ' and (Clients.SpecialCode like ''%''+@clientSpecialCode12345+''%'' or    
       Clients.SpecialCode2 like ''%''+@clientSpecialCode12345+''%'' or    
       Clients.SpecialCode3 like ''%''+@clientSpecialCode12345+''%'' or    
       Clients.SpecialCode4 like ''%''+@clientSpecialCode12345+''%'' or    
       Clients.SpecialCode5 like ''%''+@clientSpecialCode12345+''%'')')  
    if @itemSpecialCode12345 is not null  
        set @sql = concat(@sql,  
                          ' and (Items.SpecialCode like ''%''+@itemSpecialCode12345+''%'' or    
       Items.SpecialCode2 like ''%''+@itemSpecialCode12345+''%'' or    
       Items.SpecialCode3 like ''%''+@itemSpecialCode12345+''%'' or    
       Items.SpecialCode4 like ''%''+@itemSpecialCode12345+''%'' or    
       Items.SpecialCode5 like ''%''+@itemSpecialCode12345+''%'')')  
    if @creatorUserList is not null  
        set @sql = concat(@sql, ' AND (CreatorUsers.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @creatorUserList, ''',', ''','')))')  
  
    if @acceptorUserList is not null  
        set @sql = concat(@sql, ' AND (ConfirmedUser.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @acceptorUserList, ''',', ''','')))')  
  
    if @isDocumented is not null  
        set @sql = concat(@sql, ' and (Demands.IsDocumented = @isDocumented)')  
  
  
    if @saleChannel is not null  
        set @sql = concat(@sql, ' and (Clients.SaleChannel like ''%''+@saleChannel+''%'')')  
  
    SET @sql = CONCAT(@sql, '),    
DistinctData AS (
    SELECT DISTINCT *
    FROM Data
)
SELECT *,
       COUNT(*) OVER () AS TotalCount
FROM DistinctData
LEFT JOIN [F_UIM_GetOrganizationTreeAllUsersIncludeInActiveDeleted](@loggedInUser) u ON u.UserId = DistinctData.CreatorUserId AND u.ParentType IN (''App'', ''Hybrid'')    
WHERE ((@UserType = ''Hybrid'' AND u.UserId IS NOT NULL)    
    OR (@UserType <> ''Hybrid''))')  
  
  
    if @hasConsumption is not null  
        set @sql = concat(@sql, ' and (HasConsumptions = @hasConsumption)')  
    IF @sort IS NOT NULL
BEGIN
   SET @sort = UPPER(LEFT(@sort, 1)COLLATE SQL_Latin1_General_CP1_CI_AS) + LOWER(SUBSTRING(@sort, 2, LEN(@sort) - 1));
    SET @sql = CONCAT(@sql, ' ORDER BY ', @sort);
END
ELSE
BEGIN
    SET @sql = CONCAT(@sql, ' ORDER BY ConfirmationTime DESC');
END
         
    if @skipCount is not null or @takeCount is not null  
        begin  
            set @sql = concat(@sql, ' offset @skipCount rows fetch next @takeCount rows only')  
        end  
  
    print @sql  
  
  
    EXEC sp_executesql @sql,  
         N' @inventoryId int,    
            @firm smallint,    
            @searchForDemandCreationTime bit,    
            @endDate datetime,    
            @startDate datetime,    
            @repairDemandId int,    
            @registrationNr nvarchar(500),    
            @creatorUserList nvarchar(500),    
            @acceptorUserList nvarchar(500),    
            @clientNameOrCodeOrGroupCode nvarchar(500),    
            @repairDemandStatus nvarchar(500),    
        @issueReasonList nvarchar(500),    
            @hasConsumption bit,    
            @inventorySerialNr nvarchar(500),    
            @clientSpecialCode12345 nvarchar(500),    
            @saleChannel nvarchar(500),    
            @itemSpecialCode12345 nvarchar(500),    
            @isDocumented bit,    
            @printStatus tinyint,    
            @applyDateRangeFilter bit,    
            @loggedInUser int,    
            @UserType nvarchar(100),  
            @skipCount INT,    
            @takeCount INT,    
            @sort NVARCHAR(50)',  
         @inventoryId=@inventoryId,  
         @firm=@firm,  
         @searchForDemandCreationTime= @searchForDemandCreationTime,  
         @endDate = @endDate,  
         @startDate=@startDate,  
         @repairDemandId=@repairDemandId,  
         @registrationNr=@registrationNr,  
         @creatorUserList=@creatorUserList,  
         @acceptorUserList=@acceptorUserList,  
         @clientNameOrCodeOrGroupCode=@clientNameOrCodeOrGroupCode,  
         @repairDemandStatus=@repairDemandStatus,  
         @issueReasonList=@issueReasonList,  
         @hasConsumption = @hasConsumption,  
         @inventorySerialNr=@inventorySerialNr,  
         @clientSpecialCode12345=@clientSpecialCode12345,  
         @saleChannel=@saleChannel,  
         @itemSpecialCode12345=@itemSpecialCode12345,  
         @isDocumented=@isDocumented,  
         @printStatus=@printStatus,  
         @applyDateRangeFilter=@applyDateRangeFilter,  
         @loggedInUser= @loggedInUser,  
         @UserType=@UserType,  
         @skipCount=@skipCount,  
         @takeCount=@takeCount,  
         @sort=@sort  
    print (cast(@sql as ntext))  
  
end
GO
