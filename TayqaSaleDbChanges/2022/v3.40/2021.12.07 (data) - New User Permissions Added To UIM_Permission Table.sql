
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.Sale');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Management.UserMonitoring.Sale.Filter', '', 2, GETDATE(), 1, 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.Sale.Filter');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'Management.UserMonitoring.Sale.Filter.UserStructure', '', 2, GETDATE(), 1, 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.WorkPlan');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'Management.UserMonitoring.WorkPlan.Filter', '', 2, GETDATE(), 1, 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.WorkPlan.Filter');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module)
VALUES (@maxId + 4, @parentId, N'Management.UserMonitoring.WorkPlan.Filter.UserStructure', '', 2, GETDATE(), 1, 3, 'Sale');

GO

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ReturnDispatch');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'ReturnDispatch.Report', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ReturnInvoice');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'ReturnInvoice.Report', '', 2, GETDATE(), 3, 'Sale');

GO

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ReturnInvoice');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'ReturnInvoice.IgnoreSerialNumberCheckingOnReturn', '', 2, GETDATE(), 3, 'Sale');

GO

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, [Module], Id)
VALUES ('Replacement', 'Replacement', 2, GETDATE(), 3, 'Sale', @maxId + 1)

GO
