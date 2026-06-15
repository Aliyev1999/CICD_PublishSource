
create table SYS_MobileReport
(
    Id                   int identity primary key,
    Name                 nvarchar(100),
    Code                 nvarchar(100),
    Description          nvarchar(200),
    Module               tinyint,
    SqlQuery             varchar(max) not null,
    CreatorUserId        bigint,
    CreationTime         datetime     not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    ParentId             int
)
go
