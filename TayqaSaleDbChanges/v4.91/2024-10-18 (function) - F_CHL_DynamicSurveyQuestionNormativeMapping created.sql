CREATE FUNCTION [dbo].[F_CHL_DynamicSurveyQuestionNormativeMapping](@userId int)
    Returns Table
        AS
        RETURN(
        -- this query must be customized for customer
        select Mapping.Id, Question.Code as QuestionCode, NormativeId
        from CHL_QuestionNormativeMapping Mapping with (nolock)
                 join CHL_Normative Normatives with (nolock) on Normatives.Id = Mapping.NormativeId and Normatives.Status = 0
                 join CHL_SurveyQuestion SurveyQuestion with (nolocK) on Mapping.QuestionId = SurveyQuestion.QuestionId
                 join CHL_Question Question with (nolock) on SurveyQuestion.QuestionId = Question.Id
                 join CHL_SurveyUser SurveyUsers with (nolock) on SurveyUsers.SurveyId = SurveyQuestion.SurveyId
                 join CHL_Survey Surveys with (nolock) on Surveys.Id = SurveyQuestion.SurveyId and Surveys.Firm = Normatives.Firm

        where SurveyUsers.UserId = @userId
          and Surveys.IsDeleted = 0
          and Surveys.Status = 0
          and Surveys.Type = 4
          and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
          and (Surveys.StartDate <= cast(getdate() as date) and Surveys.EndDate >= cast(getdate() as date)))
go
