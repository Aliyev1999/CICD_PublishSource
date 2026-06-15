DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'Order');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'Order.OnlyCatalogBasedItems', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'ReturnDispatch');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'ReturnDispatch.OnlyCatalogBasedItems', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'ReturnInvoice');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'ReturnInvoice.OnlyCatalogBasedItems', '', 2, GETDATE(), 5, 'Sale', 100,
        @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'SaleDispatch');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'SaleDispatch.OnlyCatalogBasedItems', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'SaleInvoice');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'SaleInvoice.OnlyCatalogBasedItems', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);

GO