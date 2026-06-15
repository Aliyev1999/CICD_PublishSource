

DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'SaleInvoice.ScanSerialNumbers', 'TSC-5990', 2, GETDATE(), 6, 'Sale', 100, @maxId + 1);

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice');

INSERT INTO UIM_Permission (ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'ReturnInvoice.ScanSerialNumbers', 'TSC-5990', 2, GETDATE(), 6, 'Sale', 100, @maxId + 2);