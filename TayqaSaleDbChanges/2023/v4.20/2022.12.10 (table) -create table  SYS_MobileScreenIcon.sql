create table SYS_MobileScreenIcons
(
    Id       int identity
        constraint PK_SYS_MobileScreenIcons
            primary key,
    Url      nvarchar(50)                                      not null,
    TenantId int
        constraint DF_SYS_MobileScreenIcons_TenantId default 1 not null,
    Name     nvarchar(50)
)
go