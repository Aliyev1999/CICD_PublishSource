
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Management.InternalThirdParty');
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
           ,'Management.InternalThirdParty.Modify'
           ,'TSC-5507'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
