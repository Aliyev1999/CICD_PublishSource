
create table WPM_TaskUserGroups
(
	Id int primary key identity(1,1),
	TaskId int not null,
	UserGroupId int not null
)