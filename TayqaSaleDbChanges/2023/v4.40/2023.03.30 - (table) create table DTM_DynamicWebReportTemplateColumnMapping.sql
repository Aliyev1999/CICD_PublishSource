create table dbo.DTM_DynamicWebReportTemplateColumnMapping
(
    Id                          int identity
        primary key,
    ReferenceId                 int                                    not null,
    FieldName                   nvarchar(250)                          not null
)