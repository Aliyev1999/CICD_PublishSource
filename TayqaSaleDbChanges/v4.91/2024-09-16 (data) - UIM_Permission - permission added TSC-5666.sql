DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WorkPlan.Route.AddClient');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WorkPlan.Route.AddClient.OnlineList', 'TSC-5666', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO