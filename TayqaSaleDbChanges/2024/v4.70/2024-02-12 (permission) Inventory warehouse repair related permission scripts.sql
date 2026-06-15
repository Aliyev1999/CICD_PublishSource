declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Inventory.RepairDemandInWarehouse.Create');
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
           ,'Inventory.RepairDemandInWarehouse.Create.MandatoryPhoto'
           ,'TSC-5006'
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

set @parentId = (select Id from UIM_Permission where ObjectName = 'Settings.View');
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
           ,'Settings.View.Theme'
           ,'Settings.View.Theme'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'WorkPlan'
           ,100
           ,@maxId + 1)
GO
