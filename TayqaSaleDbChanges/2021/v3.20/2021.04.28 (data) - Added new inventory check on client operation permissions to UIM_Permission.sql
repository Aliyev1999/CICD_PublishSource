declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.InventoryCheckOnClient'
           ,'Inventory Operation InventoryCheckOnClient'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO
 
declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.InventoryCheckOnClient')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.InventoryCheckOnClient.CreateEdit'
           ,'Inventory Operation InventoryCheckOnClient CreateEdit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO

declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.InventoryCheckOnClient.CreateEdit')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.InventoryCheckOnClient.CreateEdit.ScanRequired'
           ,'Inventory Operation InventoryCheckOnClient CreateEdit ScanRequired'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO


declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.InventoryCheckOnClient.CreateEdit')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.InventoryCheckOnClient.CreateEdit.ManualInputAllowed'
           ,'Inventory Operation InventoryCheckOnClient CreateEdit ManualInputAllowed'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO