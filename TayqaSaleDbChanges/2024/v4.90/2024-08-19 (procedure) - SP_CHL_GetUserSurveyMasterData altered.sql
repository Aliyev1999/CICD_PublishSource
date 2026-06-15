ALTER procedure [dbo].[SP_CHL_GetUserSurveyMasterData] @userId int, @notConsiderPassiveSurveysDate datetime, @clientId int
as
begin

    select distinct su.Id                                                                  as SurveyUserId,
                    s.Id                                                                   as SurveyId,
                    s.Code                                                                 as SurveyCode,
                    s.Name                                                                 as SurveyName,
                    s.Description                                                          as SurveyDescription,
                    cast(case s.Status when 0 then su.Status else s.Status end as tinyint) as Status,
                    s.Type                                                                 as SurveyType,
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
                    sath.Id                                                                as SurveyAttachmentId,
                    sath.Url                                                               as SurveyAttachmentUrl,
                    sath.SecureUrl                                                         as SurveySecureUrl,
                    t2.Id                                                                  as SurveyTagId,
                    t2.Name                                                                as SurveyTag
    from CHL_SurveyUser su with (nolock)
             join CHL_Survey s with (nolock) on su.SurveyId = s.Id AND su.UserId = @userId
             join CHL_SurveyQuestion sq with (nolock) on sq.SurveyId = s.Id
             left join CHL_Attachment sath on sath.Type = 0 AND sath.ReferenceId = s.Id
             left join CHL_SurveyTag st with (nolock) on st.SurveyId = s.Id
             left join CHL_Tag t2 with (nolock) on t2.Id = st.TagId
             left join CHL_SurveyClient sc with (nolock) on sc.SurveyId = s.Id
    where s.EndDate > getdate()
      and s.Status = 0
      and s.Id in (select distinct SurveyId from CHL_SurveyClient with (nolock))
      and ((@clientId = 0) or s.Id in (select SurveyId from CHL_SurveyClient with (nolock) where Type = 1 and ReferenceId = @clientId))
      and (s.PeriodicalType <> 1 or
           s.Id not in (select SurveyId
                        from CHL_UserSurveyResponse usr with (nolock)
                                 join CHL_Survey s with (nolock) on usr.SurveyId = s.Id
                        where s.PeriodicalType = 1
                          and usr.UserId = su.UserId
                          and (usr.ClientId = sc.ReferenceId or @clientId is null or usr.ClientId = @clientId)))
    order by s.Id;

end