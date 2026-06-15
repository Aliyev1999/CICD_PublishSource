ALTER FUNCTION [dbo].[F_CHL_UserSurveyClients](
    @userId int, @notConsiderPassiveSurveysDate datetime
)
    Returns Table AS RETURN
            (
               with Clients as (
select Firm, ClientId from F_GetPermittedClientForUser(@userId)),

PermittedSurveys as (select SurveyId from CHL_SurveyUser with (nolock) where UserId = @userId and Status = 0),

Surveys as (select Id from CHL_Survey with (nolock) where (Status = 0 or ModifiedDate > @notConsiderPassiveSurveysDate) and  EndDate > DATEADD(DAY, -30, GETDATE()))

select SurveyClient.* from Clients 
join CHL_SurveyClient SurveyClient with (nolock) on SurveyClient.ReferenceId = Clients.ClientId 
join Surveys on Surveys.Id = SurveyClient.SurveyId 
join PermittedSurveys on PermittedSurveys.SurveyId = Surveys.Id)