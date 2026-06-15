ALTER FUNCTION [dbo].[F_CHL_GetUserSurveyApproveReport](@pointType TINYINT, @currentUserId BIGINT)
    RETURNS TABLE AS RETURN(SELECT Response.Id                               as Id,
                                   Response.SurveyId                         as SurveyId,
                                   Response.RegisteredDate                   as DateTime,
                                   Response.Firm                             as Firm,
                                   Users.Id                                  as UserId,
                                   Users.UserName                            as UserName,
                                   Users.Name + ' ' + Users.Surname          as UserFullName,
                                   Users.Code                                as UserCode,
                                   Client.TigerId                            as ClientTigerId,
                                   Client.Code                               as ClientCode,
                                   Client.Name                               as ClientName,
                                   Client.SpecialCode                        as ClientSpecialCode1,
                                   Client.SpecialCode2                       as ClientSpecialCode2,
                                   Client.SpecialCode3                       as ClientSpecialCode3,
                                   Client.SpecialCode4                       as ClientSpecialCode4,
                                   Client.SpecialCode5                       as ClientSpecialCode5,
                                   Client.SaleChannel                        as SaleChannel,
                                   Client.Edino                              as Edino,
                                   Survey.Code                               as SurveyCode,
                                   Survey.Name                               as SurveyName,
                                   Response.Status                           as SurveyStatus,
                                   Survey.Specode1                           as SurveySpecode1,
                                   Survey.Specode2                           as SurveySpecode2,
                                   Survey.Specode3                           as SurveySpecode3,
                                   cAST(isnull(UserPoint.Point, 0) AS float) as UserPoint,
                                   isnull(dbo.F_CHL_CalculateMaxPointForSurveyByDate(
                                                  Response.SurveyId, Response.SavedDate,
                                                  @pointType
                                          ), 0)                              as SurveyMaxPoint,
                                   Types.Name                                AS SurveyContentType,
                                   Types.Id                                  AS SurveyContentId,
                                   Survey.Type                               AS Type
                            FROM CHL_UserSurveyResponse Response with (nolock)
                                     JOIN AbpUsers Users with (nolock) ON Users.Id = Response.UserId and users.IsDeleted = 0 --and IsActive = 1
                                     JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers ON PermittedUsers.UserId = Response.UserId
                                     JOIN MD_Client Client with (nolock) ON Client.Firm = Response.Firm
                                AND Client.TigerId = Response.ClientId and Client.IsDeleted = 0
                                     JOIN CHL_Survey Survey with (nolock) ON Survey.Id = Response.SurveyId and Survey.IsDeleted = 0 --and Survey.Status = 0
                                     LEFT JOIN MD_StopReason Types with (Nolock) ON Survey.SurveyContentType = Types.Id
                                --left JOIN F_CHL_CalculateUserSurveyPoints(@pointType) UserPoint ON UserPoint.ReportId = Response.Id
                                     left JOIN CHL_UserResponsePoint UserPoint ON UserPoint.ReportId = Response.Id and UserPoint.PointType = @pointType
        --where Response.RegisteredDate>='20240101'
        )

