DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Sale.SpecialCode', '', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);

GO

DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module,
                                               OrderNo, Id)
VALUES (@parentId,
        N'WarehouseOperation.Direct.Transfer.ScanSerialNumbers.AutoOpen',
        N'GSP-61',
        2,
        GETDATE(),
        0,
        6,
        N'Sale',
        100,
        @maxId + 1)

go

DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module,
                                               OrderNo, Id)
VALUES (@parentId,
        N'ReturnInvoice.ScanSerialNumbers.AutoOpen',
        N'GSP-61',
        2,
        GETDATE(),
        0,
        6,
        N'Sale',
        100,
        @maxId + 1)

go


DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module,
                                               OrderNo, Id)
VALUES (@parentId,
        N'SaleInvoice.ScanSerialNumbers.AutoOpen',
        N'GSP-61',
        2,
        GETDATE(),
        0,
        6,
        N'Sale',
        100,
        @maxId + 1)

go