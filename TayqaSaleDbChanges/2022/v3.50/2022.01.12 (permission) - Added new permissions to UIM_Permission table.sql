DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Visit');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Visit.IgnoreMandatoryPhoto', '', 2, GETDATE(), 6, 'Sale');
