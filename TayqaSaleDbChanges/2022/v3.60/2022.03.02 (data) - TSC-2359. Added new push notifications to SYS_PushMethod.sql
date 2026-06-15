DECLARE @maxId smallint;

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetOrderOperation'
           ,'Get Order Operation'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetSaleOperation'
           ,'Get Sale Operation'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetReturnOperation'
           ,'Get Return Operation'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetPaymentOperation'
           ,'Get Payment Operation'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetVisitOperation'
           ,'Get Visit Operation'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('GetChecklistResult'
           ,'Get Checklist Result'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)

SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);
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
           ('CompleteTasks'
           ,'Complete Tasks'
           ,NULL
           ,NULL
           ,1
           ,1
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)
GO