create table FM_Folders
(
    Id                   int identity primary key,
    Firm                 smallint      not null,
    Code                 nvarchar(50)  not null,
    Name                 nvarchar(100) not null,
    ParentId             int,
    IsActive             bit      default 1,
    CreatorUserId        bigint references AbpUsers,
    CreationTime         datetime default getdate(),
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    IsDeleted            bit      default 0,
    DeleterUserId        bigint,
    DeletionTime         datetime
)
go

create table FM_Files
(
    Id                   int identity primary key,
    Firm                 smallint      not null,
    Name                 nvarchar(200) not null,
    Description          nvarchar(500),
    Type                 tinyint,
    Path                 nvarchar(500) not null,
    SecureUrl            as concat('NewFile-FM_File', '-', [Id],
                                   reverse(left(reverse([Path]), charindex('\', reverse([Path]))))),
    FolderId             int references FM_Folders,
    Specode1             nvarchar(100),
    Specode2             nvarchar(100),
    Specode3             nvarchar(100),
    CreatorUserId        bigint references AbpUsers,
    CreationTime         datetime default getdate(),
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    IsDeleted            bit      default 0,
    DeleterUserId        bigint,
    DeletionTime         datetime
)
go

create table FM_FileUserMapping
(
    Id            int identity primary key,
    FileId        int references FM_Files,
    ReferenceType tinyint not null,
    ReferenceId   bigint,
    CreatorUserId bigint references AbpUsers,
    CreationTime  datetime default getdate()
)
go

create table FM_FileClientMapping
(
    Id            int identity primary key,
    FileId        int references FM_Files,
    ReferenceType tinyint not null,
    ReferenceId   bigint,
    CreatorUserId bigint references AbpUsers,
    CreationTime  datetime default getdate()
)
go