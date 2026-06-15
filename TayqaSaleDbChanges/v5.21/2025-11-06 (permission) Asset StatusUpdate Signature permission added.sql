
DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList.StatusUpdate');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.AssetList.StatusUpdate.Signature', 'TSC-6449', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);
