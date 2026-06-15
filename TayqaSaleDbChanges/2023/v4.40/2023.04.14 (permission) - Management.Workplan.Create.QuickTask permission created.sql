declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName='Management.WorkPlan.Create');
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
           ,'Management.WorkPlan.Create.QuickTask'
           ,'TSC-4331'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,1
           ,3
           ,'WorkPlan'
           ,100
           ,@maxId + 1)
GO
 

 