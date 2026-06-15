-- auto-generated definition
create table DTM_DynamicGroupedWebScreen
(
    Id                   int identity
        primary key,
    Name                 nvarchar(100),
    Code                 nvarchar(100),
    Module               tinyint,
    CreatorUserId        bigint,
    CreationTime         datetime                                    not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    TenantId             int
        constraint DF_DTM_DynamicGroupedWebScreen_TenantId default 1 not null,
    Folder               int,
    SubFolder            int,
    MenuPlace            tinyint,
    CssClass             nvarchar(50),
    DeleterUserId        bigint,
    DeletionTime         datetime,
    IsDeleted            bit
        constraint DTM_DynamicGroupedWebScreen_IsDeleted default 0   not null
)
go

