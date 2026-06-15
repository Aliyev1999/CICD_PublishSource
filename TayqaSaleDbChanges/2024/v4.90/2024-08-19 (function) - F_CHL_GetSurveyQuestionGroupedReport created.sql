
drop function F_CHL_GetSurveyQuestionGroupedReport
go
CREATE or ALTER function [dbo].[F_CHL_GetSurveyQuestionGroupedReport](@reportId int, @surveyId int, @pointType tinyint)
    returns @Result table
                    (

                        QuestionId             int,
                        QuestionName           nvarchar(300),
                        QuestionCode           nvarchar(100),
                        ResponseRegisteredDate datetime,
                        QuestionDescription    nvarchar(500),
                        Specode1               nvarchar(100),
                        Specode2               nvarchar(100),
                        Specode3               nvarchar(100),
                        QuestionType           tinyint,
                        CreatedDate            datetime,
                        Answer                 nvarchar(500),
                        Reason                 nvarchar(500),
                        QuestionGroupIds       nvarchar(100),
                        IsAnswerRequired       bit,
                        Status                 tinyint,
                        OrderNumber            smallint,
                        Name                   nvarchar(250),
                        UserPoint              float,
                        MaxPoint               float
                    )
    as
    begin

        declare @Date datetime = (select CreatedDate
                                  from CHL_UserSurveyResponse with (nolock)
                                  where Id = @ReportId);

        declare @UserPoint table
                           (
                               QuestionId int,
                               Point      float
                           )

        declare @MaxPoint table
                          (
                              QuestionId int,
                              Point      float
                          )


        -- User point for the response
        insert into @UserPoint (QuestionId, Point)
        select QuestionId, sum(Point) as Point
        from F_CHL_CalculateUserQuestionPoints(@ReportId, @pointType)
        group by QuestionId;

        -- Question max points for the survey
        insert into @MaxPoint (QuestionId, Point)
        select QuestionId, Point
        from F_CHL_CalculateQuestionMaxPointsByDate(@SurveyId, @pointType, @Date);

        with Reasons as (select Detail.Id                                                                                                as DetailId,
                                Detail.QuestionId                                                                                        as QuestionId,
                                coalesce(Answer.Text, Detail.AnswerValue)                                                                as Answer,
                                coalesce(NewReason.Value, Reason.Name collate SQL_Latin1_General_CP1_CI_AS, NewReason.Value, 'NoReason') as Reason
                         from CHL_UserSurveyResponseDetail Detail with (nolock)
                                  left join CHL_Answer Answer with (nolock) on Answer.Id = Detail.AnswerId
                                  left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserSurveyResponseDetailId = Detail.Id
                                  left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                         where Detail.UserSurveyResponseId = @ReportId),
             ReasonBeforeAgg as (select DetailId, QuestionId, Answer, string_agg(Reason, ' / ') as Reason
                                 from Reasons
                                 group by DetailId, QuestionId, Answer),
             Answers as (select QuestionId,
                                string_agg(Answer, ' | ')                     as Answer,
                                nullif(string_agg(Reason, ' | '), 'NoReason') as Reason,
                                string_agg(DetailId, ',')                     as DetailsIds
                         from ReasonBeforeAgg
                         group by QuestionId)

        insert
        into @Result (QuestionId, QuestionName, QuestionCode, ResponseRegisteredDate, QuestionDescription, Specode1, Specode2, Specode3, QuestionType, CreatedDate,
                      Answer, Reason, QuestionGroupIds, IsAnswerRequired, Status, OrderNumber, Name, UserPoint, MaxPoint)

        select Question.Id                      as QuestionId,
               Question.Name                    as QuestionName,
               Question.Code                    as QuestionCode,
               Response.RegisteredDate          as ResponseRegisteredDate,
               Question.Description             as QuestionDescription,
               Question.Specode1                as Specode1,
               Question.Specode1                as Specode2,
               Question.Specode1                as Specode3,
               Question.Type                    as QuestionType,
               SurveyQuestion.CreatedDate       as CreatedDate,
               Answers.Answer                   as Answer,
               Answers.Reason                   as Reason,
               cast(DetailsIds as nvarchar(50)) as QuestionReportIds,
               SurveyQuestion.IsAnswerRequired  as IsAnswerRequired,
               SurveyQuestion.Status            as Status,
               SurveyQuestion.OrderNumber       as OrderNumber,
               QuestionGroup.Name               as Name,
               UserPoint.Point                  as UserPoint,
               SurveyPoint.Point                as MaxPoint

        from CHL_UserSurveyResponse Response with (nolock)
                 join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Response.SurveyId
                 join CHL_Question Question with (nolock) on Question.Id = SurveyQuestion.QuestionId
                 left join Answers on Answers.QuestionId = Question.Id
                 left join CHL_QuestionGroup QuestionGroup with (nolock) on QuestionGroup.Id = Question.QuestionGroupId
                 left join @MaxPoint SurveyPoint on SurveyPoint.QuestionId = Question.Id
                 left join @UserPoint UserPoint on UserPoint.QuestionId = Question.Id

        where Response.Id = @ReportId
          and (SurveyQuestion.CreatedDate <= @Date or Answers.Answer is not null)

        return
    end