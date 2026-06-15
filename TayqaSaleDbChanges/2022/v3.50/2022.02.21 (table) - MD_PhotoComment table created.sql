create table MD_PhotoComment(
	Id int primary key identity,
	ReferenceId int,
	CreationTime datetime not null default(getdate()),
	CreatorUserId bigint,
	SourceType tinyint,
	ReasonId int,
	Comment nvarchar (MAX)
)