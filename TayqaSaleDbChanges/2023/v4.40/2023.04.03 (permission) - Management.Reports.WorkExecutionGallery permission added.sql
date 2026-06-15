declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName='Management.Reports');
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
           ,'Management.Reports.WorkExecutionGallery'
           ,'TSC-4395'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'WorkPlan'
           ,100
           ,@maxId + 1)
GO


