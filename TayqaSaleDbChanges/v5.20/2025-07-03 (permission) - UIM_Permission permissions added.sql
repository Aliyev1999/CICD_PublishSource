DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0) FROM UIM_Permission);

-- For IN
DECLARE @parentId_In INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.WorkPlan.Create');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
 [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES
    (@parentId_In, 'Management.WorkPlan.Create.OnlineUserList', 'TSC-6238', NULL, 2, NULL, GETDATE(), 1, 3, 'Workplan', 0, @maxId + 1);
	
	GO
	
DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0) FROM UIM_Permission);

DECLARE @parentId_In INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Checklist.Survey');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
 [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES
    (@parentId_In, 'Checklist.Survey.DirectSend', 'Checklist Survey DirectSend', NULL, 2, NULL, GETDATE(), NULL, 4, 'Checklist', 100, @maxId + 1);

GO

DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0) FROM UIM_Permission);
DECLARE @parentId_Out INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Checklist.Survey.DirectSend');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
 [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES
    (@parentId_Out, 'Checklist.Survey.DirectSend.Postponed', 'Permission for Out Operation Image', NULL, 2, NULL, GETDATE(), null, 4, 'Checklist', 100, @maxId + 2);


