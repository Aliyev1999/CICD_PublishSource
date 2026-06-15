create table dbo.MSG_NotificationFeedback
(
    Id                 int identity
        constraint PK_MSG_NotificationFeedback
            primary key,
    UserId             bigint                                      not null,
    ReasonId           int                                         null,
    ClientId           bigint                                      null,
    NotificationId     int                                         not null,
    Note               nvarchar(250),
    CreationTime       datetime
        constraint DF_MSG_NotificationFeedback default getdate() not null
)
go