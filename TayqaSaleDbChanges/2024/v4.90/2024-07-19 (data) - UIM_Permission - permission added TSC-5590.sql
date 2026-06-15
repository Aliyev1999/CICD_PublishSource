-- MandatoryCatalogSelection Permissions
DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.In.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Out.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.StockDemand.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Transfer.OnlineOffer.MandatoryCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

-- NoCatalogSelection Permissions

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.In.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Out.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.StockDemand.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Transfer.OnlineOffer.NoCatalogSelection', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

-- NoCatalogSelection.DirectApply Permissions

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 6, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.In.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Out.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.StockDemand.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer.OnlineOffer');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'WarehouseOperation.Direct.Transfer.OnlineOffer.NoCatalogSelection.DirectApply', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

-- TemplateRestriction.IgnoreInEdit Permissions

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.TemplateRestriction.IgnoreInEdit', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO

-- TemplateRestriction.ShowPreview Permissions

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Order.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleDispatch.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'SaleInvoice.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnDispatch.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'ReturnInvoice.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 3, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder.TemplateRestriction');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'PurchaseOrder.TemplateRestriction.ShowPreview', 'TSC-5590', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);
GO
