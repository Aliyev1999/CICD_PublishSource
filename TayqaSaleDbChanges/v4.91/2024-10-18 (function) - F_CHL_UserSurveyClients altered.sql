drop function F_CHL_UserSurveyClients
GO
create FUNCTION [dbo].[F_CHL_UserSurveyClients](
    @userId int, @notConsiderPassiveSurveysDate datetime
)

    returns @Result table
                    (
                        Id          int,
                        SurveyId    int,
                        ReferenceId int,
                        Type        tinyint
                    )
as
begin

    declare @UserSurveys table
                         (
                             Firm       smallint,
                             PeriodType tinyint,
                             SurveyId   int
                         )

    insert into @UserSurveys (Firm, PeriodType, SurveyId)
    select Survey.Firm, PeriodicalType, Survey.Id
    from CHL_SurveyUser Users with (nolock)
             join CHL_Survey Survey with (nolock) on Survey.Id = Users.SurveyId
    where Survey.EndDate > DATEADD(DAY, -30, GETDATE())
      and Users.UserId = @userId
      and NOT (Survey.Status = 1 and Survey.ModifiedDate < @notConsiderPassiveSurveysDate)

    union

    select Survey.Firm, PeriodicalType, Survey.Id
    from CHL_SurveyUserGroups Groups with (nolock)
             join CHL_Survey Survey with (nolock) on Survey.Id = Groups.SurveyId
             join MD_UserGroupMapping Mapping with (nolock) on Mapping.GroupId = Groups.UserGroupId and Mapping.Firm = Survey.Firm
    where Survey.EndDate > DATEADD(DAY, -30, GETDATE())
      and Mapping.UserId = @userId
      and Mapping.IsActive = 1
      and NOT (Survey.Status = 1 and Survey.ModifiedDate < @notConsiderPassiveSurveysDate)


    ------------------------------------------------------------------------------------------------------------------------------------------------

    insert into @Result (Id, SurveyId, ReferenceId, Type)

-- Client-based surveys for user
    select Client.Id          as Id,
           Client.SurveyId    as SurveyId,
           Client.ReferenceId as ReferenceId,
           Client.Type        as Type
    from CHL_SurveyClient Client with (nolock)
             join @UserSurveys Survey on Survey.SurveyId = Client.SurveyId and Client.Type = 1
             join F_GetPermittedClientForUser(@userId) Permitted on Permitted.Firm = Survey.Firm and Permitted.ClientId = Client.ReferenceId
             left join CHL_UserSurveyResponse Response with (nolock) on Response.SurveyId = Client.SurveyId and Response.ClientId = Client.ReferenceId and Survey.PeriodType = 1
    where Response.Id is null

    union

-- ClientGroup-based surveys for user
    select distinct Client.Id          as Id,
                    Client.SurveyId    as SurveyId,
                    Client.ReferenceId as ReferenceId,
                    Client.Type        as Type

    from CHL_SurveyClient Client with (nolock)
             join @UserSurveys Survey on Survey.SurveyId = Client.SurveyId and Client.Type = 2
    return
end
go

