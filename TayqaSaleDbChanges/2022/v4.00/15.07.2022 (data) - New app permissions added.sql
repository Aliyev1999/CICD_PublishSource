DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Inventory.TransferDelivery', '', 2, GETDATE(), 6, 'Inventory', null);

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 2, @maxId + 1, N'Inventory.TransferDelivery.BarcodeRequired', '', 2, GETDATE(), 6, 'Inventory', null);

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 3, @maxId + 1, N'Inventory.TransferDelivery.GPSRestrictionRequired', '', 2, GETDATE(), 6, 'Inventory', null);

GO
