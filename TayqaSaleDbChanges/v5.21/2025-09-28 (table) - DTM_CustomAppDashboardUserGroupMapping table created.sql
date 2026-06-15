create table DTM_CustomAppDashboardUserGroupMapping (
	Id int primary key identity,
	DashboardId int not null,
	GroupId int not null,
	TenantId int not null
)