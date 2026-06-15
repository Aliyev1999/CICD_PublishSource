declare @maxId int  =  (SELECT MAX(Id) FROM SYS_PushMethod);

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
           ('ImCreatedInventoryNotFoundOperation'
           ,'Created Inventory Not Found Operation'
           ,null
           ,null
           ,1
           ,1
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

declare @maxId int  =  (SELECT MAX(Id) FROM SYS_PushMethod);

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
           ('ImUpdatedInventoryNotFoundOperationByAuditor'
           ,'Updated Inventory Not Found Operation By Auditor'
           ,null
           ,null
           ,1
           ,1
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO

declare @maxId int  =  (SELECT MAX(Id) FROM SYS_PushMethod);

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
           ('ImUpdatedInventoryNotFoundOperationByFinancer'
           ,'Updated Inventory Not Found Operation By Financer'
           ,null
           ,null
           ,1
           ,1
           ,1
           ,null
           ,null
           ,2
           ,GETDATE()
           ,@maxId+1)
GO