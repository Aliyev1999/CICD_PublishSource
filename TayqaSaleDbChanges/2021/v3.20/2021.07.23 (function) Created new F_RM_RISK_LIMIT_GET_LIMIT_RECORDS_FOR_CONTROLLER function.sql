
CREATE function [dbo].[F_RM_RISK_LIMIT_GET_LIMIT_RECORDS_FOR_CONTROLLER] (@beginDateTimeStamp datetime,@Specode nvarchar(50),@UserId int=null)
    returns table
        as
        return
            (
                SELECT Requests.Id                                        as Id,
                       Requests.RequestId                                 as RequestId,
                       Requests.Firm                                      as Firm,
                       Requests.CreatedDate                               as CreatedDate,
                       Requests.CreatedUserId                             as CreatedUserId,
                       CreatedUser.Name + ' ' + CreatedUser.Surname       as CreatedUser,
                       Requests.CreatedNote                               as CreatedNote,
                       Requests.ControlledDate                            as ControlledDate,
                       Requests.ControlledUserId                          as ControlledUserId,
                       ControlledUser.Name + ' ' + ControlledUser.Surname as ControlledUser,
                       Requests.ControlledNote                            as ControlledNote,
                       Requests.Status                                    as Status,
                       MDCLNT.TigerId                                     as ClientId,
                       MDCLNT.Code                                        as ClientCode,
                       MDCLNT.Name                                        as ClientName,
                       CLNT.CurrentLimit                                  as CurrentLimit,
                       CLNT.RequestedLimit                                as RequestedLimit

                FROM OP_RiskLimitRequest Requests
                         INNER JOIN OP_RiskLimitClient CLNT ON Requests.Id = CLNT.RequestId
                         INNER JOIN AbpUsers CreatedUser ON CreatedUser.Id = Requests.CreatedUserId
                         LEFT JOIN AbpUsers ControlledUser ON ControlledUser.Id = Requests.ControlledUserId
                         INNER JOIN MD_Client MDCLNT ON (MDCLNT.TigerId = CLNT.ClientId and MDCLNT.Firm = Requests.Firm)
                         INNER JOIN F_UIM_GetOrganizationTreeUsers(@UserId) ChildUserList ON ChildUserList.UserId = CreatedUser.Id

                WHERE Requests.CreatedDate >= @beginDateTimeStamp
                  AND @UserId in (SELECT UserId
                                  FROM UIM_UserPermission Permission
                                  WHERE Permission.PermissionId in (575, 576, 577, 578) AND PermissionValue = 1)
            )



