create table CHL_UserDynamicSurveyResponseDetailReason
(
    Id                                int identity primary key,
    UserDynamicSurveyResponseDetailId int     not null,
    QuestionCode                      nvarchar(200),
    AnswerId                          int,
    AnswerText                        nvarchar(200),
    Type                              tinyint not null,
    ReasonId                          int,
    Value                             nvarchar(100)
)
go

alter table CHL_UserDynamicSurveyResponseDetail
    add QuestionCode nvarchar(200)
GO