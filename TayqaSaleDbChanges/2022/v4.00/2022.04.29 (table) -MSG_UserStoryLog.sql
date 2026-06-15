CREATE TABLE MSG_UserStoryLog(
	UserId int not null,
	SeenByUserId int not null,
	ImageUrl nvarchar(250) not null,
	CreatedDate datetime not null default getdate()
	CONSTRAINT UQ_UserId_ImageUrl UNIQUE (UserId,ImageUrl)
)