--TDP
insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.PlatformManagement.Administration.RestrictionManagement', 1, UserId from AbpPermissions
where Name like 'Pages.PlatformManagement.Administration.DocumentRestrictions' or Name like 'Pages.SaleManagement.ItemManagement'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.PlatformManagement.Administration.SalesmanManagement','Pages.PlatformManagement.Administration.ClientManagement.SalesmanManagement')
where Name like 'Pages.PlatformManagement.Administration.SalesmanManagement%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.PlatformManagement.Administration.DocumentRestrictions','Pages.PlatformManagement.Administration.RestrictionManagement.DocumentRestrictions')
where Name like 'Pages.PlatformManagement.Administration.DocumentRestrictions%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.ItemManagement.ItemRestriciton','Pages.PlatformManagement.Administration.RestrictionManagement.ItemRestriciton')
where Name like 'Pages.SaleManagement.ItemManagement.ItemRestriciton%'
go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.ItemManagement.ItemWarehouseRestriction','Pages.PlatformManagement.Administration.RestrictionManagement.ItemWarehouseRestriction')
where Name like 'Pages.SaleManagement.ItemManagement.ItemWarehouseRestriction%'
go

--Sale management
insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.SaleManagement.OrderManagement.Orders', 1, UserId from AbpPermissions
where Name like 'Pages.SaleManagement.OrderManagement'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.OrderManagement','Pages.SaleManagement.OrderManagement.Orders')
where Name like 'Pages.SaleManagement.OrderManagement.%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.OrderManagementAdvanced','Pages.SaleManagement.OrderManagement.OrderStatuses')
where Name like 'Pages.SaleManagement.OrderManagementAdvanced%'

go

