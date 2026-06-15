CREATE OR ALTER FUNCTION [dbo].[F_RM_RISK_LIMIT_GET_LIMIT_RECORDS_FOR_USER] (@beginDateTimeStamp datetime,@UserId int)
    returns table
        as
        return
            (
                SELECT REQ.Id                                Id,
                       REQ.RequestId                         RequestId,
                       REQ.Firm                              Firm,
                       REQ.CreatedDate                       CreatedDate,
                       REQ.CreatedUserId                     CreatedUserId,
                       CRTUSR.Name + ' ' + CRTUSR.Surname as CreatedUser,
                       REQ.CreatedNote                       CreatedNote,
                       REQ.ControlledDate                    ControlledDate,
                       REQ.ControlledUserId                  ControlledUserId,
                       CONUSR.Name + ' ' + CONUSR.Surname as ControlledUser,
                       REQ.ControlledNote                    ControlledNote,
                       REQ.Status                            Status,
                       MDCLNT.TigerId                     as ClientId,
                       MDCLNT.Code                        as ClientCode,
                       MDCLNT.Name                        as ClientName,
                       CLNT.CurrentLimit,
                       CLNT.RequestedLimit
                FROM OP_RiskLimitRequest REQ
                         INNER JOIN OP_RiskLimitClient CLNT ON REQ.Id = CLNT.RequestId
                         INNER JOIN AbpUsers CRTUSR ON CRTUSR.Id = REQ.CreatedUserId
                         LEFT JOIN AbpUsers CONUSR ON CONUSR.Id = REQ.ControlledUserId
                         INNER JOIN MD_Client MDCLNT ON (MDCLNT.TigerId = CLNT.ClientId and MDCLNT.Firm = REQ.Firm)
                WHERE REQ.CreatedDate >= @beginDateTimeStamp
                  AND REQ.CreatedUserId = @UserId
            )
GO

