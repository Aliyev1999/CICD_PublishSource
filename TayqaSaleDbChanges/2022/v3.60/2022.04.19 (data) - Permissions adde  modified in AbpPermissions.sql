
--Sale management
update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.Distribution','Pages.SaleManagement.PlanFact.DistributionTargets')
where Name like 'Pages.SaleManagement.Distribution.%'

go

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.SaleManagement.PlanFact.SaleTargets', 1, UserId from AbpPermissions
where Name like 'Pages.SaleManagement.PlanFact.ItemGroupPlans' or Name like 'Pages.SaleManagement.PlanFact.AnalyzingPlanFact'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.PlanFact.AnalyzingPlanFact','Pages.SaleManagement.PlanFact.SaleTargets.AnalyzingPlanFact')
where Name like 'Pages.SaleManagement.PlanFact.AnalyzingPlanFact%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.PlanFact.ItemGroupPlans','Pages.SaleManagement.PlanFact.SaleTargets.ItemGroupPlans')
where Name like 'Pages.SaleManagement.PlanFact.ItemGroupPlans%'

go

insert into AbpPermissions(CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, UserId)
select distinct GETDATE(),2,'UserPermissionSetting', 1, 'Pages.SaleManagement.PlanFact.CashTargets', 1, UserId from AbpPermissions
where Name like 'Pages.SaleManagement.PlanFact.CashPlan' or Name like 'Pages.SaleManagement.PlanFact.AnalyzingCashPlanFact'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.PlanFact.CashPlan','Pages.SaleManagement.PlanFact.CashTargets.CashPlan')
where Name like 'Pages.SaleManagement.PlanFact.CashPlan%'

go

update AbpPermissions
set Name = REPLACE(Name,'Pages.SaleManagement.PlanFact.AnalyzingCashPlanFact','Pages.SaleManagement.PlanFact.CashTargets.AnalyzingCashPlanFact')
where Name like 'Pages.SaleManagement.PlanFact.AnalyzingCashPlanFact%'

go