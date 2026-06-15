
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan.Route');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'WorkPlan.Route.ClientDebt', '', 2, GETDATE(), 4, 'Workplan');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan.Task');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'WorkPlan.Task.ClientDebt', '', 2, GETDATE(), 4, 'Workplan');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan.Route.AddClient');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'WorkPlan.Route.AddClient.ClientDebt', '', 2, GETDATE(), 4, 'Workplan');

