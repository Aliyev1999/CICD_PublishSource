alter FUNCTION [dbo].[F_CHL_GetSurveyResponseInfo](@fromDate DATE)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT s.Id                                                   SurveyId,
                       s.Firm,
                       s.Name                                                 SurveyName,
                       usr.UserId,
                       c.TigerId                                              ClientId,
                       usr.CreatedDate,
					   normative.Text as NormativeText,
                       usr.CreatedLatitude,
                       usr.CreatedLongitude,
                       usr.SavedDate,
                       usr.SavedLatitude,
                       usr.SavedLongitude,
                       usr.RegisteredDate,
                       usr.Id                                                 SurveyResponseId,
                       usr.UId,
                       usr.Status                                             UserSurveyResponseStatus,
                       usr.ControlNote,
                       u.Name + ' ' + u.Surname                            AS ControllerName,
                       usr.ControlDate                                     AS ControlledDate,
                       usrd.Id                                                SurveyResponseDetailId,
                       sq.QuestionId,
                       sq.IsAnswerRequired,
                       q.Type                                              AS QuestionType,
                       q.Name                                                 QuestionName,
                       q.Code                                                 QuestionCode,
                       q.Description                                          QuestionDescription,
                       q.PhotoUploadOption,
                       5                                                   AS PhotoUploadCount,
                       sq.OrderNumber                                         QuestionOrderNumber,
                       q.AnswerTypeId,
                       q.IsAnswerFree,
                       a.Id                                                AS AnswerId,
                       usrd.AnswerValue,
                       a.Text                                                 AnswerText,
                       Cast(IIF(usrd.QuestionId IS NOT NULL, 1, 0) AS BIT) AS IsAnswered,
                       Cast(IIF((q.AnswerTypeId IN (1, 3, 4) AND usrd.AnswerValue IS NOT NULL) OR a.Id = usrd.AnswerId,
                                1, 0) AS BIT)                              AS IsCorrectAnswer,
                       IIF(q.AnswerTypeId IN (1, 3, 4) or q.WeightingType = 1, q.ReasonSelectOption,
                           a.ReasonSelectOption)                           AS ReasonSelectOption,
                       usrd.ReasonId,
                       usrd.ReasonValue
                FROM CHL_UserSurveyResponse usr
                         JOIN CHL_Survey s ON s.Id = usr.SurveyId
                         JOIN MD_Client c ON c.TigerId = usr.ClientId AND c.Firm = usr.Firm
                         JOIN CHL_SurveyQuestion sq ON sq.SurveyId = s.Id AND sq.Status = 0
                         JOIN CHL_Question q ON sq.QuestionId = q.Id
                         LEFT JOIN CHL_Answer a ON a.QuestionId = q.Id
                         LEFT JOIN AbpUsers u ON u.Id = usr.ControlUserId
						 LEFT JOIN CHL_QuestionNormativeMapping queNorMappping on q.Id = queNorMappping.QuestionId
						 LEFT JOIN CHL_Normative normative ON normative.Id = queNorMappping.NormativeId
                         LEFT JOIN CHL_UserSurveyResponseDetail usrd
                                   ON usr.Id = usrd.UserSurveyResponseId AND usrd.QuestionId = q.Id AND
                                      (usrd.AnswerId IS NULL OR usrd.AnswerId = a.Id)
                WHERE usr.CreatedDate > @fromDate
            )