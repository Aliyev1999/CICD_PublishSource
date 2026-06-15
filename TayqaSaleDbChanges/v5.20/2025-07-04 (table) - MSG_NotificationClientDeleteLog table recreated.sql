create table dbo.MSG_NotificationClientDeleteLog
(
    Id                   int identity
        constraint PK_MSG_NotificationClientDeleteLog
            primary key,
    UserId   int                                                         not null,
    ClientId int                                                         not null,
    NotificationId int                                                   not null,
    CreationTime         datetime
        constraint DF_MSG_NotificationClientDeleteLog_CreationTime default getdate() not null
)
go