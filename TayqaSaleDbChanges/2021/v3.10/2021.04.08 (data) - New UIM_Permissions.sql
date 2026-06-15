DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory')


INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Inventory.RequestSupply', '', 2, GETDATE(), 6, 'Inventory');


GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.UpdateStatus.CreateEdit')


INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Inventory.UpdateStatus.CreateEdit.Line', '', 2, GETDATE(), 6, 'Inventory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @maxId+1, N'Inventory.UpdateStatus.CreateEdit.Line.ScanRequired', '', 2, GETDATE(), 6, 'Inventory');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @maxId+1, N'Inventory.UpdateStatus.CreateEdit.Line.AllowDelete', '', 2, GETDATE(), 6, 'Inventory');
