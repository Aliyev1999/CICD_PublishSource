/****** Object:  UserDefinedFunction [dbo].[F_CHL_GetSurveyQuestionReportAnswers]    Script Date: 10/26/2021 1:43:34 PM ******/

ALTER   FUNCTION [dbo].[F_CHL_GetSurveyQuestionReportAnswers](@startDate datetime, @endDate datetime) 
RETURNS TABLE   
AS  
RETURN   
(  
 -- Add the SELECT statement with parameter references here  
 SELECT USRD1.UserSurveyResponseId,  
 USRD1.QuestionId,  
 STRING_AGG(ISNULL(USRD1.AnswerValue, A.[Text]),' | ') Answers,  
 STRING_AGG(ISNULL(USRD1.ReasonValue, SR.[Name]),' | ') Reasons
 FROM CHL_UserSurveyResponseDetail USRD1 with (nolock)  
 Join CHL_UserSurveyResponse USR with (nolock)  on USRD1.UserSurveyResponseId = USR.Id
 LEFT JOIN CHL_Answer A with (nolock) ON USRD1.AnswerId is not null and USRD1.AnswerId=A.Id  
 LEFT JOIN MD_StopReason SR with (nolock) ON USRD1.ReasonId is not null and USRD1.ReasonId=SR.Id  
 WHERE USR.SavedDate >= @startDate and USR.SavedDate <= @endDate
 GROUP BY USRD1.UserSurveyResponseId, USRD1.QuestionId  
)
GO

