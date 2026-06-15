create table OP_RequestQueueCashTransferExtension
(
    Id                   int         not null
    primary key,
    Amount               float       not null,
    SenderCashCardCode   varchar(50) not null,
    RecieverCashCardCode varchar(50) not null
)

go

create table OP_IncomingLogCashTransferExtension
(
    Id                   int         not null
        primary key,
    Amount               float       not null,
    SenderCashCardCode   varchar(50) not null,
    RecieverCashCardCode varchar(50) not null
)