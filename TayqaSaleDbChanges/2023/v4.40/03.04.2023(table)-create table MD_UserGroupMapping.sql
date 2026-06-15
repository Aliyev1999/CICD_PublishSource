CREATE TABLE MD_UserGroupMapping(
	Id int IDENTITY(1,1) NOT NULL,
	Firm smallint NOT NULL,
	UserId bigint NOT NULL,
	GroupType int NOT NULL,
	GroupId int Not Null ,
	CreationTime DATETIME NOT NULL,
	LastModifierUserId BIGINT,
    LastModificationTime DATETIME,
	IsActive bit Not Null
)

