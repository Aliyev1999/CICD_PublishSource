create table dbo.DTM_WebReportTemplate
(
    Id                   int identity
        constraint PK_DTM_WebReportTemplate
            primary key,
    TenantId             int
        constraint DF_DTM_WebReportTemplate_TenantId default 1 not null,
    CreatorUserId        bigint,
    CreationTime         datetime                              not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    IsDeleted            bit
        constraint DF_DTM_WebReportTemplate_IsDeleted default 0,
    DeleterUserId        bigint,
    DeletionTime         datetime,
    SqlQuery             varchar(max)                          not null,
    Name                 nvarchar(100)                         not null,
    Code                 nvarchar(100)                         not null,
    Description          nvarchar(200)                         not null,
    PermissionType       tinyint                               not null,
    Module               tinyint,
    IsActive             bit
        constraint DF_DTM_WebReportTemplate_IsActive default 1 not null,
    GridStateJson        nchar(10)
)
go

