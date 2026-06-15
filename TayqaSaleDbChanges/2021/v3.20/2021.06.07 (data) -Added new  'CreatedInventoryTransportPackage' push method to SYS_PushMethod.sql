DECLARE  @maxId SMALLINT = (select max(Id) from SYS_PushMethod)

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
           ('ImCreatedInventoryTransportPackage'
           ,'Create inventory transport package'
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