-- web grouped screen
alter table DTM_DynamicGroupedWebScreen add DeleterUserId bigint null
go
alter table DTM_DynamicGroupedWebScreen add DeletionTime datetime null
go
alter table DTM_DynamicGroupedWebScreen add IsDeleted bit not null
constraint DTM_DynamicGroupedWebScreen_IsDeleted default 0
with values
go

-- web screen
alter table DTM_WebScreen add DeleterUserId bigint null
go
alter table DTM_WebScreen add DeletionTime datetime null
go
alter table DTM_WebScreen add IsDeleted bit not null
constraint DTM_WebScreen_IsDeleted default 0
with values
go

-- web report
alter table DTM_WebReport add DeleterUserId bigint null
go
alter table DTM_WebReport add DeletionTime datetime null
go
alter table DTM_WebReport add IsDeleted bit not null
constraint DTM_WebReport_IsDeleted default 0
with values
go

-- web template based report
alter table DTM_WebTemplateBasedReport add DeleterUserId bigint null
go
alter table DTM_WebTemplateBasedReport add DeletionTime datetime null
go

-- auto generating report
alter table MSG_AutoGeneratingReport add DeleterUserId bigint null
go
alter table MSG_AutoGeneratingReport add DeletionTime datetime null
go
alter table MSG_AutoGeneratingReport add IsDeleted bit not null
constraint MSG_AutoGeneratingReport_IsDeleted default 0
with values
go

-- mobile report
alter table DTM_MobileReport add DeleterUserId bigint null
go
alter table DTM_MobileReport add DeletionTime datetime null
go
alter table DTM_MobileReport add IsDeleted bit not null
constraint DTM_MobileReport_IsDeleted default 0
with values
go

-- mobile screen
alter table DTM_MobileScreen add DeleterUserId bigint null
go
alter table DTM_MobileScreen add DeletionTime datetime null
go
alter table DTM_MobileScreen add IsDeleted bit not null
constraint DTM_MobileScreen_IsDeleted default 0
with values
go
