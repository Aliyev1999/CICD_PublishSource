DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'WarehouseOperation.Direct.Transfer.ScanSerialNumbers', 'TSC-6124', 2, GETDATE(), 3, 'Sale', 100, @maxId + 1);

GO

DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.ScanSerialNumbers');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'WarehouseOperation.Direct.Transfer.ScanSerialNumbers.PartionScanAllowed', 'TSC-6124', 2, GETDATE(), 3, 'Sale', 100, @maxId + 1);

GO
