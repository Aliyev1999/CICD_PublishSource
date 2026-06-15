CREATE TABLE DTM_DatabaseObject (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Type TINYINT NOT NULL,
    Name NVARCHAR(255) NOT NULL ,
    SqlQuery NVARCHAR(500),
    TableHasId BIT,
    CreationTime DATETIME NOT NULL ,
    CreatorUserId BIGINT NOT NULL ,
    LastModificationTime DATETIME,
    LastModifierUserId BIGINT,
    IsDeleted BIT NOT NULL
);

