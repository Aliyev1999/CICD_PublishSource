declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Checklist');
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
           ,'Checklist.DynamicChecklist'
           ,'TSC-5406. Checklist.DynamicChecklist'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Checklist'
           ,100
           ,@maxId + 1)
GO