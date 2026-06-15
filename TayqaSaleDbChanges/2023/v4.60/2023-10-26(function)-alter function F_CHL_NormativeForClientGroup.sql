ALTER FUNCTION [dbo].[F_CHL_NormativeForClientGroup](@userId int) 
Returns Table
AS
RETURN(
select distinct n.Id, n.NormativeId, ClientGroupData.GroupId, Concat(Text, ' (' , Number, ')') as Text from CHL_NormativeForClientGroup n with (nolock)
                                        inner join CHL_QuestionNormativeMapping qnm with (nolock) on qnm.NormativeId = n.NormativeId
										inner join CHL_SurveyQuestion SurveyQuestion  with (nolock) on SurveyQuestion.QuestionId = qnm.QuestionId
										inner join CHL_SurveyUser SurveyUser with (nolock) on SurveyUser.SurveyId = SurveyQuestion.SurveyId
										inner join MD_ClientGroupData ClientGroupData with (nolock) on ClientGroupData.GroupId = n.GroupId
										inner join F_GetPermittedClientForUser(@userId) FN on fn.ClientId = ClientGroupData.ClientId and FN.UserId = SurveyUser.UserId
                                        where n.Status = 0 and SurveyUser.UserId = @userId
)