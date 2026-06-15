ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionReport](@reportId int, @surveyId int, @pointType tinyint)
Returns Table
AS
RETURN(
select
q.Id QuestionId, 
a.Id AnswerId,
q.Name QuestionName,
q.Description QuestionDescription,
sq.IsAnswerRequired,
sq.Status,
sq.CreatedDate,
coalesce(a.[Text], usrd.AnswerValue) Answer, 
coalesce(sr.[Name], usrd.ReasonValue) Reason, 
uqp.Point UserPoint,
qmp.Point MaxPoint, 
usrd.Id QuestionReportId,
sq.OrderNumber, 
gr.[Name] as GroupName, 
q.WeightingType,
q.Specode1,
q.Specode2,
q.Specode3,
q.Type as QuestionType
from CHL_SurveyQuestion sq
JOIN CHL_Question q on sq.QuestionId = q.Id
left join F_CHL_CalculateQuestionMaxPoints(@surveyId, @pointType) qmp on qmp.QuestionId = sq.QuestionId
left join F_CHL_CalculateUserQuestionPoints(@reportId, @pointType) uqp on uqp.QuestionId = sq.QuestionId
left join CHL_UserSurveyResponse usr on usr.Id=uqp.ReportId
left join CHL_UserSurveyResponseDetail usrd on usrd.UserSurveyResponseId = usr.Id and usrd.QuestionId = uqp.QuestionId and usrd.Id = uqp.QuestionReportId
left join CHL_Answer a on a.QuestionId = q.Id and a.Id = usrd.AnswerId
left join CHL_QuestionGroup gr on q.QuestionGroupId = gr.Id
left join MD_StopReason sr on sr.Type = 3 /*and sr.IsDeleted=0 and sr.IsActive=1*/ and sr.Id = usrd.ReasonId
where sq.SurveyId = @surveyId
)

GO

ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionGroupedReport](@reportId int, @surveyId int, @pointType tinyint) 
Returns Table
AS
RETURN(
select
QuestionId, 
QuestionName,
QuestionDescription, 
Specode1,
Specode2,
Specode3,
QuestionType,
CreatedDate,
SUBSTRING(p3.Answers,0, LEN(p3.Answers)) as Answer,
	Case SUBSTRING(p3.Reasons,0, LEN(p3.Reasons))
		WHEN 'NoReason' Then ''
		ELSE SUBSTRING(p3.Reasons,0, LEN(p3.Reasons))
	END as Reason,
SUBSTRING(p3.QuestionReportIds,0, LEN(p3.QuestionReportIds)) as QuestionReportIds, IsAnswerRequired, Status, OrderNumber, GroupName,
	Case p3.WeightingType
		When 2 Then sum(UserPoint)
		Else Max(UserPoint)
	End as UserPoint, 
max(MaxPoint) MaxPoint from 
(select *, (SELECT Answer + ' | '
           FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY Answer, Reason
           FOR XML PATH('') ) AS Answers,
(SELECT ISNULL(Reason, 'NoReason') + ' | '
           FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY Answer, Reason
           FOR XML PATH('') ) AS Reasons,
(SELECT Cast(QuestionReportId as varchar(20)) + ','
           FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY Answer, Reason
           FOR XML PATH('') ) AS QuestionReportIds
from F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p1) p3
group by 
QuestionId,
QuestionName,
QuestionDescription, 
IsAnswerRequired,
Status, 
OrderNumber,
GroupName, 
WeightingType,
Answers,
Reasons, 
QuestionReportIds,
Specode1,
Specode2,
Specode3,
QuestionType,
CreatedDate)

GO

ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionReportLog](@reportId int, @surveyId int, @pointType tinyint) 
Returns Table
AS
RETURN(
select
q.Id QuestionId,
a.Id AnswerId,
q.Name QuestionName, 
q.Description QuestionDescription,
sq.IsAnswerRequired,
sq.Status,
sq.CreatedDate,
coalesce(a.[Text], uqp.AnswerValue) Answer, 
coalesce(sr.[Name], uqp.ReasonValue) Reason,
uqp.Point UserPoint,
qmp.Point MaxPoint,
uqp.Id QuestionReportId,
sq.OrderNumber,
gr.[Name] as GroupName,
uqp.WeightingType,
q.Specode1,
q.Specode2,
q.Specode3,
q.Type as QuestionType
from CHL_SurveyQuestion sq 
JOIN CHL_Question q on sq.QuestionId = q.Id
join F_CHL_CalculateQuestionMaxPoints(@surveyId, @pointType) qmp on qmp.QuestionId = sq.QuestionId
left join F_CHL_CalculateUserQuestionPointsLog(@reportId, @pointType) uqp on uqp.QuestionId = sq.QuestionId
left join CHL_Answer a on a.QuestionId = q.Id and a.Id = uqp.AnswerId
left join CHL_QuestionGroup gr on q.QuestionGroupId = gr.Id
left join MD_StopReason sr on sr.Type = 3 /*and sr.IsDeleted=0 and sr.IsActive=1*/ and sr.Id = uqp.ReasonId
where sq.SurveyId = @surveyId
)

GO

ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionGroupedReportLog](@reportId int, @surveyId int, @pointType tinyint) 
Returns Table
AS
RETURN(
select
QuestionId,
QuestionName,
QuestionDescription, 
Specode1,
Specode2,
Specode3,
QuestionType,
CreatedDate,
SUBSTRING(p3.Answers,0, LEN(p3.Answers)) as Answer, SUBSTRING(p3.Reasons,0, LEN(p3.Reasons)) as Reason,
SUBSTRING(p3.QuestionReportIds,0, LEN(p3.QuestionReportIds)) as QuestionReportIds, IsAnswerRequired, Status, OrderNumber, GroupName,
Case p3.WeightingType
When 2 Then sum(UserPoint)
Else Max(UserPoint)
End as UserPoint, max(MaxPoint) MaxPoint from 
(select *, (SELECT Answer + ' | '
           FROM F_CHL_GetSurveyQuestionReportLog(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY Answer
           FOR XML PATH('') ) AS Answers,
(SELECT ISNULL(Reason, 'NoReason') + ' | '
           FROM F_CHL_GetSurveyQuestionReportLog(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY Reason
           FOR XML PATH('') ) AS Reasons,
(SELECT Cast(QuestionReportId as varchar(20)) + ','
           FROM F_CHL_GetSurveyQuestionReportLog(@reportId, @surveyId, @pointType) p2
           WHERE p2.QuestionId = p1.QuestionId
           ORDER BY QuestionReportId
           FOR XML PATH('') ) AS QuestionReportIds
from F_CHL_GetSurveyQuestionReportLog(@reportId, @surveyId, @pointType) p1) p3
group by
QuestionId,
QuestionName,
QuestionDescription, 
IsAnswerRequired, 
Status, 
OrderNumber,
GroupName,
WeightingType, 
Answers, 
Reasons,
QuestionReportIds,
Specode1,
Specode2,
Specode3,
QuestionType,
CreatedDate)

GO