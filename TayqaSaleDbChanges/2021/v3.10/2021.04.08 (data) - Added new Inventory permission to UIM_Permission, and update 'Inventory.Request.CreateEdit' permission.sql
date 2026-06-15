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
           ,'Inventory.Request'
           ,'Inventory Request'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)

SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Request');
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
           ,'Inventory.Request.Warehouse'
           ,'Inventory Request Warehouse'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)

SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Request.Warehouse');
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
           ,'Inventory.Request.Warehouse.Select'
           ,'Inventory Request Warehouse Select'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)


SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Request');
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
           ,'Inventory.Request.Division'
           ,'Inventory Request Division'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)


SET @parentId  = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.Request.Division');
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
           ,'Inventory.Request.Division.Select'
           ,'Inventory Request Division Select'
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

DECLARE @inventoryRequestPermissionId SMALLINT;
DECLARE @inventoryRequestCreateEditPermissionId SMALLINT;

SET @inventoryRequestPermissionId = (SELECT Id
FROM UIM_Permission
WHERE ObjectName = 'Inventory.Request');
SET @inventoryRequestCreateEditPermissionId = (SELECT Id
FROM UIM_Permission
WHERE ObjectName = 'Inventory.Request.CreateEdit');

UPDATE UIM_Permission SET ParentId = @inventoryRequestPermissionId WHERE Id = @inventoryRequestCreateEditPermissionId;

INSERT INTO UIM_UserPermission
(UserId, Firm, PermissionId, PermissionValue,CreatedUserId, CreatedDate)
SELECT UserId, Firm, @inventoryRequestPermissionId, PermissionValue, 2, GETDATE()
FROM UIM_UserPermission p1
WHERE PermissionId = @inventoryRequestCreateEditPermissionId
  AND (SELECT count(*) FROM UIM_UserPermission p2 WHERE p2.UserId = p1.UserId AND p2.Firm = p1.Firm AND p2.PermissionId = @inventoryRequestPermissionId) = 0