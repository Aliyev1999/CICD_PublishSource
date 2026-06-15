
DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.AssetList');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission
           (ParentId, ObjectName, [Description], ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
     VALUES
           (@parentId, 'Inventory.AssetList.StatusUpdateHistory', 'TSC-5793', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);
GO
