create table CHL_UserSurveyResponseDetailReason
(
    Id                         int identity primary key,
    UserSurveyResponseDetailId int     not null,
    AnswerId                   int     not null,
    Type                       tinyint not null,
    ReasonId                   int,
    Value                      nvarchar(100),
)
GO