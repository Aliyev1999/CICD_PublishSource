DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.WorkPlan');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Management.UserMonitoring.WorkPlan.PhotoLikeDislike', '', 2, GETDATE(), 1, 3, 'Workplan');

