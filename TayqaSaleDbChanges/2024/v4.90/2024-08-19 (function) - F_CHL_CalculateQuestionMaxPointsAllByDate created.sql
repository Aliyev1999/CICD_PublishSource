
CREATE FUNCTION [dbo].[F_CHL_CalculateQuestionMaxPointsAllByDate](@Date datetime)
    Returns Table
        AS
        RETURN
        with Points as (
            -- Questions with single point regardless answers
            select SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId, max(Point.Point) as Point
            from CHL_SurveyQuestion SurveyQuestion with (nolock)
                     JOIN CHL_Question Question with (nolock) on SurveyQuestion.QuestionId = Question.Id
                     join CHL_SurveyQuestionPoint Point with (nolock) on Point.SurveyQuestionId = SurveyQuestion.Id
            where Question.WeightingType = 1
              and Point.Point >= 0
              and SurveyQuestion.Status = 0
              and SurveyQuestion.CreatedDate <= @Date
            group by SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId

            union all

            -- Questions with single answer
            select SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId, max(Point.Point) as Point
            from CHL_SurveyQuestion SurveyQuestion with (nolock)
                     JOIN CHL_Question Question with (nolock) on SurveyQuestion.QuestionId = Question.Id
                     join CHL_SurveyQuestionAnswerPoint Point with (nolock) on Point.SurveyQuestionId = SurveyQuestion.Id
                     join CHL_Answer Answer with (nolock) on Answer.Id = Point.AnswerId and Answer.QuestionId = Question.Id
            where Question.WeightingType = 2
              and Point.Point >= 0
              and SurveyQuestion.Status = 0
              and Question.AnswerTypeId != 10
              and Answer.CreationTime <= @Date
            group by SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId

            union all

            -- Questions with multi-answers
            select SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId, sum(Point.Point) as Point
            from CHL_SurveyQuestion SurveyQuestion with (nolock)
                     JOIN CHL_Question Question with (nolock) on SurveyQuestion.QuestionId = Question.Id
                     join CHL_SurveyQuestionAnswerPoint Point with (nolock) on Point.SurveyQuestionId = SurveyQuestion.Id
                     join CHL_Answer Answer with (nolock) on Answer.Id = Point.AnswerId and Answer.QuestionId = Question.Id
            where Question.WeightingType = 2
              and Point.Point >= 0
              and SurveyQuestion.Status = 0
              and Question.AnswerTypeId = 10
              and Answer.CreationTime <= @Date
            group by SurveyQuestion.SurveyId, Point.PointType, SurveyQuestion.QuestionId)

        select Points.SurveyId, Points.QuestionId, Points.PointType, sum(Points.Point) as Point
        from Points
        GROUP by Points.SurveyId, Points.QuestionId, Points.PointType