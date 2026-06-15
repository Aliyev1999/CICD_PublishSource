
update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.ItemManagement.OrderItemGroups','Pages.SaleManagement.ItemManagement.ItemGroups.OrderItemGroups')
where Name like 'Pages.SaleManagement.ItemManagement.OrderItemGroups'
go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.PlanFact.Groups','Pages.SaleManagement.ItemManagement.ItemGroups.ItemGroup.Groups')
where Name = 'Pages.SaleManagement.PlanFact.Groups'
go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.ItemGroups','Pages.SaleManagement.ItemManagement.ItemGroups.ItemGroup')
where Name like 'Pages.SaleManagement.ItemGroups'
go


