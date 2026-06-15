DECLARE @maxId INT;
SET @maxId = (SELECT ISNULL(MAX(Id), 0) FROM UIM_Permission);

-- For IN
DECLARE @parentId_In INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.In');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_In, 'WarehouseOperation.Direct.In.OperationImage', 'Permission for In Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 1);

-- For OUT
DECLARE @parentId_Out INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Out');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_Out, 'WarehouseOperation.Direct.Out.OperationImage', 'Permission for Out Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 2);

-- For TRANSFER
DECLARE @parentId_Transfer INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.Transfer');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_Transfer, 'WarehouseOperation.Direct.Transfer.OperationImage', 'Permission for Transfer Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 3);
		   
		   
-- For StockDemand
DECLARE @parentId_StockDemand INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_StockDemand, 'WarehouseOperation.Direct.StockDemand.OperationImage', 'Permission for StockDemand Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 4);

-- Order
DECLARE @parentId_Order INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Order');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_Order, 'Order.OperationImage', 'Permission for Order Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 5);

-- SaleDispatch
DECLARE @parentId_SaleDispatch INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleDispatch');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_SaleDispatch, 'SaleDispatch.OperationImage', 'Permission for SaleDispatch Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 6);

-- SaleInvoice
DECLARE @parentId_SaleInvoice INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'SaleInvoice');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_SaleInvoice, 'SaleInvoice.OperationImage', 'Permission for SaleInvoice Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 7);

-- ReturnDispatch
DECLARE @parentId_ReturnDispatch INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnDispatch');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_ReturnDispatch, 'ReturnDispatch.OperationImage', 'Permission for ReturnDispatch Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 8);

-- ReturnInvoice
DECLARE @parentId_ReturnInvoice INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ReturnInvoice');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_ReturnInvoice, 'ReturnInvoice.OperationImage', 'Permission for ReturnInvoice Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 9);

-- PurchaseOrder
DECLARE @parentId_ServiceOrder INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'PurchaseOrder');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_ServiceOrder, 'PurchaseOrder.OperationImage', 'Permission for PurchaseOrder Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Purchase', 100, @maxId + 10);


-- Cash
DECLARE @parentId_Cash INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Cash');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_Cash, 'Cash.OperationImage', 'Permission for Cash Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 11);

-- CashOut
DECLARE @parentId_CashOut INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'CashOut');
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
            [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId_CashOut, 'CashOut.OperationImage', 'Permission for CashOut Operation Image', NULL, 2, NULL, GETDATE(), null, 6, 'Sale', 100, @maxId + 12);
