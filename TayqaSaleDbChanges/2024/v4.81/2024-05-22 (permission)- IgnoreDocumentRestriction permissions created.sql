declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Order');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'Order.IgnoreOneDocumentRestriction'
           ,'TSC-5516. Order.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO

declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'ReturnDispatch');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'ReturnDispatch.IgnoreOneDocumentRestriction'
           ,'TSC-5516. ReturnDispatch.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'ReturnInvoice');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'ReturnInvoice.IgnoreOneDocumentRestriction'
           ,'TSC-5516. ReturnInvoice.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'SaleDispatch');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'SaleDispatch.IgnoreOneDocumentRestriction'
           ,'TSC-5516. SaleDispatch.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'SaleInvoice');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'SaleInvoice.IgnoreOneDocumentRestriction'
           ,'TSC-5516. SaleInvoice.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'PurchaseOrder');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'PurchaseOrder.IgnoreOneDocumentRestriction'
           ,'TSC-5516. PurchaseOrder.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO

declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'Cash');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'Cash.IgnoreOneDocumentRestriction'
           ,'TSC-5516. Cash.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO


declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'CashOut');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'CashOut.IgnoreOneDocumentRestriction'
           ,'TSC-5516. CashOut.IgnoreOneDocumentRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Sale'
           ,100
           ,@maxId + 1)
GO