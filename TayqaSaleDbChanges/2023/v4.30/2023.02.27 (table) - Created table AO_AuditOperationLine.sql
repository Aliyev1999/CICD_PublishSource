create table AO_AuditOperationLine
(
    Id                   int identity
        constraint PK_AO_AuditOperationLine
            primary key,
    ReasonId             int     not null,
    Amount               float   not null,
    Status               tinyint not null,
    CreatorUserId        bigint,
    CreationTime         date,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    Description          nvarchar(500),
    AuditOperationId     int,
    IsDeleted            bit
)
go