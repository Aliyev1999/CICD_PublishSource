declare @parentId int = (select Id from UIM_Permission where ObjectName = 'Reports.general')
declare @id int = (select MAX(Id) + 1  from UIM_Permission)

insert into UIM_Permission([ParentId], [ObjectName], [Description], [CreatedUserId],  [CreatedDate],  [LicenseUserType], [Module], [OrderNo], [Id])
values(@parentId, 'Reports.General.WarehouseInOutReport','Reports General WarehouseInOutReport', 2, GETDATE(), 6, 'Sale', 0, @id)