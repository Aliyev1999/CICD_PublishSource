create table dbo.SYS_DynamicNotification
(
    Id                      int identity
        constraint PK_SYS_DynamicNotification
            primary key,
    Firm                    smallint,
    CreatorUserId           bigint,
    CreationTime            datetime      not null,
    LastModifierUserId      bigint,
    LastModificationTime    datetime,
    TenantId                int           not null,
    StartDate               date          not null,
    EndDate                 date          not null,
    Name                    nvarchar(100) not null,
    Code                    nvarchar(100) not null,
    DynamicNotificationType tinyint		not null,
    IsActive                bit           not null,
    SendingSchedule         nvarchar(max) not null,
    IntervalType            tinyint,
    SqlQuery                nvarchar(100),
    PushMethodId            int,
    IsDeleted               bit           not null,
    LastPushTime            datetime
)
go