DECLARE @parentId smallint;
DECLARE @maxId smallint;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Inventory.Return'
           ,'Inventory Return'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)

SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Inventory.Return.Warehouse'
           ,'Inventory Return Warehouse'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)

SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return.Warehouse');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Inventory.Return.Warehouse.Select'
           ,'Inventory Return Warehouse Select'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)


SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Inventory.Return.Division'
           ,'Inventory Return Division'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)


SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return.Division');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Inventory.Return.Division.Select'
           ,'Inventory Return Division Select'
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

DECLARE @inventoryReturnPermissionId smallint;
DECLARE @inventoryReturnCreateEditPermissionId smallint;

SET @inventoryReturnPermissionId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return');
SET @inventoryReturnCreateEditPermissionId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Return.CreateEdit');

UPDATE UIM_Permission SET ParentId = @inventoryReturnPermissionId WHERE Id = @inventoryReturnCreateEditPermissionId;

INSERT INTO UIM_UserPermission
(UserId, Firm, PermissionId, PermissionValue,CreatedUserId, CreatedDate)
SELECT 
UserId, Firm, @inventoryReturnPermissionId, PermissionValue, 2, GETDATE()
FROM UIM_UserPermission WHERE PermissionId = @inventoryReturnCreateEditPermissionId

GO