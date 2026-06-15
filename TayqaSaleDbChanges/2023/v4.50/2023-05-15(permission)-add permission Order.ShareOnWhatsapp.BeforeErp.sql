
declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.ShareOnWhatsapp')
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
           ,'Order.ShareOnWhatsapp.BeforeErp'
           ,'Order.ShareOnWhatsapp.BeforeErp'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Sale'
           ,100
       ,@maxId+1)