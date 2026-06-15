
CREATE   FUNCTION [dbo].[F_CHL_CalculateSurveyMaxPointsAllByDate](@Date datetime)
    Returns Table
        AS
        RETURN
        select y.SurveyId, y.PointType, sum(y.simplePoint) Point
        from (select sq.SurveyId, qp.PointType, sum(qp.Point) simplePoint
              from CHL_SurveyQuestion sq with (nolock)
                       JOIN CHL_Question q with (nolock) on sq.QuestionId = q.Id
                       join CHL_SurveyQuestionPoint qp with (nolock) on qp.SurveyQuestionId = sq.Id
              where q.WeightingType = 1
                and qp.Point >= 0
                and sq.Status = 0
              group by sq.SurveyId, qp.PointType

              union all

              select t.SurveyId, t.PointType, sum(answerPoint) calculablePoint
              from (select sq.SurveyId, q.Id QuestionId, ap.PointType, max(ap.Point) answerPoint
                    from CHL_SurveyQuestion sq with (nolock)
                             JOIN CHL_Question q with (nolock) on sq.QuestionId = q.Id
                             join CHL_SurveyQuestionAnswerPoint ap with (nolock) on ap.SurveyQuestionId = sq.Id
                             join CHL_Answer an with (nolock) on an.Id = ap.AnswerId and an.QuestionId = sq.QuestionId
                    where q.WeightingType = 2
                      and ap.Point >= 0
                      and sq.Status = 0
                      and q.AnswerTypeId != 10
                      and an.CreationTime < @Date
                    group by sq.SurveyId, q.Id, ap.PointType

                    union all
                    select sq.SurveyId, q.Id QuestionId, ap.PointType, sum(ap.Point) answerPoint
                    from CHL_SurveyQuestion sq with (nolock)
                             JOIN CHL_Question q with (nolock) on sq.QuestionId = q.Id
                             join CHL_SurveyQuestionAnswerPoint ap with (nolock) on ap.SurveyQuestionId = sq.Id
                             join CHL_Answer an with (nolock) on an.Id = ap.AnswerId and an.QuestionId = sq.QuestionId
                    where q.WeightingType = 2
                      and ap.Point >= 0
                      and sq.Status = 0
                      and q.AnswerTypeId = 10
                      and an.CreationTime < @Date
                    group by sq.SurveyId, q.Id, ap.PointType) t
              group by t.SurveyId, t.PointType) y
        GROUP by y.SurveyId, y.PointType