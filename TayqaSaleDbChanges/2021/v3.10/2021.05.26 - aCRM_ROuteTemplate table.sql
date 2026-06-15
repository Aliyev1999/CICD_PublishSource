CREATE TABLE CRM_RouteTemplate
(
    Id                                       INT IDENTITY
        CONSTRAINT PK_CRM_RouteTemplate
            PRIMARY KEY,
    Name                                     NVARCHAR(50)               NOT NULL,
    Description                              NVARCHAR(150),
    Code                                     VARCHAR(30)                NOT NULL,
    StartDate                                DATE                       NOT NULL,
    EndDate                                  DATE                       NOT NULL,
    Firm                                     SMALLINT                   NOT NULL,
    LevelTreeId                              INT,
    Specode1                                 VARCHAR(40),
    Specode2                                 VARCHAR(40),
    Specode3                                 VARCHAR(40),
    ConsiderSalesmanClientMapping            BIT      DEFAULT 0         NOT NULL,
    CreateTemplateBasedClientSalesmanMapping BIT      DEFAULT 0         NOT NULL,
    CreatedDate                              DATETIME DEFAULT getdate() NOT NULL,
    CreatedUserId                            INT                        NOT NULL,
    ModifiedDate                             DATETIME,
    ModifiedUserId                           INT,
    Status                                   TINYINT  DEFAULT 1         NOT NULL,
    IsDeleted                                BIT      DEFAULT 0         NOT NULL
)
GO

CREATE INDEX IX_CRM_RouteTemplate_StartDate
    ON CRM_RouteTemplate (StartDate)
GO

CREATE INDEX IX_CRM_RouteTemplate_EndDate
    ON CRM_RouteTemplate (EndDate)
GO

CREATE UNIQUE INDEX UIX_CRM_RouteTemplate_Code
    ON CRM_RouteTemplate (Code)
GO

CREATE INDEX IX_CRM_RouteTemplate
    ON CRM_RouteTemplate (Firm)
GO

CREATE TABLE CRM_RouteTemplateClient
(
    Id            INT IDENTITY
        CONSTRAINT PK_CRM_RouteTemplateClient
            PRIMARY KEY,
    ClientId      INT                NOT NULL,
    ClientOrderNo SMALLINT DEFAULT 0 NOT NULL,
    TemplateId    INT                NOT NULL
        CONSTRAINT FK_CRM_RouteTemplateClient_TemplateId_CRM_RouteTemplate_Id
            REFERENCES CRM_RouteTemplate
            ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE INDEX IX_CRM_RouteTemplateClient_ClientId
    ON CRM_RouteTemplateClient (ClientId)
GO

CREATE TABLE CRM_RouteTemplateSalesman
(
    Id         INT IDENTITY
        CONSTRAINT PK_CRM_RouteTemplateSalesmanClientMapping
            PRIMARY KEY,
    SalesmanId INT      NOT NULL,
    Week       SMALLINT NOT NULL,
    Day        SMALLINT NOT NULL,
    TemplateId INT      NOT NULL
        CONSTRAINT FK_CRM_RouteTemplateSalesman_TemplateId_CRM_RouteTemplate_Id
            REFERENCES CRM_RouteTemplate
            ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE INDEX IX_CRM_RouteTemplateSalesman_SalesmanId
    ON CRM_RouteTemplateSalesman (SalesmanId)
GO

CREATE TABLE CRM_RouteTemplateLevelTree
(
    Id                   BIGINT IDENTITY
        CONSTRAINT PK_CRM_RouteTemplateLevelTree
            PRIMARY KEY,
    Code                 NVARCHAR(95)  NOT NULL,
    CreationTime         DATETIME2     NOT NULL,
    CreatorUserId        BIGINT,
    DeleterUserId        BIGINT,
    DeletionTime         DATETIME2,
    DisplayName          NVARCHAR(128) NOT NULL,
    IsDeleted            BIT           NOT NULL,
    LastModificationTime DATETIME2,
    LastModifierUserId   BIGINT,
    ParentId             BIGINT
        CONSTRAINT FK_CRM_RouteTemplateLevelTree_CRM_RouteTemplateLevelTree_ParentId
            REFERENCES CRM_RouteTemplateLevelTree
)
GO

CREATE INDEX IX_CRM_RouteTemplateLevelTree_ParentId
    ON CRM_RouteTemplateLevelTree (ParentId)
GO

CREATE INDEX IX_CRM_RouteTemplateLevelTree_Code
    ON CRM_RouteTemplateLevelTree (Code)
GO

CREATE TABLE CRM_RouteTemplateSalesmanClientMappingHistory
(
    Id             INT IDENTITY
        CONSTRAINT PK_CRM_RouteTemplateSalesmanClientMappingHistory
            PRIMARY KEY NONCLUSTERED,
    Firm           SMALLINT NOT NULL,
    SalesmanId     INT      NOT NULL,
    ClientId       INT      NOT NULL,
    RegisteredDate DATETIME NOT NULL,
    MappingType    TINYINT  NOT NULL
)
GO

CREATE INDEX IX_CRM_RouteTemplateSalesmanClientMappingHistory_Firm
    ON CRM_RouteTemplateSalesmanClientMappingHistory (Firm)
GO

CREATE INDEX IX_CRM_RouteTemplateSalesmanClientMappingHistory_ClientId
    ON CRM_RouteTemplateSalesmanClientMappingHistory (ClientId)
GO

CREATE INDEX IX_CRM_RouteTemplateSalesmanClientMappingHistory_SalesmanId
    ON CRM_RouteTemplateSalesmanClientMappingHistory (SalesmanId)
GO