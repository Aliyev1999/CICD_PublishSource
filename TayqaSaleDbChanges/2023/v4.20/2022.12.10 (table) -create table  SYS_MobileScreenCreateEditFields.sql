create table SYS_MobileScreenCreateEditFields
(
    Id              int identity
        primary key,
    MobileScreenId  int                                                        not null,
    Name            nvarchar(50)                                               not null,
    SqlParametrName nvarchar(50)                                               not null,
    SqlParametrType tinyint                                                    not null,
    IsCreateField   bit default 0                                              not null,
    IsEditField     bit default 0                                              not null,
    IsRequired      bit default 0                                              not null,
    TenantId        int
        constraint SYS_MobileScreenCreateEditFields_TenantId_Default default 1 not null
)
go