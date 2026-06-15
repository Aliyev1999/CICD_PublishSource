create table CHL_UserResponseQuestionPoint
(
    ReportId       int,
    SurveyId       int,
    QuestionId     int,
    PointType      tinyint,
    Point          float,
    RegisteredDate datetime default getdate()
)
go