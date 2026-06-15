declare @parentId int = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'UserProfile');
declare @maxId int = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'UserProfile.WorkExecution'
           ,'TSC-3608. UserProfile.WorkExecution'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId +1)
GO

