

ALTER   FUNCTION [dbo].[F_CHL_GetUserSurveyApproveReport](@pointType TINYINT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT usr.Id,
                       usr.SurveyId,
                       usr.RegisteredDate DateTime,
                       usr.Firm,
                       u.Id							UserId,
                       u.UserName,
					   u.Name +' '+u.Surname		UserFullName,
                       c.TigerId					ClientTigerId,
                       c.Code						ClientCode,
                       c.Name						ClientName,
                       c.SpecialCode				ClientSpecialCode1,
                       c.SpecialCode2				ClientSpecialCode2,
                       c.SpecialCode3				ClientSpecialCode3,
					   c.SpecialCode4				ClientSpecialCode4,
                       c.SpecialCode5				ClientSpecialCode5,
					   c.SaleChannel				SaleChannel,
					   c.Edino						Edino,
                       s.Code						SurveyCode,
                       s.Name						SurveyName,
                       usr.Status					SurveyStatus,
                       s.Specode1					SurveySpecode1,
                       s.Specode2					SurveySpecode2,
                       s.Specode3					SurveySpecode3,
                       usp.Point					UserPoint,
                       smp.Point					SurveyMaxPoint,
                       sr.Name AS					SurveyContentType,
                       sr.Id   AS					SurveyContentId
                FROM CHL_UserSurveyResponse usr
                         JOIN AbpUsers u ON u.Id = usr.UserId
                         JOIN MD_Client c ON c.Firm = usr.Firm AND c.TigerId = usr.ClientId
                         JOIN CHL_Survey s ON s.Id = usr.SurveyId
                         LEFT JOIN MD_StopReason sr ON s.SurveyContentType = sr.Id
                         JOIN F_CHL_CalculateSurveyMaxPoints(@pointType) smp ON smp.SurveyId = usr.SurveyId
                         JOIN F_CHL_CalculateUserSurveyPoints(@pointType) usp ON usp.ReportId = usr.Id
            )
GO


