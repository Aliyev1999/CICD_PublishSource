create table dbo.MD_ClientGpsDataLog
(
    Id            bigint identity
        constraint [PK_dbo.MD_ClientGpsDataLog]
            primary key,
    Firm          smallint not null,
    ClientId      int      not null,
    Latitude      float,
    Longitude     float,
    Note          nvarchar(400) collate SQL_Latin1_General_CP1_CI_AS,
    CreatedUserId int      not null,
    CreatedDate   datetime not null
)