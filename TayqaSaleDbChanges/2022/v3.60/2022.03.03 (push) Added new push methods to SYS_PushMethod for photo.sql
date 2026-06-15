declare @maxId int;
set @maxId= (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('PhotoStarAdded'
           ,null
           ,null
           ,null
           ,1
           ,3
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

declare @maxId int;
set @maxId= (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('PhotoCommentAdded'
           ,null
           ,null
           ,null
           ,1
           ,3
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

declare @maxId int;
set @maxId= (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('PhotoDisliked'
           ,null
           ,null
           ,null
           ,1
           ,3
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

declare @maxId int;
set @maxId= (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('PhotoLiked'
           ,null
           ,null
           ,null
           ,1
           ,3
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO
