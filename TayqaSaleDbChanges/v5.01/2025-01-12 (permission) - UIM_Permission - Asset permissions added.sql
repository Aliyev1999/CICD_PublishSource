DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Inventory.AssetList.StatusUpdate', 'TSC-5830', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList.StatusUpdate');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Inventory.AssetList.StatusUpdate.MandatoryImage', 'TSC-5830', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList.StatusUpdate');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Inventory.AssetList.StatusUpdate.LocationType', 'TSC-5830', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList.StatusUpdate.LocationType');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Inventory.AssetList.StatusUpdate.LocationType.Mandatory', 'TSC-5830', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);
GO
