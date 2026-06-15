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
           ('MsgGeneralNotificationCreated'
           ,'MessagingWS General Notification Created'
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