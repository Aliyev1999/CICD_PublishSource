ALTER procedure [dbo].[SP_CHL_GetUserFeedbacks] @firm smallint, @userId bigint, @beginDate datetime, @endDate datetime
as
begin
    select Survey.Id                                         as SurveyId,
           Survey.Name                                       as SurveyName,
           cast(Client.CardType as tinyint)                  as ClientType,
           Response.ClientId                                 as ClientId,
           Response.Firm                                     as Firm,
           cast(Response.Status as tinyint)                  as Status,
           Response.ControlNote                              as StatusMessage,
           Response.CreatedDate                              as [Date],
           cast(iif(ControlUserId is not null, 1, 0) as bit) as IsChecked,
           Response.CreatedLongitude                         as CreatedLongitude,
           Response.CreatedLatitude                          as CreatedLatitude,
           Response.CreatedDate                              as CreatedDate,
           Response.SavedLongitude                           as SavedLongitude,
           Response.SavedLatitude                            as SavedLatitude,
           Response.SavedDate                                as SavedDate,
           cast(Response.UId as nvarchar(100))               as UId,
           Response.Id                                       as UserFeedbackId,
           cast(1 as tinyint)                                as ProcessedByType,-- hele istifade olunmur
           'Mock'                                            as ProcessedByName,-- hele istifade olunmur
           getdate()                                         as ProcessedDate,-- hele istifade olunmur
           Response.RegisteredDate                           as SendDate,
           Client.Name                                       as ClientName,
           isnull(TicketAction.TicketActionId, 0)            as WorkPlanTicketActionId,
           Detail.QuestionId                                 as QuestionId,
           Detail.AnswerId                                   as AnswerId,
           Detail.AnswerValue                                as AnswerValue,
           Reason.ReasonId                                   as ReasonId,
           Reason.Value                                      as ReasonValue,
           Reason.Type                                       as ReasonType,
           (select IsAnswerFree
            from CHL_Question Question
            where Question.Id = Detail.QuestionId)           as AnswerFree
    from CHL_UserSurveyResponse Response with (nolock)
             join CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
             join MD_Client Client with (nolock) on Response.ClientId = Client.TigerId
             join AbpUsers Users with (nolock) on Response.UserId = Users.Id
             left join (select json_value(ActionParams, '$.surveyId') as SurveyId, TicketAction.Id as TicketActionId
                        from WPM_TaskTicketAction TicketAction with (nolock)
                        where json_value(ActionParams, '$.surveyId') is not null
                          and json_value(ActionParams, '$.surveyId') <> 0) TicketAction
                       on Response.SurveyId = TicketAction.TicketActionId
             inner join CHL_UserSurveyResponseDetail Detail on Response.Id = Detail.UserSurveyResponseId
             left join CHL_UserSurveyResponseDetailReason Reason on Detail.Id = Reason.UserSurveyResponseDetailId
    where Response.Firm = @firm
      and cast(Response.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
      and Response.UserId = @userId
end
go

