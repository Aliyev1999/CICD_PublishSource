DECLARE @maxId SMALLINT = (select max(Id) from SYS_PushMethod)

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
           ('MsgNotificationStatusChanged'
           ,'MessagingWS Notification Status changed'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

DECLARE @maxId SMALLINT = (select max(Id) from SYS_PushMethod)

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
           ('MsgNotificationDeleted'
           ,'MessagingWS Notification Deleted'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,@maxId+1)
GO