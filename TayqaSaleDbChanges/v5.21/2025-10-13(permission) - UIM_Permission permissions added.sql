DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0) FROM UIM_Permission);

-- For IN
DECLARE @parentId_In INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Checklist.DynamicChecklist');
INSERT INTO [dbo].[UIM_Permission]
([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
 [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
VALUES
    (@parentId_In, 'Checklist.DynamicChecklist.AutoMoveToNextQuestion', '', NULL, 2, NULL, GETDATE(), null, 4, 'Checklist', 100, @maxId + 1);
	
GO