DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'WarehouseOperation.Direct.StockDemand', '', 2, GETDATE(), 3, 'Sale');

DECLARE @stockDemandOperationId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Create', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 4, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Date', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.Date')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 5, @parentId, N'WarehouseOperation.Direct.StockDemand.Date.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 6, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Status', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.Status')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 7, @parentId, N'WarehouseOperation.Direct.StockDemand.Status.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 8, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.DestinationDivision', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.DestinationDivision')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 9, @parentId, N'WarehouseOperation.Direct.StockDemand.DestinationDivision.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 10, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.DestinationWarehouse', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.DestinationWarehouse')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 11, @parentId, N'WarehouseOperation.Direct.StockDemand.DestinationWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 12, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Factory', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.Factory')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 13, @parentId, N'WarehouseOperation.Direct.StockDemand.Factory.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 14, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.SourceWarehouse', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.SourceWarehouse')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 15, @parentId, N'WarehouseOperation.Direct.StockDemand.SourceWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 16, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.SpeCode', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.SpeCode')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 17, @parentId, N'WarehouseOperation.Direct.StockDemand.SpeCode.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 18, @parentId, N'WarehouseOperation.Direct.StockDemand.SpeCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 19, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.Note', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.Note')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 20, @parentId, N'WarehouseOperation.Direct.StockDemand.Note.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 21, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.AuthCode', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.AuthCode')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 22, @parentId, N'WarehouseOperation.Direct.StockDemand.AuthCode.Select', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 23, @parentId, N'WarehouseOperation.Direct.StockDemand.AuthCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 24, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.ItemStock', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.ItemStock')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 25, @parentId, N'WarehouseOperation.Direct.StockDemand.ItemStock.Real', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 26, @parentId, N'WarehouseOperation.Direct.StockDemand.ItemStock.Actual', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 27, @parentId, N'WarehouseOperation.Direct.StockDemand.ItemStock.Special', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 29, @stockDemandOperationId, N'WarehouseOperation.Direct.StockDemand.SupplyReport', '', 2, GETDATE(), 3, 'Sale');

GO
