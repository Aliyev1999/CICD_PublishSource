

DECLARE @maxId INT

DECLARE @parentId INT


SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Tasks.Messages');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Tasks.Messages.CreateTask', '', 2, GETDATE(), 6, 'Sale');
