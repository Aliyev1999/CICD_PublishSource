--WPM Management

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Wpm.Management', 1, UserId from AbpPermissions
where Name like 'Pages.Wpm.Tasks' or Name like 'Pages.Wpm.ActionGroups'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Wpm.Tasks','Pages.Wpm.Management.Tasks')
where Name like 'Pages.Wpm.Tasks%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Wpm.ActionGroups','Pages.Wpm.Management.ActionGroups')
where Name like 'Pages.Wpm.ActionGroups%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Wpm.Reports.Sale.DailySaleRouteStatistics','Pages.Wpm.Reports.DailySaleRouteStatistics')
where Name like 'Pages.Wpm.Reports.Sale.DailySaleRouteStatistics%'
go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Wpm.Reports.Sale.DailySaleRouteStatistics','Pages.Wpm.Reports.DailySaleRouteStatistics')
where Name like 'Pages.Wpm.Reports.Sale.DailySaleRouteStatistics%'
go

--WPM Calendar

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Wpm.Calendar.WorkPlanCalendar', 1, UserId from AbpPermissions
where Name like 'Pages.Wpm.Calendar'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Wpm.Reports.Sale.SaleRouteManagement','Pages.Wpm.Calendar.SaleRouteManagement')
where Name like 'Pages.Wpm.Reports.Sale.SaleRouteManagement%'

go

-- CHl Management
insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Chl.Management', 1, UserId from AbpPermissions
where Name like 'Pages.Chl.Surveys' or Name like 'Pages.Chl.Questions'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Questions','Pages.Chl.Management.Questions')
where Name like 'Pages.Chl.Questions%'
go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Surveys','Pages.Chl.Management.Surveys')
where Name like 'Pages.Chl.Surveys%'

go


-- KPI

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Chl.KPI', 1, UserId from AbpPermissions
where Name like 'Pages.Chl.Reports.RepresentativeKPI' or Name like 'Pages.Chl.Reports.ClientKPI' or Name like 'Pages.Chl.Reports.ComplexKPI'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.RepresentativeKPI', 'Pages.Chl.KPI.RepresentativeKPI')
where Name like 'Pages.Chl.Reports.RepresentativeKPI%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.ClientKPI', 'Pages.Chl.KPI.ClientKPI')
where Name like 'Pages.Chl.Reports.ClientKPI%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.ComplexKPI', 'Pages.Chl.KPI.ComplexKPI')
where Name like 'Pages.Chl.Reports.ComplexKPI%'

go

--  CHLResult

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Chl.CHLResult', 1, UserId from AbpPermissions
where Name like 'Pages.Chl.Reports.SurveyApprove' or Name like 'Pages.Chl.Reports.SurveyProceeding' or Name like 'Pages.Chl.Reports.ReasonsReport'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.SurveyApprove', 'Pages.Chl.CHLResult.SurveyApprove')
where Name like 'Pages.Chl.Reports.SurveyApprove%'

go


update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.SurveyProceeding', 'Pages.Chl.CHLResult.SurveyProceeding')
where Name like 'Pages.Chl.Reports.SurveyProceeding%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Reports.ReasonsReport', 'Pages.Chl.CHLResult.ReasonsReport')
where Name like 'Pages.Chl.Reports.ReasonsReport%'

go

--Normative

go
update AbpPermissions
set Name = REPLACE(Name,'Pages.Chl.Normatives', 'Pages.Chl.Management.Normatives')
where Name like 'Pages.Chl.Normatives%'

go


-- Inventory Management
insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Inventory.Management', 1, UserId from AbpPermissions
where Name like 'Pages.Inventory.InventoryContents' or Name like 'Pages.Inventory.TransportPackages' or Name like 'Pages.Inventory.EquipmentItemMapping'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Inventory.InventoryContents', 'Pages.Inventory.Management.InventoryContents')
where Name like 'Pages.Inventory.InventoryContents%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Inventory.TransportPackages', 'Pages.Inventory.Operation.TransportPackages')
where Name like 'Pages.Inventory.TransportPackages%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Inventory.EquipmentItemMapping', 'Pages.Inventory.Management.EquipmentItemMapping')
where Name like 'Pages.Inventory.EquipmentItemMapping%'

go

-- Inventory Catalog Management

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.Inventory.Management.CatalogManagement', 1, UserId from AbpPermissions
where Name like 'Pages.Inventory.Catalogs' or Name like 'Pages.Inventory.CatalogGroups'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Inventory.Catalogs', 'Pages.Inventory.Management.CatalogManagement.Catalogs')
where Name like 'Pages.Inventory.Catalogs%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.Inventory.CatalogGroups', 'Pages.Inventory.Management.CatalogManagement.CatalogGroups')
where Name like 'Pages.Inventory.CatalogGroups%'

