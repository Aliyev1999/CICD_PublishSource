create table UIM_UserGroupPermission
(
    Id              int identity primary key,
    GroupId         int      not null,
    Firm            smallint not null,
    PermissionId    smallint not null,
    PermissionValue tinyint  not null,
    ModifiedUserId  int,
    CreatedUserId   int      not null,
    ModifiedDate    datetime,
    CreatedDate     datetime not null
)
GO