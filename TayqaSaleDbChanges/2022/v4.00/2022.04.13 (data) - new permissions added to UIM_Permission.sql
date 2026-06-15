DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, null, N'Story', '', 2, GETDATE(), 6, 'Sale', 1);

