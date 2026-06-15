
declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.ShareOnWhatsapp')
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
           ,'SaleInvoice.ShareOnWhatsapp.BeforeErp'
           ,'SaleInvoice.ShareOnWhatsapp.BeforeErp'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Sale'
           ,100
       ,@maxId+1)