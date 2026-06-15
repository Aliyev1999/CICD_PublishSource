create table dbo.DTM_DynamicWebReportTemplateUserMapping
(
    Id                          int identity
        primary key,
    ReferanceId                 int                                    not null,
    UserId                      int                                    not null,
    ToolType                    tinyint                                not null,
    TenantId                    int
)