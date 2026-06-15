
create table SYS_MobileReportUserMapping
(
    Id       int identity primary key,
    ReportId int not null,
    UserId   int not null
)
go
