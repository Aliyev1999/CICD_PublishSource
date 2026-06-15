
ALTER   FUNCTION [dbo].[F_CHL_GetSurveyQuestionReport](@reportId int, @surveyId int, @pointType tinyint)
Returns Table
AS
RETURN(
select
q.Id QuestionId, 
a.Id AnswerId,
q.Name QuestionName,
q.Code QuestionCode,
q.Description QuestionDescription,
sq.IsAnswerRequired,
sq.Status,
sq.CreatedDate,
coalesce(a.[Text], usrd.AnswerValue) Answer, 
coalesce(sr.[Name], usrd.ReasonValue) Reason, 
uqp.Point UserPoint,
qmp.Point MaxPoint,
-- usr.RegisteredDate ResponseRegisteredDate,
first_value(usr.RegisteredDate) over (order by usr.Id desc range between unbounded preceding and unbounded following) ResponseRegisteredDate,
usrd.Id QuestionReportId,
sq.OrderNumber, 
gr.[Name] as GroupName, 
q.WeightingType,
q.Specode1,
q.Specode2,
q.Specode3,
q.Type as QuestionType
from CHL_UserSurveyResponse usr with(nolock)
join CHL_UserSurveyResponseDetail usrd with(nolock) on usrd.UserSurveyResponseId=usr.Id
join CHL_SurveyQuestion sq with(nolock) on sq.QuestionId=usrd.QuestionId and sq.SurveyId=usr.SurveyId
join CHL_Question q with(nolock) on sq.QuestionId = q.Id
left join F_CHL_CalculateQuestionMaxPoints(@surveyId, @pointType) qmp on qmp.QuestionId = usrd.QuestionId
left join F_CHL_CalculateUserQuestionPoints(@reportId, @pointType) uqp on uqp.QuestionId = usrd.QuestionId
left join CHL_Answer a with(nolock) on a.QuestionId = q.Id and a.Id = usrd.AnswerId
left join CHL_QuestionGroup gr with(nolock) on q.QuestionGroupId = gr.Id
left join MD_StopReason sr with(nolock) on sr.Type = 3 and sr.IsDeleted=0 and sr.IsActive=1 and sr.Id = usrd.ReasonId
where usr.SurveyId = @surveyId and usr.Id=@reportId
)