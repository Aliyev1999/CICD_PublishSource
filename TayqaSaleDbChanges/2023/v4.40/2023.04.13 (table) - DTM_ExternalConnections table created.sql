CREATE TABLE DTM_ExternalConnections (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL ,
    Type TINYINT NOT NULL,
    RemoteAddress NVARCHAR(100) NOT NULL,
    Port INT,
    UserName NVARCHAR(100),
    Password NVARCHAR(100),
    IsActive BIT NOT NULL,
    CreationTime DATETIME NOT NULL ,
    CreatorUserId BIGINT NOT NULL ,
    LastModificationTime DATETIME,
    LastModifierUserId BIGINT,
    IsDeleted BIT NOT NULL
);