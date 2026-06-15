DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'WorkPlan.Actions', '', 2, GETDATE(), 4, 'Workplan');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan.Actions')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'WorkPlan.Actions.FastMode', '', 2, GETDATE(), 4, 'Workplan');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WorkPlan.Actions.FastMode')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'WorkPlan.Actions.FastMode.StartStop', '', 2, GETDATE(), 4, 'Workplan');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 4, @parentId, N'WorkPlan.Actions.FastMode.Operation', '', 2, GETDATE(), 4, 'Workplan');
