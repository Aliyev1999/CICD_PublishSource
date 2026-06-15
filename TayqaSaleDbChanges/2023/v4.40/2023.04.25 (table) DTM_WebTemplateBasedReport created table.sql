create table dbo.DTM_WebTemplateBasedReport
(
    Id                   int identity
        constraint PK_DTM_WebTemplateBasedReport
            primary key,
    TenantId             int
        constraint DF_DTM_WebTemplateBasedReport_TenantId default 1 not null,
    TemplateId           int                                        not null,
    CreatorUserId        bigint,
    CreationTime         datetime                                   not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    SqlQuery             varchar(max)                               not null,
    Name                 nvarchar(100)                              not null,
    Code                 nvarchar(100)                              not null,
    Description          nvarchar(200),
    Module               tinyint,
    IsActive             bit
        constraint DF_DTM_WebTemplateBasedReport_IsActive default 1 not null,
    GridStateJson        nvarchar(200),
    IsDeleted            bit                                        not null
)
go

