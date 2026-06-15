declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order')
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
           ,'Order.OnSaleNotPermitted'
           ,'Order on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch')
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
           ,'ReturnDispatch.OnSaleNotPermitted'
           ,'ReturnDispatch on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice')
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
           ,'ReturnInvoice.OnSaleNotPermitted'
           ,'ReturnInvoice on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch')
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
           ,'SaleDispatch.OnSaleNotPermitted'
           ,'SaleDispatch on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice')
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
           ,'SaleInvoice.OnSaleNotPermitted'
           ,'SaleInvoice on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Cash')
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
           ,'Cash.OnSaleNotPermitted'
           ,'Cash on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)


set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'CashOut')
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
           ,'CashOut.OnSaleNotPermitted'
           ,'CashOut on Sale not permitted'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,Null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)

