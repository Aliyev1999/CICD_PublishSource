CREATE TABLE MD_UserGroupInfo(
	Id int IDENTITY(1,1) NOT NULL,
	Firm smallint NOT NULL,
	GroupType int NOT NULL,
	GroupName nvarchar(50) NOT NULL,
	GroupCode nvarchar(50) NOT NULL,
	CreatorUserId BIGINT NOT NULL,
    CreationTime DATETIME NOT NULL,
	DeleterUserId BIGINT,
    DeletionTime DATETIME,
	LastModifierUserId BIGINT,
    LastModificationTime DATETIME,
	IsDeleted bit NOT NULL,
	IsActive bit Not Null
)