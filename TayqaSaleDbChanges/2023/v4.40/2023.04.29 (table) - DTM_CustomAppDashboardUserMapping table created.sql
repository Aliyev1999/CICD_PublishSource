create table dbo.DTM_CustomAppDashboardUserMapping
(
    Id          int identity
        primary key,
    DashboardId int                                                            not null,
    UserId      bigint,
    TenantId    int
        constraint DF_SYS_DynamicCustomDashboardUserMapping_TenantId default 1 not null,
    IsDeleted   bit default 0                                                  not null
)
go

