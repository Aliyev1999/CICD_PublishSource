DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.Reports');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Management.Reports.SalesTotal', '', 2, GETDATE(), 3, 'Sale', 1);