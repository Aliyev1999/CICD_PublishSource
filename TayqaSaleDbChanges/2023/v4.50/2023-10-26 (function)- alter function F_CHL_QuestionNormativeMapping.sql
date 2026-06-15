ALTER   FUNCTION [dbo].[F_CHL_QuestionNormativeMapping](@userId int)
    Returns Table
        AS
        RETURN
            (
                select Mapping.Id, Mapping.QuestionId, NormativeId
                from CHL_QuestionNormativeMapping Mapping with (nolock)
                         join CHL_Normative Normatives with (nolock)
                              on Normatives.Id = Mapping.NormativeId and Normatives.Status = 0
                         join CHL_SurveyQuestion SurveyQuestion with (nolocK)
                              on Mapping.QuestionId = SurveyQuestion.QuestionId
                         join CHL_SurveyUser SurveyUsers with (nolock) on SurveyUsers.SurveyId = SurveyQuestion.SurveyId
                         join CHL_Survey Surveys with (nolock)
                              on Surveys.Id = SurveyQuestion.SurveyId and Surveys.Firm = Normatives.Firm and
                                 Surveys.IsDeleted = 0 and Surveys.Status = 0
                where SurveyUsers.UserId = @userId
                  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
                  and (Surveys.StartDate <= cast(getdate() as date) and Surveys.EndDate >= cast(getdate() as date))
            )