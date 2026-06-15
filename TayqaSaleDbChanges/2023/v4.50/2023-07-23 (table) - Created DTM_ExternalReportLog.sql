create table DTM_ExternalReportLog
(
    Id       int identity
        primary key,
    ReportId int      not null,
    LogTime  datetime not null,
    Details  nvarchar(max),
    Status   tinyint
)
go

create index IX_ExternalReportLog_LogTime
    on DTM_ExternalReportLog (LogTime)
go

