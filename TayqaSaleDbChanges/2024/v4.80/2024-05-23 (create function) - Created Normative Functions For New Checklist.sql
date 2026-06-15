Create FUNCTION [dbo].[F_CHL_NormativeForClientNew](@userId int, @clientId INT = NULL) 
Returns Table
AS
RETURN(
select distinct NormativesForClient.Id,
                NormativesForClient.NormativeId,
                NormativesForClient.ClientId,
                NormativesForClient.Text as Text
from CHL_NormativeForClient NormativesForClient
         join CHL_Normative Normatives on Normatives.Id = NormativesForClient.NormativeId
         join CHL_QuestionNormativeMapping Mapping on Mapping.NormativeId = NormativesForClient.NormativeId
         join CHL_SurveyQuestion SurveyQuestions on SurveyQuestions.QuestionId = Mapping.QuestionId
         join CHL_SurveyUser Users on Users.SurveyId = SurveyQuestions.SurveyId and Users.UserId = @userId
         join CHL_SurveyClient Clients on Clients.SurveyId = Users.SurveyId
         left join F_GetPermittedClientForUser(@userId) FN
                   on FN.Firm = Normatives.Firm and FN.ClientId = Clients.ReferenceId and Clients.Type = 1
         left join (select ClientGroup.ClientId, ClientGroup.GroupId, ClientGroup.Firm
                    from MD_ClientGroupData ClientGroup
                             join F_GetPermittedClientForUser(@userId) FNN
                                  on ClientGroup.GroupId = FNN.ClientId and GroupType = 5 and FNN.UserId = @userId) t
                   on t.ClientId = NormativesForClient.ClientId and t.Firm = Normatives.Firm and
                      t.GroupId = Clients.ReferenceId and Clients.Type = 2 

where NormativesForClient.Status = 0
  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
  and (NormativesForClient.ClientId = @clientId or @clientId = 0)
)

GO


CREATE FUNCTION [dbo].[F_CHL_NormativeForClientGroupNew](@userId int=0, @clientId int=0) 
Returns Table
AS
RETURN(
select distinct n.Id, n.NormativeId, ClientGroupData.GroupId, Text as Text from CHL_NormativeForClientGroup n
                                        inner join CHL_QuestionNormativeMapping qnm on qnm.NormativeId = n.NormativeId
										inner join CHL_SurveyQuestion SurveyQuestion on SurveyQuestion.QuestionId = qnm.QuestionId
										inner join CHL_SurveyUser SurveyUser on SurveyUser.SurveyId = SurveyQuestion.SurveyId
										inner join MD_ClientGroupData ClientGroupData on ClientGroupData.GroupId = n.GroupId
										inner join F_GetPermittedClientForUser(@userId) FN on fn.ClientId = ClientGroupData.ClientId and FN.UserId = SurveyUser.UserId
                                        where n.Status = 0 and SurveyUser.UserId = @userId and (FN.ClientId = @clientId or @clientId = 0)
)
GO


ALTER FUNCTION [dbo].[F_CHL_NormativeForClientGroup](@userId int) 
Returns Table
AS
RETURN(
select distinct n.Id, n.NormativeId, ClientGroupData.GroupId, Text as Text from CHL_NormativeForClientGroup n
                                        inner join CHL_QuestionNormativeMapping qnm on qnm.NormativeId = n.NormativeId
										inner join CHL_SurveyQuestion SurveyQuestion on SurveyQuestion.QuestionId = qnm.QuestionId
										inner join CHL_SurveyUser SurveyUser on SurveyUser.SurveyId = SurveyQuestion.SurveyId
										inner join MD_ClientGroupData ClientGroupData on ClientGroupData.GroupId = n.GroupId
										inner join F_GetPermittedClientForUser(@userId) FN on fn.ClientId = ClientGroupData.ClientId and FN.UserId = SurveyUser.UserId
                                        where n.Status = 0 and SurveyUser.UserId = @userId
)

GO

ALTER FUNCTION [dbo].[F_CHL_NormativeForClient](@userId int) 
Returns Table
AS
RETURN(
select distinct NormativesForClient.Id,
                NormativesForClient.NormativeId,
                NormativesForClient.ClientId,
                NormativesForClient.Text as Text
from CHL_NormativeForClient NormativesForClient
         join CHL_Normative Normatives on Normatives.Id = NormativesForClient.NormativeId
         join CHL_QuestionNormativeMapping Mapping on Mapping.NormativeId = NormativesForClient.NormativeId
         join CHL_SurveyQuestion SurveyQuestions on SurveyQuestions.QuestionId = Mapping.QuestionId
         join CHL_SurveyUser Users on Users.SurveyId = SurveyQuestions.SurveyId and Users.UserId = @userId
         join CHL_SurveyClient Clients on Clients.SurveyId = Users.SurveyId
         left join F_GetPermittedClientForUser(@userId) FN
                   on FN.Firm = Normatives.Firm and FN.ClientId = Clients.ReferenceId and Clients.Type = 1
         left join (select ClientGroup.ClientId, ClientGroup.GroupId, ClientGroup.Firm
                    from MD_ClientGroupData ClientGroup
                             join F_GetPermittedClientForUser(@userId) FNN
                                  on ClientGroup.GroupId = FNN.ClientId and GroupType = 5 and FNN.UserId = @userId) t
                   on t.ClientId = NormativesForClient.ClientId and t.Firm = Normatives.Firm and
                      t.GroupId = Clients.ReferenceId and Clients.Type = 2 

where NormativesForClient.Status = 0
  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))

)

GO

