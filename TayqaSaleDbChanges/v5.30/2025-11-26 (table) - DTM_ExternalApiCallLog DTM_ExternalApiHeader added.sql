create table dbo.DTM_ExternalApiCallLog
(
    Id                  int identity
        primary key,
    ExternalApiId       int                        not null,
    CreationTime        datetime default getdate() not null,
    SendingScheduleTime datetime default getdate() not null
)
go

ALTER TABLE DTM_ExternalApiHeader
    ADD  ParameterType tinyint default 1 not null