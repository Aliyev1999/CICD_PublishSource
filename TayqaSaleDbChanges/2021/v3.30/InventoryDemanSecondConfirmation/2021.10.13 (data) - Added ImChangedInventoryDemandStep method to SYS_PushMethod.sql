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
           ('ImChangedInventoryDemandStep'
           ,'Changed Inventory demand"s step'
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