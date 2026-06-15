-- Permissions for WarehouseIn Operation

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO dbo.UIM_Permission(Id, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, N'WarehouseOperation', '', 2, GETDATE(), 3, 'Sale');

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'WarehouseOperation.Warehouses', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'WarehouseOperation.Direct', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 4, @parentId, N'WarehouseOperation.Direct.In', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 5, @parentId, N'WarehouseOperation.Direct.In.Create', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 6, @parentId, N'WarehouseOperation.Direct.In.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 7, @parentId, N'WarehouseOperation.Direct.In.InputType', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 8, @parentId, N'WarehouseOperation.Direct.In.Date', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 9, @parentId, N'WarehouseOperation.Direct.In.DestinationDivision', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 10, @parentId, N'WarehouseOperation.Direct.In.DestinationWarehouse', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 11, @parentId, N'WarehouseOperation.Direct.In.Factory', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 12, @parentId, N'WarehouseOperation.Direct.In.SpeCode', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 13, @parentId, N'WarehouseOperation.Direct.In.Note', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 14, @parentId, N'WarehouseOperation.Direct.In.AuthCode', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.InputType');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 15, @parentId, N'WarehouseOperation.Direct.In.InputType.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.Date');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 16, @parentId, N'WarehouseOperation.Direct.In.Date.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.DestinationDivision');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 17, @parentId, N'WarehouseOperation.Direct.In.DestinationDivision.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.DestinationWarehouse');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 18, @parentId, N'WarehouseOperation.Direct.In.DestinationWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.Factory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 19, @parentId, N'WarehouseOperation.Direct.In.Factory.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.SpeCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 20, @parentId, N'WarehouseOperation.Direct.In.SpeCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 21, @parentId, N'WarehouseOperation.Direct.In.SpeCode.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.Note');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 22, @parentId, N'WarehouseOperation.Direct.In.Note.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.AuthCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 23, @parentId, N'WarehouseOperation.Direct.In.AuthCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 24, @parentId, N'WarehouseOperation.Direct.In.AuthCode.Select', '', 2, GETDATE(), 3, 'Sale');


-- Permissions for WarehouseOut Operation


SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 25, @parentId, N'WarehouseOperation.Direct.Out', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 26, @parentId, N'WarehouseOperation.Direct.Out.Create', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 27, @parentId, N'WarehouseOperation.Direct.Out.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 28, @parentId, N'WarehouseOperation.Direct.Out.OutputType', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 29, @parentId, N'WarehouseOperation.Direct.Out.Date', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 30, @parentId, N'WarehouseOperation.Direct.Out.SourceDivision', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 31, @parentId, N'WarehouseOperation.Direct.Out.SourceWarehouse', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 32, @parentId, N'WarehouseOperation.Direct.Out.Factory', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 33, @parentId, N'WarehouseOperation.Direct.Out.SpeCode', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 34, @parentId, N'WarehouseOperation.Direct.Out.Note', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 35, @parentId, N'WarehouseOperation.Direct.Out.AuthCode', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.OutputType');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 36, @parentId, N'WarehouseOperation.Direct.Out.OutputType.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.Date');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 37, @parentId, N'WarehouseOperation.Direct.Out.Date.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.SourceDivision');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 38, @parentId, N'WarehouseOperation.Direct.Out.SourceDivision.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.SourceWarehouse');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 39, @parentId, N'WarehouseOperation.Direct.Out.SourceWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.Factory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 40, @parentId, N'WarehouseOperation.Direct.Out.Factory.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.SpeCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 41, @parentId, N'WarehouseOperation.Direct.Out.SpeCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 42, @parentId, N'WarehouseOperation.Direct.Out.SpeCode.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.Note');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 43, @parentId, N'WarehouseOperation.Direct.Out.Note.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.AuthCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 44, @parentId, N'WarehouseOperation.Direct.Out.AuthCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 45, @parentId, N'WarehouseOperation.Direct.Out.AuthCode.Select', '', 2, GETDATE(), 3, 'Sale');


-- Permissions for WarehouseTransfer Operation


SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 46, @parentId, N'WarehouseOperation.Direct.Transfer', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 47, @parentId, N'WarehouseOperation.Direct.Transfer.Create', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 48, @parentId, N'WarehouseOperation.Direct.Transfer.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 49, @parentId, N'WarehouseOperation.Direct.Transfer.Date', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 50, @parentId, N'WarehouseOperation.Direct.Transfer.SourceDivision', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 51, @parentId, N'WarehouseOperation.Direct.Transfer.DestinationDivision', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 52, @parentId, N'WarehouseOperation.Direct.Transfer.SourceWarehouse', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 53, @parentId, N'WarehouseOperation.Direct.Transfer.DestinationWarehouse', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 54, @parentId, N'WarehouseOperation.Direct.Transfer.Factory', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 55, @parentId, N'WarehouseOperation.Direct.Transfer.SpeCode', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 56, @parentId, N'WarehouseOperation.Direct.Transfer.Note', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 57, @parentId, N'WarehouseOperation.Direct.Transfer.AuthCode', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.Date');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 58, @parentId, N'WarehouseOperation.Direct.Transfer.Date.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.SourceDivision');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 59, @parentId, N'WarehouseOperation.Direct.Transfer.SourceDivision.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.DestinationDivision');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 60, @parentId, N'WarehouseOperation.Direct.Transfer.DestinationDivision.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.SourceWarehouse');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 61, @parentId, N'WarehouseOperation.Direct.Transfer.SourceWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.DestinationWarehouse');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 62, @parentId, N'WarehouseOperation.Direct.Transfer.DestinationWarehouse.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.Factory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 63, @parentId, N'WarehouseOperation.Direct.Transfer.Factory.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.SpeCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 64, @parentId, N'WarehouseOperation.Direct.Transfer.SpeCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 65, @parentId, N'WarehouseOperation.Direct.Transfer.SpeCode.Select', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.Note');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 66, @parentId, N'WarehouseOperation.Direct.Transfer.Note.Edit', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.AuthCode');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 67, @parentId, N'WarehouseOperation.Direct.Transfer.AuthCode.Edit', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 68, @parentId, N'WarehouseOperation.Direct.Transfer.AuthCode.Select', '', 2, GETDATE(), 3, 'Sale');

GO

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'WarehouseOperation.Direct.In.ItemStock', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.ItemStock');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'WarehouseOperation.Direct.In.ItemStock.Real', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'WarehouseOperation.Direct.In.ItemStock.Actual', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 4, @parentId, N'WarehouseOperation.Direct.In.ItemStock.Special', '', 2, GETDATE(), 3, 'Sale');



SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 5, @parentId, N'WarehouseOperation.Direct.Out.ItemStock', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.ItemStock');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 6, @parentId, N'WarehouseOperation.Direct.Out.ItemStock.Real', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 7, @parentId, N'WarehouseOperation.Direct.Out.ItemStock.Actual', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 8, @parentId, N'WarehouseOperation.Direct.Out.ItemStock.Special', '', 2, GETDATE(), 3, 'Sale');



SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 9, @parentId, N'WarehouseOperation.Direct.Transfer.ItemStock', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.ItemStock');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 10, @parentId, N'WarehouseOperation.Direct.Transfer.ItemStock.Real', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 11, @parentId, N'WarehouseOperation.Direct.Transfer.ItemStock.Actual', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 12, @parentId, N'WarehouseOperation.Direct.Transfer.ItemStock.Special', '', 2, GETDATE(), 3, 'Sale');
