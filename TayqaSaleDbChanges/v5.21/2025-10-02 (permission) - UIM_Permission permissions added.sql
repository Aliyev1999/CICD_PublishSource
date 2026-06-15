DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'Inventory.AssetBinding');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'Inventory.AssetBinding.MandatoryBarcode', '', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'Inventory.AssetList.StatusUpdate');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'Inventory.AssetList.StatusUpdate.MandatoryBarcode', '', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);

GO


