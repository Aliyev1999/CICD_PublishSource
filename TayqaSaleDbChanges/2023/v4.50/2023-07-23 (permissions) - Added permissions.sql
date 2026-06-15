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
           ,'Order.BulkOperation'
           ,'TSC-4671. Order.BulkOperation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
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
           ,'ReturnDispatch.BulkOperation'
           ,'TSC-4671. ReturnDispatch.BulkOperation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
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
           ,'ReturnInvoice.BulkOperation'
           ,'TSC-4671. ReturnInvoice.BulkOperation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
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
           ,'SaleDispatch.BulkOperation'
           ,'TSC-4671. SaleDispatch.BulkOperation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
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
           ,'SaleInvoice.BulkOperation'
           ,'TSC-4671. SaleInvoice.BulkOperation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer')
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
           ,'WarehouseOperation.Direct.Transfer.OperationType'
           ,'TSC-4694. WarehouseOperation.Direct.Transfer.OperationType'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,0
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.OperationType')
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
           ,'WarehouseOperation.Direct.Transfer.OperationType.Edit'
           ,'TSC-4694. WarehouseOperation.Direct.Transfer.OperationType.Edit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,0
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.OperationType')
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
           ,'WarehouseOperation.Direct.Transfer.OperationType.Select'
           ,'TSC-4694. WarehouseOperation.Direct.Transfer.OperationType.Select'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,0
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)


