create PROCEDURE [dbo].[SP_CHL_GetQuestionAnswerReasonDetails](
    @startDate DATETIME,
    @endDate DATETIME,
    @clientNameCodeOrGroupCode NVARCHAR(500),
    @surveyNameOrCode NVARCHAR(500),
    @surveySpecialCodes NVARCHAR(50),
    @reasonIds NVARCHAR(MAX),
    @reasonTypes NVARCHAR(MAX) = NULL)
AS
BEGIN
    with Data as (SELECT distinct usr.UserName                             as UserName,
                                  Response.CreatedDate                     as Date,
                                  Client.Name                              as ClientName,
                                  Client.Code                              as ClientCode,
                                  Client.TradingGroupCode                  as ClientGroupCode,
                                  Question.Name                            as QuestionName,
                                  Survey.Name                              as SurveyName,
                                  coalesce(ResponseDetail.ReasonValue collate SQL_Latin1_General_CP1_CI_AS,
                                           'NoReason')                     as ReasonName,
                                  IIF(reason.Id IS NOT NULL, reason.Id, 0) as ReasonId,
                                  responseDetail.Id                        as ResponseDetailId
                  FROM CHL_UserSurveyResponse response with (nolock)
                           JOIN CHL_UserSurveyResponseDetail responseDetail with (nolock)
                                ON response.Id = responseDetail.UserSurveyResponseId
                           JOIN AbpUsers usr with (nolock) ON response.UserId = usr.Id
                           JOIN MD_Client Client with (nolock)
                                ON response.ClientId = client.TigerId and response.Firm = client.Firm
                           LEFT JOIN MD_StopReason reason with (nolock)
                                     ON responseDetail.ReasonId = reason.Id and reason.Type = 3
                      --join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Response.SurveyId
                           join CHL_Question Question with (nolock) on Question.Id = responseDetail.QuestionId
                           JOIN CHL_Survey Survey with (nolock)
                                ON response.Firm = survey.Firm and response.SurveyId = survey.Id
                           JOIN MD_Firm firm with (nolock) ON client.Firm = firm.Nr
                  WHERE responseDetail.Id < 15502
                    and (survey.IsDeleted IS NULL OR survey.IsDeleted = 0)
                    AND (reason.Type IS NULL OR reason.Type = 3)
                    AND (client.Status = 0)
                    AND (client.IsDeleted IS NULL OR client.IsDeleted = 0)
                    AND (responseDetail.ReasonValue IS NOT NULL OR responseDetail.ReasonId IS NOT NULL)
                    and cast(Response.CreatedDate as date) between Cast(@startDate as date) and Cast(@endDate as date)
                    and (@clientNameCodeOrGroupCode IS NULL OR
                         Client.Name LIKE '%' + @clientNameCodeOrGroupCode + '%' OR
                         Client.Code LIKE '%' + @clientNameCodeOrGroupCode + '%' OR
                         Client.TradingGroupCode LIKE '%' + @clientNameCodeOrGroupCode + '%')
                    AND (@surveyNameOrCode IS NULL OR Survey.Name LIKE '%' + @surveyNameOrCode + '%' OR
                         Survey.Code LIKE '%' + @surveyNameOrCode + '%')
                    AND (@surveySpecialCodes IS NULL OR Survey.Specode1 LIKE '%' + @surveySpecialCodes + '%' or
                         Survey.Specode2 LIKE '%' + @surveySpecialCodes + '%' or
                         Survey.Specode3 LIKE '%' + @surveySpecialCodes + '%')
					AND (@reasonTypes is null or (case when responseDetail.ReasonValue is not null then cast(3 as tinyint)
                  else cast(1 as tinyint)
            end ) IN (SELECT value FROM F_SplitList(@reasonTypes, ',')))

                  union 


                  SELECT distinct usr.UserName                                                  as UserName,
                                  Response.CreatedDate                                          as Date,
                                  Client.Name                                                   as ClientName,
                                  Client.Code                                                   as ClientCode,
                                  Client.TradingGroupCode                                       as ClientGroupCode,
                                  Question.Name                                                 as QuestionName,
                                  Survey.Name                                                   as SurveyName,
                                  coalesce(reason.Value, responseDetail.ReasonValue,
                                           ReasonNames.Name collate SQL_Latin1_General_CP1_CI_AS,
                                           'NoReason')                                          as ReasonName,
                                  IIF(reason.Id IS NOT NULL and reason.Type <> 3, reason.Id, 0) as ReasonId,
                                  responseDetail.Id                                             as ResponseDetailId
                  FROM CHL_UserSurveyResponse response with (nolock)
                           JOIN CHL_UserSurveyResponseDetail responseDetail with (nolock)
                                ON response.Id = responseDetail.UserSurveyResponseId
                           JOIN AbpUsers usr with (nolock) ON response.UserId = usr.Id
                           JOIN MD_Client client with (nolock)
                                ON response.ClientId = client.TigerId and response.Firm = client.Firm
                           JOIN CHL_UserSurveyResponseDetailReason reason with (nolock)
                                ON responseDetail.Id = reason.UserSurveyResponseDetailId --and
                                 --  reason.AnswerId = responseDetail.AnswerId
                      --join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Response.SurveyId
                           join CHL_Question Question with (nolock) on Question.Id = responseDetail.QuestionId
                           JOIN CHL_Survey survey with (nolock)
                                ON response.Firm = survey.Firm and response.SurveyId = survey.Id
                           JOIN MD_Firm firm with (nolock) ON client.Firm = firm.Nr
                           left join MD_StopReason ReasonNames with (nolock)
                                     on ReasonNames.Id = reason.ReasonId --and reason.Type in (1, 2)

                  WHERE responseDetail.Id >= 15502
                    and (survey.IsDeleted IS NULL OR survey.IsDeleted = 0)
                    AND (client.Status = 0)
                    AND (client.IsDeleted IS NULL OR client.IsDeleted = 0)
                    and cast(Response.CreatedDate as date) between Cast(@startDate as date) and Cast(@endDate as date)
                    and (@clientNameCodeOrGroupCode IS NULL OR
                         Client.Name LIKE '%' + @clientNameCodeOrGroupCode + '%' OR
                         Client.Code LIKE '%' + @clientNameCodeOrGroupCode + '%' OR
                         Client.TradingGroupCode LIKE '%' + @clientNameCodeOrGroupCode + '%')
                    AND (@surveyNameOrCode IS NULL OR Survey.Name LIKE '%' + @surveyNameOrCode + '%' OR
                         Survey.Code LIKE '%' + @surveyNameOrCode + '%')
                    AND (@surveySpecialCodes IS NULL OR Survey.Specode1 LIKE '%' + @surveySpecialCodes + '%' or
                         Survey.Specode2 LIKE '%' + @surveySpecialCodes + '%' or
                         Survey.Specode3 LIKE '%' + @surveySpecialCodes + '%')
						 
					AND (@reasonTypes is null or (case when reason.Type = 1 then cast(1 as tinyint)
        when reason.Type = 2 then cast(2 as tinyint)
        when reason.Type in (3, 4) then cast(3 as tinyint)
		else cast(1 as tinyint)
        end) IN (SELECT value FROM F_SplitList(@reasonTypes, ','))	) 
						 
						 
						 )

    select *
    from Data
    where (@reasonIds IS NULL OR Data.ReasonId IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

END