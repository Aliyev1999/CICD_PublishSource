DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Cash.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Cash.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO
DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'CashOut.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'CashOut.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.Print');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.Print.OnlineBookmark', 'TSC-5809', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO