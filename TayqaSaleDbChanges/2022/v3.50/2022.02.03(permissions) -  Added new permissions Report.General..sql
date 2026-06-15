DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, ModifiedUserId, CreatedUserId, ModifiedDate, CreatedDate, OnlyHybridUser, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Reports.General.StockDemand', N'', NULL, 2, NULL, GETDATE(), NULL, 3, N'Sale', 0, @maxId + 1);
