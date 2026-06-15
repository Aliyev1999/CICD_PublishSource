CREATE TABLE DTM_RemoteFileUploadDetails(
Id INT IDENTITY(1,1) PRIMARY KEY,
ExternalReportId int Not Null,
Name nvarchar(100) Not Null,
ExtractFileTypes tinyint Not Null,
Seperator char(1),
SqlQuery nvarChar(max) Not Null,
IsDeleted BIT Not Null,
DeleterUserId BIGINT,
DeletionTime DATETIME,
)
