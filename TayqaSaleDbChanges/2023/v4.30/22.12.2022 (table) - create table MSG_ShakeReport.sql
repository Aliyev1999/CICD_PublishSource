CREATE TABLE MSG_ShakeReport (
Id int IDENTITY(1,1) PRIMARY KEY,
    Description nvarchar(1000) not null,
    ScreenName nvarchar(100) not null,
    AppVersion nvarchar(100) not null,
    Firm smallint not null,
    Vendor nvarchar(100) null,
	Model nvarchar(100) null,
	AndroidVersion nvarchar(100) null,
	UserId int not null,
	CreatedDate datetime default getdate()
);