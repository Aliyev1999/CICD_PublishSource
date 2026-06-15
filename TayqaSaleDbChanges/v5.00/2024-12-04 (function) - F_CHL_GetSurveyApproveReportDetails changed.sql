alter FUNCTION [dbo].[F_CHL_GetSurveyApproveReportDetails](@reportId int, @surveyId int, @pointType tinyint, @currentUserId bigint
)
    Returns Table
        AS
        RETURN(SELECT F.*,
                      N.Text                   AS NormativeText,
                      N.Name                   AS NormativeName,
                      N.Code                   AS NormativeCode,
                      QG.Name                  as GroupName,
                      detail.QuestionReportIds as QuestionReportIds
               FROM F_CHL_GetSurveyQuestionGroupedReport(@reportId, @surveyId, @pointType) F
                        LEFT JOIN CHL_QuestionNormativeMapping QNM ON F.QuestionId = QNM.QuestionId
                        LEFT JOIN CHL_Normative N ON QNM.NormativeId = N.Id
                        left join CHL_Question Question with (nolock) on Question.Id = F.QuestionId
                        LEFT JOIN CHL_QuestionGroup QG ON QG.Id = Question.QuestionGroupId
                        LEFT JOIN (select QuestionId, string_agg(Id, ',') as QuestionReportIds
                                   from CHL_UserSurveyResponseDetail with (nolock)
                                   where UserSurveyResponseId = @reportId
                                   group by QuestionId) detail ON detail.QuestionId = F.QuestionId
                   AND (N.Id IS NULL OR CAST(F.ResponseRegisteredDate AS date) BETWEEN N.StartDate AND N.EndDate)
        ---AND F. ResponseRegisteredDate BETWEEN N. StartDate AND N. EndDate OR  F. ResponseRegisteredDate <= N. EndDate
        )
go