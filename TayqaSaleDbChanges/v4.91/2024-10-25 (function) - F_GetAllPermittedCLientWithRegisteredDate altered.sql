
ALTER FUNCTION [dbo].[F_GetAllPermittedClientWithRegisteredDate]()
    RETURNS TABLE
        AS
        return
        SELECT Firm                           as Firm,
               cast(UserId as bigint)         as UserId,
               ClientId                       AS ClientId,
               MAX(RegisteredDate)            AS RegisteredDate,
               cast(SUM(SyncFlag) as tinyint) AS SyncFlag
        FROM (SELECT Firm, UserId, TigerClientId AS ClientId, RegisteredDate, 1 AS SyncFlag
              FROM MD_PermittedClient WITH (NOLOCK)
              UNION
              SELECT CMapping.Firm,
                     EMapping.UserId,
                     CMapping.ClientId,
                     MAX((IIF(EMapping.CreatedDate >= CMapping.RegisteredDate, EMapping.CreatedDate, CMapping.RegisteredDate))) AS RegisteredDate,
                     2                                                                                                          AS SyncFlag
              FROM MD_SalesmanClientMapping CMapping WITH (NOLOCK)
                       INNER JOIN UIM_UserEmployeeMapping EMapping WITH (NOLOCK)
                                  ON (EMapping.EmployeeId = CMapping.SalesmanId AND EMapping.Firm = CMapping.Firm AND EMapping.Status = 0)
              GROUP BY CMapping.Firm, EMapping.UserId, CMapping.ClientId) AS T
        GROUP BY Firm, UserId, ClientId