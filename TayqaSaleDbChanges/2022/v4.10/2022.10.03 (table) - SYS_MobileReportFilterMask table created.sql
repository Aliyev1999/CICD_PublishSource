
create table SYS_MobileReportFilterMask
(
    Id         int identity
        primary key,
    ReportId   int           not null,
    FieldName  nvarchar(100) not null,
    FilterMask nvarchar(3)   not null
)
go
