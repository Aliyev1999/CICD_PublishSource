
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'WarehouseOperation.Direct.Transfer.Status', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.Status');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'WarehouseOperation.Direct.Transfer.Status.Select', '', 2, GETDATE(), 3, 'Sale');

GO
