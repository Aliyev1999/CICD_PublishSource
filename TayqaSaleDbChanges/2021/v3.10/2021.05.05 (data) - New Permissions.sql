DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Management.BannedClient', N'', 2, getdate(), 1,  3, N'Sale', 0, @maxId+1);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.BannedClient')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Management.BannedClient.Add', N'', 2, getdate(), 1,  3, N'Sale', 0, @maxId+2);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Management.BannedClient.Remove', N'', 2, getdate(), 1,  3, N'Sale', 0, @maxId+3);

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Manager', N'Inventory.RequestSupply.Manager', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+1);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@maxId+1, N'Inventory.RequestSupply.Manager.Register', N'Inventory.RequestSupply.Manager.Register', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+2);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@maxId+2, N'Inventory.RequestSupply.Manager.Register.ScanAllowed', N'Inventory.RequestSupply.Manager.Register.ScanAllowed', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+3);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@maxId+2, N'Inventory.RequestSupply.Manager.Register.ManualSelectAllowed', N'Inventory.RequestSupply.Manager.Register.ManualSelectAllowed', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+4);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser,  LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Driver', N'Inventory.RequestSupply.Driver', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+5);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@maxId+5, N'Inventory.RequestSupply.Driver.Register', N'Inventory.RequestSupply.Driver.Register', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+6);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser,  LicenseUserType, Module, OrderNo, Id)
values (@maxId+6, N'Inventory.RequestSupply.Driver.Register.ScanAllowed', N'Inventory.RequestSupply.Driver.Register.ScanAllowed', null, 2, null, getdate(), null, 6, N'Inventory', 100, @maxId+7);

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'CashOut')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'CashOut.Salesman', N'', 2, getdate(), null, 6, N'Sale', 0, @maxId+1);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'CashOut.Salesman')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'CashOut.Salesman.Select', N'', 2, getdate(), null, 6, N'Sale', 0, @maxId+2);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Cash')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Cash.Salesman', N'', 2, getdate(), null, 6, N'Sale', 0, @maxId+3);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Cash.Salesman')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Cash.Salesman.Select', N'', 2, getdate(), null, 6, N'Sale', 0, @maxId+4);

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.Client', N'', 2, getdate(), null,  6, N'Inventory', 0, @maxId+1);

GO

delete from UIM_Permission where ObjectName ='Inventory.Operation.NotFound.CreateEdit';

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Driver.Register')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Driver.Register.ManualInputAllowed', N'', 2, getdate(),  6, N'Inventory', 0, @maxId+1);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Manager.Register')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Manager.Register.ManualInputAllowed', N'', 2, getdate(),  6, N'Inventory', 0, @maxId+2);

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Driver')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Driver.Client', N'', 2, getdate(),  6, N'Inventory', 0, @maxId+1);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.RequestSupply.Driver.Client')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Driver.Client.Map', N'', 2, getdate(), 6, N'Inventory', 0, @maxId+2);

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.RequestSupply.Driver.Client.Navigation', N'', 2, getdate(),  6, N'Inventory', 0, @maxId+3);
GO