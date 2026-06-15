
CREATE FUNCTION [dbo].[F_RM_RISK_LIMIT_GET_LIMIT_RECORDS_FOR_USER] (@beginDateTimeStamp datetime,@UserId int)
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
                       Client.TigerId                                     as ClientId,
                       Client.Code                                        as ClientCode,
                       Client.Name                                        as ClientName,
                       RequestClient.CurrentLimit                         as CurrentLimit,
                       RequestClient.RequestedLimit                       as RequestedLimit
                FROM OP_RiskLimitRequest Requests
                         INNER JOIN OP_RiskLimitClient RequestClient ON Requests.Id = RequestClient.RequestId
                         INNER JOIN AbpUsers CreatedUser ON CreatedUser.Id = Requests.CreatedUserId
                         LEFT JOIN AbpUsers ControlledUser ON ControlledUser.Id = Requests.ControlledUserId
                         INNER JOIN MD_Client Client
                                    ON (Client.TigerId = RequestClient.ClientId and Client.Firm = Requests.Firm)
                WHERE Requests.CreatedDate >= @beginDateTimeStamp
                  AND Requests.CreatedUserId = @UserId
            )





