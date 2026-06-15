CREATE OR ALTER   function [dbo].[F_CHL_GetSurveyQuestionGroupedReport](@reportId int, @surveyId int, @pointType tinyint)
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

        with Reasons as ( select  distinct Detail.Id                                                                     as DetailId,
                                Detail.QuestionId                                                                           as QuestionId,
                                coalesce(Answer.Text, Detail.AnswerValue) collate SQL_Latin1_General_CP1_CI_AS              as Answer,
                                coalesce(NewReason.Value, Reason.Name collate SQL_Latin1_General_CP1_CI_AS, NewReason.Value)  as Reason
                         from CHL_UserSurveyResponseDetail Detail with (nolock)
                                  left join CHL_Answer Answer with (nolock) on Answer.Id = Detail.AnswerId
                                  left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserSurveyResponseDetailId = Detail.Id
                                  left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                         where Detail.UserSurveyResponseId = @ReportId
                            union all
      		   select distinct Detail.Id                                        as DetailId,
                                Detail.Id                              as QuestionId,
                                 Detail.AnswerValue                    as Answer,
                                coalesce(NewReason.Value, Reason.Name , NewReason.Value) collate SQL_Latin1_General_CP1_CI_AS as Reason
                         from CHL_UserDynamicSurveyResponseDetail Detail with (nolock)
                                  left join CHL_UserDynamicSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserDynamicSurveyResponseDetailId = Detail.Id
                                  left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                         where Detail.UserSurveyResponseId = @reportId
),
             ReasonBeforeAgg as (select DetailId, QuestionId, Answer, string_agg(Reason, ' / ') as Reason
                                 from Reasons
                                 group by DetailId, QuestionId, Answer),
             Answers as (select QuestionId,
                                string_agg(Answer, ' | ')                     as Answer,
                                isnull(string_agg(Reason, ' | '),'')          as Reason,
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
               isnull(Answers.Reason ,'')       as Reason,
               cast(DetailsIds as nvarchar(50)) as QuestionReportIds,
               SurveyQuestion.IsAnswerRequired  as IsAnswerRequired,
               SurveyQuestion.Status            as Status,
               SurveyQuestion.OrderNumber       as OrderNumber,
               QuestionGroup.Name               as Name,
               UserPoint.Point                  as UserPoint,
               SurveyPoint.Point                as MaxPoint

        from CHL_UserSurveyResponse Response with (nolock)
		join CHL_UserSurveyResponseDetail Detail with (nolock) on Detail.UserSurveyResponseId = Response.Id
                 left join Answers on Answers.QuestionId = Detail.QuestionId 

                 left join CHL_Question Question with (nolock) on Question.Id = Answers.QuestionId

                 left join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Response.SurveyId

                 left join CHL_QuestionGroup QuestionGroup with (nolock) on QuestionGroup.Id = Question.QuestionGroupId
                 left join @MaxPoint SurveyPoint on SurveyPoint.QuestionId = Question.Id
                 left join @UserPoint UserPoint on UserPoint.QuestionId = Question.Id

        where Response.Id = @ReportId
          and (SurveyQuestion.CreatedDate <= @Date or Answers.Answer is not null)
union all
         	 select Detail.Id                                                              as QuestionId,
               Detail.QuestionName collate SQL_Latin1_General_CP1_CI_AS                    as QuestionName,
               Detail.QuestionCode collate SQL_Latin1_General_CP1_CI_AS                    as QuestionCode,
               Response.RegisteredDate          as ResponseRegisteredDate,
               Detail.QuestionDescription collate SQL_Latin1_General_CP1_CI_AS             as QuestionDescription,
               ''                                                                  as Specode1,
               ''                                                                  as Specode2,
               ''                                                                  as Specode3,
               3                                                                   as QuestionType,
               Response.CreatedDate                                                as CreatedDate,
               isnull(Detail.AnswerValue,'...')                    as Answer,
               sr.Name                               as Reason,
               cast(Detail.Id  as nvarchar(50))      as QuestionReportIds,
               1                                     as IsAnswerRequired,
               0                                     as Status,
               1                                     as OrderNumber,
               ''                                    as Name,
               ''                             as UserPoint,
               ''                           as MaxPoint

        from CHL_UserSurveyResponse Response with (nolock)
		join CHL_UserDynamicSurveyResponseDetail Detail with (nolock) on Detail.UserSurveyResponseId = Response.Id
		INNER JOIN CHL_UserDynamicSurveyResponseDetailReason reason ON reason.UserDynamicSurveyResponseDetailId =Detail.Id
		 left JOIN MD_StopReason SR ON SR.Id= reason.ReasonId
    where Detail.UserSurveyResponseId = @ReportId

        return
    end