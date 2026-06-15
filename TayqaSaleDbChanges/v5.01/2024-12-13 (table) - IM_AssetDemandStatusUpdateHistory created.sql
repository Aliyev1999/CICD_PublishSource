
create table IM_AssetDemandStatusUpdateHistory
(
	Id int identity(1,1) primary key,
	UserId int,
	AssetDemandId int,
	FromStatus tinyint,
	ToStatus tinyint,
	Date datetime
)

go
