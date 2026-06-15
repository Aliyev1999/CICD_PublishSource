create table dbo.DTM_FolderStructure
(
    Id                   int identity
        constraint PK_SYS_FolderStructure
            primary key,
    TenantId             int           not null,
    ModuleId             tinyint       not null,
    ParentId             int,
    Type                 tinyint       not null,
    Name                 nvarchar(250) not null,
    Code                 nvarchar(50)  not null,
    CreatorUserId        bigint,
    CreationTime         datetime      not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    IsDeleted            bit           not null
)
go

