declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Inventory.RepairTasks');
set @maxId = (select Max(Id) from UIM_Permission);


INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.RepairTasks.Consumption'
           ,'TSC-5430'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Inventory'
           ,100
           ,@maxId + 1)
GO


declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Inventory.RepairTasksInWarehouse');
set @maxId = (select Max(Id) from UIM_Permission);


INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.RepairTasksInWarehouse.Consumption'
           ,'TSC-5430'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Inventory'
           ,100
           ,@maxId + 1)
GO