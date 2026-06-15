create table WPM_WorkExecutionClientConfirmStatus
(
    Id                        int identity
        primary key,
    TaskClientId              int      not null,
    ConfirmedOrRejected       bit      not null,
    ConfirmedOrRejectedDate   datetime not null,
    ConfirmerOrRejecterUserId int      not null
)
go
