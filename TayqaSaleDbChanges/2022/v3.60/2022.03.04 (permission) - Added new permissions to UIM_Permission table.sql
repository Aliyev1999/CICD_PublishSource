DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'WarehouseOperation.Direct.StockDemand.PrintLocal', '', 2, GETDATE(), 3, 'Sale', null);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'WarehouseOperation.Direct.StockDemand');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'WarehouseOperation.Direct.StockDemand.PrintErp', '', 2, GETDATE(), 3, 'Sale', null);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.WorkPlan');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Management.UserMonitoring.WorkPlan.PhotoFeedback', '', 2, GETDATE(), 3, 'Workplan', 1);

go
