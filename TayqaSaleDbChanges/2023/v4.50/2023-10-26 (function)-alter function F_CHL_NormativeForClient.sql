ALTER FUNCTION [dbo].[F_CHL_NormativeForClient](@userId int) 
Returns Table
AS
RETURN(
select distinct NormativesForClient.Id,
                NormativesForClient.NormativeId,
                NormativesForClient.ClientId,
                Concat(NormativesForClient.Text, ' (', NormativesForClient.Number, ')') as Text
from CHL_NormativeForClient NormativesForClient with (nolock)
         join CHL_Normative Normatives with (nolock) on Normatives.Id = NormativesForClient.NormativeId
         join CHL_QuestionNormativeMapping Mapping with (nolock) on Mapping.NormativeId = NormativesForClient.NormativeId
         join CHL_SurveyQuestion SurveyQuestions with (nolock) on SurveyQuestions.QuestionId = Mapping.QuestionId
         join CHL_SurveyUser Users with (nolock) on Users.SurveyId = SurveyQuestions.SurveyId and Users.UserId = @userId
         join CHL_SurveyClient Clients with (nolock) on Clients.SurveyId = Users.SurveyId
         left join F_GetPermittedClientForUser(@userId) FN
                   on FN.Firm = Normatives.Firm and FN.ClientId = Clients.ReferenceId and Clients.Type = 1
         left join (select ClientGroup.ClientId, ClientGroup.GroupId, ClientGroup.Firm
                    from MD_ClientGroupData ClientGroup with (nolock)
                             join F_GetPermittedClientForUser(@userId) FNN
                                  on ClientGroup.GroupId = FNN.ClientId and GroupType = 5 and FNN.UserId = @userId) t
                   on t.ClientId = NormativesForClient.ClientId and t.Firm = Normatives.Firm and
                      t.GroupId = Clients.ReferenceId and Clients.Type = 2 

where NormativesForClient.Status = 0
  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
)