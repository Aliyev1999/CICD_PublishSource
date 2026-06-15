Create Table UIM_UserDeviceEventLogging(
Id int IDENTITY(1,1) NOT NULL, 
UID uniqueidentifier,
UserId int,
UserName nvarchar(100),
LogTime datetime not null,
EventType tinyint not null,
Latitude float not null,
Longitude float not null
)