DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Driver.Register');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Inventory.RequestSupply.Driver.Register.MandatoryPhoto', 'MandatoryPhoto', NULL, 2, NULL, GETDATE(), NULL, 6, 'Inventory', 100, @maxId + 1);

GO