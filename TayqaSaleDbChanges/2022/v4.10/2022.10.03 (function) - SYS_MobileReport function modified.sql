
CREATE FUNCTION [dbo].[F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback](@beginDate datetime, @endDate datetime, @answersInSeperatedLines bit)  
RETURNS TABLE   
AS  
RETURN   
(
 WITH SeperatedAnswersQuery AS
 (
	SELECT USRD1.UserSurveyResponseId,  
	 USRD1.QuestionId,
	 ISNULL(USRD1.AnswerValue, A.[Text]) Answers,
	 ISNULL(USRD1.ReasonValue, SR.[Name]) Reasons
	 FROM CHL_UserSurveyResponseDetail USRD1 with (nolock)  
	 Join CHL_UserSurveyResponse USR with (nolock)  on USRD1.UserSurveyResponseId = USR.Id
	 LEFT JOIN CHL_Answer A with (nolock) ON USRD1.AnswerId is not null and USRD1.AnswerId=A.Id  
	 LEFT JOIN MD_StopReason SR with (nolock) ON USRD1.ReasonId is not null and USRD1.ReasonId=SR.Id  
	 where USR.SavedDate >= @beginDate and USR.SavedDate <= @endDate and @answersInSeperatedLines = 1
 ),

 NonSeperatedAnswersQuery AS
 (
	SELECT USRD1.UserSurveyResponseId,  
	 USRD1.QuestionId,  
	 STRING_AGG(ISNULL(USRD1.AnswerValue, A.[Text]),' | ') Answers,  
	 STRING_AGG(ISNULL(USRD1.ReasonValue, SR.[Name]),' | ') Reasons
	 FROM CHL_UserSurveyResponseDetail USRD1 with (nolock)  
	 Join CHL_UserSurveyResponse USR with (nolock)  on USRD1.UserSurveyResponseId = USR.Id
	 LEFT JOIN CHL_Answer A with (nolock) ON USRD1.AnswerId is not null and USRD1.AnswerId=A.Id  
	 LEFT JOIN MD_StopReason SR with (nolock) ON USRD1.ReasonId is not null and USRD1.ReasonId=SR.Id  
	 where USR.SavedDate >= @beginDate and USR.SavedDate <= @endDate and @answersInSeperatedLines = 0
	 GROUP BY USRD1.UserSurveyResponseId, USRD1.QuestionId
 )

 SELECT * FROM SeperatedAnswersQuery
 UNION
 SELECT * FROM NonSeperatedAnswersQuery
)
go
