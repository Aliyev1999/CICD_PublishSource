alter procedure SP_CHL_UserSurveyClients @userId int,
                                         @notConsiderPassiveSurveysDate datetime
As
Begin


    declare @UserSurveys table
                         (
                             Firm     smallint,
                             SurveyId int
                         )

    insert into @UserSurveys (Firm, SurveyId)
    select Survey.Firm, Survey.Id
    from CHL_SurveyUser Users with (nolock)
             join CHL_Survey Survey with (nolock) on Survey.Id = Users.SurveyId
    where Survey.EndDate > DATEADD(DAY, -30, GETDATE())
      and Users.UserId = @userId
      and NOT (Survey.Status = 1 and Survey.ModifiedDate < @notConsiderPassiveSurveysDate)

    union

    select Survey.Firm, Survey.Id
    from CHL_SurveyUserGroups Groups with (nolock)
             join CHL_Survey Survey with (nolock) on Survey.Id = Groups.SurveyId
             join MD_UserGroupMapping Mapping with (nolock) on Mapping.GroupId = Groups.UserGroupId and Mapping.Firm = Survey.Firm
    where Survey.EndDate > DATEADD(DAY, -30, GETDATE())
      and Mapping.UserId = @userId
      and Mapping.IsActive = 1
      and NOT (Survey.Status = 1 and Survey.ModifiedDate < @notConsiderPassiveSurveysDate)


    ------------------------------------------------------------------------------------------------------------------------------------------------

    -- Client-based surveys for user
    select Client.Id          as Id,
           Client.SurveyId    as SurveyId,
           Client.ReferenceId as ReferenceId,
           Client.Type        as Type
    from CHL_SurveyClient Client with (nolock)
             join @UserSurveys Survey on Survey.SurveyId = Client.SurveyId and Client.Type = 1
             join F_GetPermittedClientForUser(@UserId) Permitted on Permitted.Firm = Survey.Firm and Permitted.ClientId = Client.ReferenceId

    union

    -- ClientGroup-based surveys for user
    select distinct Client.Id          as Id,
                    Client.SurveyId    as SurveyId,
                    Client.ReferenceId as ReferenceId,
                    Client.Type        as Type

    from CHL_SurveyClient Client with (nolock)
             join @UserSurveys Survey on Survey.SurveyId = Client.SurveyId and Client.Type = 2

End
go