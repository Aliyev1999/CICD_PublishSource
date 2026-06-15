create table SYS_DynamicComponent
(
    Id                   int identity
        primary key,
    Name                 nvarchar(100) not null,
    Description          nvarchar(200),
    TableName            varchar(200)  not null,
    DisplayName          nvarchar(100) not null,
    UsedColumn           nvarchar(200) not null,
    Condition            nvarchar(500),
    Separator            char,
    IsActive             bit           not null,
    CreatorUserId        bigint        not null,
    CreationTime         datetime      not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    TenantId             int           not null
)
go