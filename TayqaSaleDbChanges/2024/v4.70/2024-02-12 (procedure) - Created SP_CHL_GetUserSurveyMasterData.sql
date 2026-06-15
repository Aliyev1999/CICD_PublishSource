create procedure [dbo].[SP_CHL_GetUserSurveyMasterData]  @userId int, @notConsiderPassiveSurveysDate datetime, @clientId int
			as
			begin 
			 select su.Id                SurveyUserId,
                       s.Id                 SurveyId,
                       s.Code               SurveyCode,
                       s.Name               SurveyName,
                       s.Description        SurveyDescription,
                       Cast(
                               Case s.Status When 0 Then su.Status Else s.Status End as tinyint
                           )          as    Status,
                       s.Type               SurveyType,
                       s.StartDate,
                       s.EndDate,
                       s.StartTime,
                       s.EndTime,
                       s.SalesmanCode,
                       s.MerchandiserCode,
                       s.Firm,
                       s.PeriodicalType,
                       s.CreatedDate,
                       s.ModifiedDate,
                       sath.Id              SurveyAttachmentId,
                       sath.Url             SurveyAttachmentUrl,
                       sath.SecureUrl       SurveySecureUrl,
                       t2.Id                SurveyTagId,
                       t2.Name              SurveyTag
                from CHL_SurveyUser su
                         join CHL_Survey s on su.SurveyId = s.Id
                    and su.UserId = @userId
                         join CHL_SurveyQuestion sq on sq.SurveyId = s.Id  
                         left join CHL_Attachment sath on sath.Type = 0
                    and sath.ReferenceId = s.Id
                         left join CHL_SurveyTag st on st.SurveyId = s.Id
                         left join CHL_Tag t2 on t2.Id = st.TagId
                where s.EndDate > GETDATE()
                  and s.Status = 0
				  and s.Id in (select distinct SurveyId from CHL_SurveyClient)
				  and ((@clientId = 0) or s.Id in (select SurveyId from CHL_SurveyClient where Type = 1 and ReferenceId = @clientId))
				  order by s.Id
			end