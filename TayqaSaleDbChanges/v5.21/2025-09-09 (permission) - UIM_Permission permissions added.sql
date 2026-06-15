DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'Cash');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'Cash.BulkOperation', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);
GO


DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0)
              FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id
                         FROM UIM_Permission
                         WHERE ObjectName = 'Cash.BulkOperation');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [CreatedUserId],
 [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES (@parentId, 'Cash.BulkOperation.MinimalMandatory', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);