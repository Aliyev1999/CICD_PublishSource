declare @parentId int;
declare @maxId int;


set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PhotoGallery'
           ,'Management.PhotoGallery'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)


set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.PhotoGallery')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PhotoGallery.CreateTask'
           ,'Management.PhotoGallery.CreateTask'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.PhotoGallery')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PhotoGallery.GridView'
           ,'Management.PhotoGallery.GridView'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)


set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.PhotoGallery')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PhotoGallery.ListView'
           ,'Management.PhotoGallery.ListView'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)