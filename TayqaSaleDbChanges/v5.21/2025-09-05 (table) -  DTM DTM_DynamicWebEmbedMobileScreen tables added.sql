CREATE TABLE dbo.DTM_DynamicWebEmbedMobileScreen
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(255) NULL,
    Code NVARCHAR(255) NULL,
    Link NVARCHAR(500) NULL,
    IconId int NULL,
    UserAssignType bit NOT NULL DEFAULT (0),
    TenantId int NOT NULL,
    CreatorUserId bigint NULL,
    CreationTime datetime NOT NULL,
    LastModifierUserId bigint NULL,
    LastModificationTime datetime NULL,
    DeleterUserId bigint NULL,
    DeletionTime datetime NULL,
    IsDeleted bit NOT NULL DEFAULT (0)
);
