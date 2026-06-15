

ALTER FUNCTION [dbo].[F_CHL_UserSurveyClients](
    @userId int, @notConsiderPassiveSurveysDate datetime
)
    Returns Table AS RETURN
            (
                select distinct C.*
from CHL_SurveyClient C with (nolock)
join CHL_Survey S with (nolock) on C.SurveyId=S.Id 
join CHL_SurveyQuestion sq with (nolock) on sq.SurveyId = s.Id
join CHL_SurveyUser U with (nolock) on S.Id=U.SurveyId 
join F_GetAllPermittedClient() PC on U.UserId=Pc.UserId and (C.Type=2 or C.ReferenceId=Pc.ClientId)
where s.EndDate > DATEADD(
                        DAY,
                        -30,
                        GETDATE()
                    )
                  and NOT (
                            s.Status = 1
                        and s.ModifiedDate < @notConsiderPassiveSurveysDate
                    )
            and U.UserId=@userId
			and (S.PeriodicalType <> 1 or 
           s.Id not in (select SurveyId from CHL_UserSurveyResponse usr with (nolock)
		   join CHL_Survey s with(nolock) on usr.SurveyId=s.Id
		   where s.PeriodicalType=1 and usr.UserId = U.UserId and usr.ClientId = C.ReferenceId
		   ))



            )
