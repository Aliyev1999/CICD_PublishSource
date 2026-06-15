create table dbo.DTM_CustomAppDashboard
(
    Id                   int identity
        constraint PK__SYS_Dyna__3214EC07C84096F9
            primary key,
    Firm                 int,
    Name                 nvarchar(100),
    Code                 nvarchar(100),
    GroupName            nvarchar(100),
    DateType             tinyint,
    VisualDiagramType    tinyint,
    SqlQuery             nvarchar(max)                              not null,
    CreatorUserId        bigint                                     not null,
    CreationTime         datetime,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    TenantId             int                                        not null,
    IsActive             bit
        constraint DF_SYS_DynamicCustomDashboard_IsActive default 1 not null,
    IsDeleted            bit,
    DeleterUserId        bigint,
    DeletionTime         datetime
)
go

