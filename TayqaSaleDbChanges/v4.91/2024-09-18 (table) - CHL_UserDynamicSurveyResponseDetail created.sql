-- auto-generated definition
create table CHL_UserDynamicSurveyResponseDetail
(
    Id                   int identity primary key,
    AnswerValue          nvarchar(500) collate SQL_Latin1_General_CP1_CI_AS,
    QuestionName         nvarchar(500) collate SQL_Latin1_General_CP1_CI_AS,
    QuestionDescription  nvarchar(500) collate SQL_Latin1_General_CP1_CI_AS,
    Answer               nvarchar(500) collate SQL_Latin1_General_CP1_CI_AS,
    UserSurveyResponseId int not null,
    ReasonId             int,
    ReasonValue          nvarchar(500) collate SQL_Latin1_General_CP1_CI_AS
)
go

create index IX_CHL_UserDynamicSurveyResponseDetail_UserSurveyResponseId
    on CHL_UserDynamicSurveyResponseDetail (UserSurveyResponseId)
go