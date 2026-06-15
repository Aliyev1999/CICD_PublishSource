
create table CHL_SurveyUserGroups
(
	Id int primary key identity(1,1),
	SurveyId int not null,
	UserGroupId int not null
)