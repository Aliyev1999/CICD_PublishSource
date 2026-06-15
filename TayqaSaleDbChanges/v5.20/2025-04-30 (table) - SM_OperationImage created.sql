go

create table SM_OperationResult
(
	Id int identity(1,1) primary key,
	DocId nvarchar(20),
	ReasonId int,
	Note nvarchar(max),
	FileName nvarchar(255),
	FilePath nvarchar(255),
	RegisteredDate datetime,
	CreatorUserId int
)

go
