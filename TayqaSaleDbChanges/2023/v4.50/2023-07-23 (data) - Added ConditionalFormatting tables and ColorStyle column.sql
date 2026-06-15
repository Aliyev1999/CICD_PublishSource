create table DTM_MobileReportConditionalFormatting
(
    Id             int identity
        primary key,
    FieldName      nvarchar(200) not null,
    MobileReportId int           not null,
    Formula        nvarchar(max) not null,
    FontColor      nvarchar(50)
)
go

create table DTM_MobileScreenConditionalFormatting
(
    Id             int identity
        primary key,
    FieldName      nvarchar(200) not null,
    MobileScreenId int           not null,
    Formula        nvarchar(max) not null,
    FontColor      nvarchar(50)
)
go

alter table  DTM_MobileScreenCardProperty
add
 ColorStyle         tinyint default 1 not null

alter table  DTM_MobileReportCardProperty
add
 ColorStyle         tinyint default 1 not null
