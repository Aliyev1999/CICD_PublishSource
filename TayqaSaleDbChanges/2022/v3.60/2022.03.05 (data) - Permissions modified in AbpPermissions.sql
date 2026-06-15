update AbpPermissions
set Name = REPLACE(Name,'Pages.PlatformManagement.Administration.ClientManagement','Pages.PlatformManagement.Administration.ClientAndSalesmanManagement')
where Name like 'Pages.PlatformManagement.Administration.ClientManagement%'

go