go

create table DTM_DynamicScreenSubqueryGroups
(
	Id int identity(1,1) primary key,
	ScreenId int,
	[Index] tinyint,
	Name nvarchar(255)
)

go
