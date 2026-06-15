
DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.UpdateStatus.CreateEdit');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.UpdateStatus.CreateEdit.FieldsWithoutHistory', 'TSC-6249', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);

GO

DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Driver');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.RequestSupply.Driver.DocumentPhoto', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@maxId + 1, 'Inventory.RequestSupply.Driver.DocumentPhoto.Mandatory', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 2);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.RequestSupply.Driver.HandoverSignature', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 3);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@maxId + 3, 'Inventory.RequestSupply.Driver.HandoverSignature.Mandatory', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 4);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.RequestSupply.Driver.ReceiverSignature', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 5);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@maxId + 5, 'Inventory.RequestSupply.Driver.ReceiverSignature.Mandatory', 'TSC-6252', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 6);
