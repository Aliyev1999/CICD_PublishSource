ALTER FUNCTION [dbo].[F_CHL_GetUserSurveyApproveReportLog](@pointType tinyint, @uid uniqueidentifier)
    Returns Table
        AS
        RETURN
            (
                select usr.Id,
                       usr.Firm,
                       usr.SurveyId,
                       usr.RegisteredDate  DateTime,
                       u.Id                UserId,
                       u.UserName,
                       u.Name +' '+u.Surname		UserFullName,
                       c.Code              ClientCode,
                       c.Name              ClientName,
                       c.TigerId as        ClientTigerId,
                       c.SpecialCode       ClientSpecialCode1,
                       c.SpecialCode2      ClientSpecialCode2,
                       c.SpecialCode3      ClientSpecialCode3,
                       c.SpecialCode4      ClientSpecialCode4,
                       c.SpecialCode5      ClientSpecialCode5,
                       c.SaleChannel       SaleChannel,
                       c.Edino             Edino,
                       s.Code              SurveyCode,
                       s.Name              SurveyName,
                       CAST(10 as tinyint) SurveyStatus,
                       s.Specode1          SurveySpecode1,
                       s.Specode2          SurveySpecode2,
                       s.Specode3          SurveySpecode3,
                       usp.Point           UserPoint,
                       smp.Point           SurveyMaxPoint,
                       sr.Name   as        SurveyContentType,
                       sr.Id     as        SurveyContentId
                from CHL_UserSurveyResponseLog usr
                         Join AbpUsers u on u.Id = usr.UserId
                         join MD_Client c on c.Firm = usr.Firm and c.TigerId = usr.ClientId
                         join CHL_Survey s on s.Id = usr.SurveyId
                         left join MD_StopReason sr on s.SurveyContentType = sr.Id
                         join F_CHL_CalculateSurveyMaxPoints(@pointType) smp on smp.SurveyId = usr.SurveyId
                         join F_CHL_CalculateUserSurveyPointsLog(@pointType, @uid) usp on usp.ReportId = usr.Id
            )