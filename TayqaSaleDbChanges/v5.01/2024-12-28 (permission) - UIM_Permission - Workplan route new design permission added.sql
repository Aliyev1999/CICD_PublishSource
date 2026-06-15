DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WorkPlan.Route');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WorkPlan.Route.NewDesign', 'TSC-5888', 2, GETDATE(), 4, 'Workplan', 100, @maxId + 1);
