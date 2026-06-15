
declare @maxId int;
set @maxId = (SELECT MAX(Id) FROM SYS_PushMethod)

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
           ('ThirdPartyDocConfirmation'
           ,'Third party doc confirmation notification'
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
