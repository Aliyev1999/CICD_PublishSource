-- auto-generated definition
create table OP_ThirdPartyAuditLog
(
    Id                   int identity
        primary key,
    RequestId            int not null,
    RejecterUserId       bigint,
    RejectionTime        datetime,
    ConfirmerUserId      bigint,
    ConfirmationTime     datetime,
    LastModifierUserId   bigint,
    LastModificationTime datetime
)
go
