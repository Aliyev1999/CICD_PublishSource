DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.Stock', N'Inventory.Stock', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+1);
go

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.Report')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.Report.InventoryStock', N'Inventory.Report.InventoryStock', null, 2, null, getdate(), null, 5, N'Inventory', 100, @maxId+1);