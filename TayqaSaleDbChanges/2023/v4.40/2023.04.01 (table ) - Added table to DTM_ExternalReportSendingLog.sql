create table DTM_ExternalReportSendingLog
(
    Id                  int identity
        constraint PK__DTM_Exte__3214EC070C247F8E
            primary key,
    ExternalReportId    int                                         not null,
    CreationTime        datetime
        constraint DF__DTM_Exter__Creat__09E33FD6 default getdate() not null,
    SendingScheduleTime datetime
        constraint DF__DTM_Exter__Sendi__0AD7640F default getdate() not null
)
go