create table dbo.DTM_CustomAppDashboardVisual
(
    Id          int identity
        constraint PK__SYS_Dyna__3214EC076650B544
            primary key,
    DashboardId int                                                     not null,
    ColumnName  nvarchar(50)                                            not null,
    Color       nvarchar(10)                                            not null,
    FontColor   nvarchar(10)                                            not null,
    Icon        nvarchar(500),
    IconId      int,
    Label       nvarchar(100)                                           not null,
    TenantId    int
        constraint DF_SYS_DynamicCustomDashboardCard_TenantId default 1 not null
)
go

