CREATE TABLE CHL_AnswerQuestionRelation
(
    Id               int identity
        primary key,
    SurveyId         int not null,
    ParentQuestionId int,
    AnswerId         int not null,
    ChildQuestionId  int
)
    GO