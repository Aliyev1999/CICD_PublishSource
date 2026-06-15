update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.ItemManagement.Items','Pages.SaleManagement.ItemManagement.ItemPenetrationInfo')
where Name like 'Pages.SaleManagement.ItemManagement.Items%'

go