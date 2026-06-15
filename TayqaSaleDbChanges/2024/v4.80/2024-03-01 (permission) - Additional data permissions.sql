declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Management.WorkPlan.Create');
set @maxId = (select Max(Id) from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Management.WorkPlan.Create.AdditionalData'
           ,'TSC-5385'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,3
           ,'WorkPlan'
           ,100
           ,@maxId + 1)
GO
declare @parentId int;
set @parentId = (select Id from UIM_Permission where ObjectName = 'Management.WorkPlan');

UPDATE UIM_Permission SET ObjectName = 'Management.WorkPlan.CreateQuickTask', ParentId = @parentId
WHERE ObjectName = 'Management.WorkPlan.Create.QuickTask'
GO
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Management.WorkPlan.CreateQuickTask');
set @maxId = (select Max(Id) from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Management.WorkPlan.CreateQuickTask.AdditionalData'
           ,'TSC-5385'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,3
           ,'WorkPlan'
           ,100
           ,@maxId + 1)
GO