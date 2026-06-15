CREATE PROCEDURE [dbo].[SP_IM_GetRepairConsumptions]
	@applyDateRangeFilter BIT,
    @startDate DATETIME,
    @endDate DATETIME,
	@firm TINYINT,
    @repairedUserIds INT,
    @repairDemandId INT,
    @itemCodeName NVARCHAR(255),
    @consumptionStatuses INT,
	@currentUser INT, 
	@skipCount INT,  
	@takeCount INT,  
    @sort NVARCHAR(50)
AS
BEGIN
	declare @UserType nvarchar(100) = (select Type  
                                       from F_GetRootTypeOfAllUsersIncludingInActive()  
                                       where UserId = @currentUser)  
	declare @sql nvarchar(max) =  
        'with Data as  (select  Consumption.TaskId AS TaskId,
							Consumption.Id AS Id,
							Consumption.CreationTime AS CreationTime,
							CONCAT(users.Name, '' '', users.Surname) AS RepairderUser,
							Consumption.Status AS Status ,task.CreatorUserId as CreatorUserId
from IM_RepairConsumption Consumption with(nolock)
join IM_RepairConsumptionLines Line with(nolock) on Consumption.Id=Line.ConsumptionId
join IM_RepairTask task with(nolock) on task.Id=Consumption.TaskId
join MD_Item item with(nolock) on item.TigerId=Line.ItemId
join MD_Firm firm with(nolock) on firm.Nr=item.Firm
left join AbpUsers users with(nolock) on users.Id=task.AssignedUserId
 WHERE  1 = 1'  

	if @firm is not null  
        set @sql = concat(@sql, ' AND (firm.Nr = @firm)')  

	IF @applyDateRangeFilter IS NOT NULL AND @applyDateRangeFilter = 1  
        SET @sql = CONCAT(@sql,  
                          'AND  (Consumption.CreationTime >= @StartDate AND Consumption.CreationTime <= @EndDate)'
                          )  
	if @repairDemandId is not null  
        set @sql = concat(@sql, ' and (task.DemandId = @repairDemandId)')  

    if @repairedUserIds is not null  
        set @sql = concat(@sql, ' AND (task.AssignedUserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @repairedUserIds, ''',', ''','')))')  

    if @consumptionStatuses is not null  
        set @sql = concat(@sql, ' AND (Consumption.Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @consumptionStatuses, ''',', ''','')))')  
	
    if @itemCodeName is not null  
        set @sql = concat(@sql,  
                          ' and (item.Name like ''%''+@itemCodeName+''%'' or item.Code like ''%''+@itemCodeName+''%'')')  

	SET @sql = CONCAT(@sql, '),    
			DistinctData AS (
				SELECT DISTINCT *
				FROM Data
			)
			SELECT TaskId,Id,CreationTime,RepairderUser,Status,
				   COUNT(*) OVER () AS TotalCount
			FROM DistinctData
			LEFT JOIN [F_UIM_GetOrganizationTreeAllUsersIncludeInActiveDeleted](@currentUser) u ON u.UserId = DistinctData.CreatorUserId AND u.ParentType IN (''App'', ''Hybrid'')    
			WHERE ((@UserType = ''Hybrid'' AND u.UserId IS NOT NULL)    
				OR (@UserType <> ''Hybrid''))')  

	IF @sort IS NOT NULL
		BEGIN
		   SET @sort = UPPER(LEFT(@sort, 1)COLLATE SQL_Latin1_General_CP1_CI_AS) + LOWER(SUBSTRING(@sort, 2, LEN(@sort) - 1));
			SET @sql = CONCAT(@sql, ' ORDER BY ', @sort);
		END
		ELSE
		BEGIN
			SET @sql = CONCAT(@sql, ' ORDER BY CreationTime DESC');
		END

	 if @skipCount is not null or @takeCount is not null  
        begin  
            set @sql = concat(@sql, ' offset @skipCount rows fetch next @takeCount rows only')  
        end  
  
    EXEC sp_executesql @sql,  
         N' @applyDateRangeFilter BIT,
			@startDate DATETIME,
			@endDate DATETIME,
			@firm TINYINT,
			@repairedUserIds INT,
			@repairDemandId INT,
			@itemCodeName NVARCHAR(255),
			@consumptionStatuses INT,
			@currentUser INT,
			@skipCount INT,  
			@takeCount INT,  
			@sort NVARCHAR(50),
			@UserType nvarchar(100)',  
         @applyDateRangeFilter=@applyDateRangeFilter,  
         @startDate=@startDate,  
         @endDate= @endDate,  
		 @firm = @firm,
         @repairedUserIds=@repairedUserIds,  
         @repairDemandId=@repairDemandId,
		 @itemCodeName=@itemCodeName,
		 @consumptionStatuses = @consumptionStatuses,
		 @currentUser = @currentUser,
         @skipCount=@skipCount,  
         @takeCount=@takeCount,  
         @sort=@sort  ,
		 @UserType=@UserType
END

