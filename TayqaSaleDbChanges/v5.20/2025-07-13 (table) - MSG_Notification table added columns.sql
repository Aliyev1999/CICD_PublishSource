alter table MSG_NotificationUserReadLog
    add UserId int not null default 0

go

alter table MSG_NotificationUserReadLog
    add NotificationId int not null default 0

go

UPDATE l
SET l.UserId         = u.UserId,
    l.NotificationId = u.NotificationId
FROM MSG_NotificationUserReadLog l
         join MSG_NotificationUser u on l.NotificationUserId = u.Id
go

----------------------------------------------

alter table MSG_NotificationClientReadLog
    add ClientId int not null default 0

go

alter table MSG_NotificationClientReadLog
    add NotificationId int not null default 0

go

alter table MSG_NotificationClientReadLog
    add UserId int not null default 0

go

UPDATE l
SET l.UserId         = u.UserId,
    l.ClientId       = c.ClientId,
    l.NotificationId = c.NotificationId
FROM MSG_NotificationClientReadLog l
         join MSG_NotificationClient c on l.NotificationClientId = c.Id
         join MSG_NotificationUser u on l.NotificationUserId = u.Id

go