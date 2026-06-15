create table MSG_NotificationUserGroup
(
    Id             int identity
        constraint PK_MSG_NotificationUserGroup
            primary key,
    NotificationId int                                                         not null,
    UserGroupId    bigint                                                      not null,
    CreatorUserId  bigint,
    CreationTime   datetime
        constraint DF_MSG_NotificationUserGroup_CreationTime default getdate() not null,
    IsActive       bit                                                         not null
)
go