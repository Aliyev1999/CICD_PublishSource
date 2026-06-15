CREATE TABLE DTM_ExternalReportSendingSchedule(
Id INT IDENTITY(1,1) PRIMARY KEY,
ExternalReportId int Not Null,
SendingSchedule nvarchar(MAX) Not Null,
CreatorUserId BIGINT NOT NULL,
CreationTime DATETIME NOT NULL,
LastModifierUserId BIGINT,
LastModificationTime DATETIME,
IsDeleted BIT Not Null,
DeleterUserId BIGINT,
DeletionTime DATETIME,
)
