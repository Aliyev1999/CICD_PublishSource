declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName='ReturnDispatch');
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
           ,'ReturnDispatch.TemplateRestriction'
           ,'TSC-4544. ReturnDispatch.TemplateRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)
GO