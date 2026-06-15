
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ErpOrderManagement.Order');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'ErpOrderManagement.Order.Cancel', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ErpOrderManagement');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'ErpOrderManagement.Actions', '', 2, GETDATE(), 3, 'Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'ErpOrderManagement.History', '', 2, GETDATE(), 3, 'Sale');


GO
