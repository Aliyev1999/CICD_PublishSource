DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Cash');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Cash.ShareOnWhatsapp', '', 2, GETDATE(), 6, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'CashOut')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 2, @parentId, N'CashOut.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'CheckPayment')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 3, @parentId, N'CheckPayment.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'CreditCardPayment')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 4, @parentId, N'CreditCardPayment.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'PurchaseOrder')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 5, @parentId, N'PurchaseOrder.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Order')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 6, @parentId, N'Order.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'SaleInvoice')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 7, @parentId, N'SaleInvoice.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'SaleDispatch')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 8, @parentId, N'SaleDispatch.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ReturnInvoice')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 9, @parentId, N'ReturnInvoice.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'ReturnDispatch')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 10, @parentId, N'ReturnDispatch.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'VoucherPayment')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 11, @parentId, N'VoucherPayment.ShareOnWhatsapp', '', 2, GETDATE(), 3, 'Sale');
