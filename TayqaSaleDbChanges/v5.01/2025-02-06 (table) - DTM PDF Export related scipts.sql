-- auto-generated definition
create table DTM_PdfExport
(
    Id                     int identity,
    TemplateFilePath       nvarchar(max)             not null,
    MainSql                nvarchar(max),
    TableSql               nvarchar(max),
    ReferenceType          tinyint                   not null,
    ReferenceId            int                       not null,
    TenantId               int                       not null,
    CreatorUserId          bigint                    not null,
    CreationTime           datetime                  not null,
    LastModifierUserId     bigint,
    LastModificationTime   datetime,
    DeleterUserId          bigint,
    DeletionTime           datetime,
    IsDeleted              bit constraint DTM_PdfExport_IsDeleted default 0 not null,
    TemplateFileSecurePath as concat('NewFile-DTM-PdfExport', '-', [Id], reverse(left(reverse([TemplateFilePath]),
                                                                                      charindex('\', reverse([TemplateFilePath])))))
)
go


ALTER TABLE DTM_WebReport
    ADD HasPdfExport BIT NOT NULL DEFAULT 0

GO
ALTER TABLE DTM_WebScreen
    ADD HasPdfExport BIT NOT NULL DEFAULT 0