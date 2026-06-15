declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer'
           ,'Inventory.WarehouseTransfer'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AddInventory'
           ,'Inventory.WarehouseTransfer.AddInventory'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)




set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer.AddInventory')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AddInventory.BarcodeScan'
           ,'Inventory.WarehouseTransfer.AddInventory.BarcodeScan'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)




set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer.AddInventory')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AddInventory.ManualInput'
           ,'Inventory.WarehouseTransfer.AddInventory.ManualInput'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AcceptInventory'
           ,'Inventory.WarehouseTransfer.AcceptInventory'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer.AcceptInventory')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AcceptInventory.BarcodeScan'
           ,'Inventory.WarehouseTransfer.AcceptInventory.BarcodeScan'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

		   
set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.WarehouseTransfer.AcceptInventory')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Inventory.WarehouseTransfer.AcceptInventory.ManualInput'
           ,'Inventory.WarehouseTransfer.AcceptInventory.ManualInput'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
