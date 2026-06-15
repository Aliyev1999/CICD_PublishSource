DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.ScanSerialNumbers');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'SaleInvoice.ScanSerialNumbers.PartionScanAllowed', 'TSC-6144', 2, GETDATE(), 6, 'Sale', 100, @maxId + 1);

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.ScanSerialNumbers');

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'ReturnInvoice.ScanSerialNumbers.PartionScanAllowed', 'TSC-6144', 2, GETDATE(), 6, 'Sale', 100, @maxId + 2);
GO