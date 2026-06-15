alter FUNCTION [dbo].[F_CHL_GetUserSurveyApproveReport](@pointType TINYINT, @currentUserId BIGINT)
    RETURNS TABLE AS RETURN(SELECT Response.Id,
                                   Response.SurveyId,
                                   Response.RegisteredDate          DateTime,
                                   Response.Firm,
                                   Users.Id                         UserId,
                                   Users.UserName,
                                   Users.Name + ' ' + Users.Surname UserFullName,
                                   Client.TigerId                   ClientTigerId,
                                   Client.Code                      ClientCode,
                                   Client.Name                      ClientName,
                                   Client.SpecialCode               ClientSpecialCode1,
                                   Client.SpecialCode2              ClientSpecialCode2,
                                   Client.SpecialCode3              ClientSpecialCode3,
                                   Client.SpecialCode4              ClientSpecialCode4,
                                   Client.SpecialCode5              ClientSpecialCode5,
                                   Client.SaleChannel               SaleChannel,
                                   Client.Edino                     Edino,
                                   Survey.Code                      SurveyCode,
                                   Survey.Name                      SurveyName,
                                   Response.Status                  SurveyStatus,
                                   Survey.Specode1                  SurveySpecode1,
                                   Survey.Specode2                  SurveySpecode2,
                                   Survey.Specode3                  SurveySpecode3,
                                   UserPoint.Point                  UserPoint,
                                   dbo.F_CHL_CalculateMaxPointForSurveyByDate(
                                           Response.SurveyId, Response.SavedDate,
                                           @pointType
                                   )                                SurveyMaxPoint,
                                   Types.Name AS                    SurveyContentType,
                                   Types.Id   AS                    SurveyContentId,
                                   Survey.Type
                            FROM CHL_UserSurveyResponse Response with (nolock)
                                     JOIN AbpUsers Users with (nolock) ON Users.Id = Response.UserId
                                     JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers ON PermittedUsers.UserId = Response.UserId
                                     JOIN MD_Client Client with (nolock) ON Client.Firm = Response.Firm
                                AND Client.TigerId = Response.ClientId
                                     JOIN CHL_Survey Survey with (nolock) ON Survey.Id = Response.SurveyId
                                     LEFT JOIN MD_StopReason Types with (Nolock) ON Survey.SurveyContentType = Types.Id
                                     left JOIN CHL_UserResponsePoint UserPoint with (nolock) ON UserPoint.ReportId = Response.Id and UserPoint.PointType = 1)