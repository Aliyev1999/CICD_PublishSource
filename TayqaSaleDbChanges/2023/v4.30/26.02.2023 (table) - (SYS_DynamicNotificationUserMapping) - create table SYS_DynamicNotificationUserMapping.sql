create table dbo.SYS_DynamicNotificationUserMapping
(
    DynamicNotificationId int     not null,
    UserId                int     not null,
    ToolType              tinyint not null,
    TenantId              int     not null,
    Id                    int identity
        constraint PK_SYS_DynamicNotificationUserMapping
            primary key
)
go