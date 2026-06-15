declare @parentId int = (select Id from UIM_Permission where ObjectName = 'Management.Reports')

update UIM_Permission
set ObjectName = 'Management.Reports.RouteStats', ParentId = @parentId
WHERE ObjectName = 'Management.RouteStats'

update UIM_Permission
set ObjectName = 'Management.Reports.SaleRouteStats', ParentId = @parentId
WHERE ObjectName = 'Management.SaleRouteStats'

update UIM_Permission
set ObjectName = 'Management.Reports.CashPlanAnalysis', ParentId = @parentId
WHERE ObjectName = 'Management.CashPlanAnalysis'

update UIM_Permission
set ObjectName = 'Management.Reports.PhotoGallery', ParentId = @parentId
WHERE ObjectName = 'Management.PhotoGallery'

update UIM_Permission
set ObjectName = 'Management.Reports.PlanFact', ParentId = @parentId
WHERE ObjectName = 'Management.PlanFact'
go
declare @parentId int = (select Id from UIM_Permission where ObjectName = 'Management.Reports.PlanFact')

update UIM_Permission
set ObjectName = 'Management.Reports.PlanFact.Amount', ParentId = @parentId
WHERE ObjectName = 'Management.PlanFact.Amount'

update UIM_Permission
set ObjectName = 'Management.Reports.PlanFact.Quantity', ParentId = @parentId
WHERE ObjectName = 'Management.PlanFact.Quantity'
go
declare @parentId int = (select Id from UIM_Permission where ObjectName = 'Management.Reports.PhotoGallery')
update UIM_Permission
set ObjectName = 'Management.Reports.PhotoGallery.GridView', ParentId = @parentId
WHERE ObjectName = 'Management.PhotoGallery.GridView'

update UIM_Permission
set ObjectName = 'Management.Reports.PhotoGallery.LikeDislike', ParentId = @parentId
WHERE ObjectName = 'Management.PhotoGallery.LikeDislike'

update UIM_Permission
set ObjectName = 'Management.Reports.PhotoGallery.ListView', ParentId = @parentId
WHERE ObjectName = 'Management.PhotoGallery.ListView'
go
