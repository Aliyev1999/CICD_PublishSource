ALTER TABLE CHL_Question
    ADD ReasonLabel nvarchar(255)
GO
ALTER TABLE CHL_Reasons
    ADD ReasonViewState tinyint
GO
ALTER TABLE CHL_QuestionAnswerSelectReason
    ADD ReasonViewState tinyint
GO
ALTER TABLE CHL_Answer
    ADD OrderNumber int
GO
ALTER TABLE CHL_Answer
    ADD ViewType tinyint default 1 not null
GO
ALTER TABLE CHL_Answer
    ADD CreationTime datetime default getdate() not null
