Create or ALTER PROCEDURE [dbo].[SP_MGM_GetRiskLimitRequests] @firm smallint,
@beginDate DATETIME = NULL,
                                                    @endDate DATETIME = NULL,
                                                    @isCompleted BIT,
                                                    @userId INT
													
AS
BEGIN
    SET NOCOUNT ON;
    ;
    WITH RiskLimitData AS (SELECT RiskLimitRequest.Id                                                                            AS RequestId,
                                  RiskLimitRequest.CreatedDate,
                                  RiskLimitRequest.CreatedUserId,
                                  RiskLimitRequest.ControlledUserId,
                                  RiskLimitRequest.Firm,
                                  RiskLimitRequest.SalesmanId,
                                  RiskLimitRequest.Status,
								  RiskLimitRequest.ControlledDate,
                                  SUM(RiskLimitClient.RequestedLimit)                                                            AS RequestedLimit,
                                  MAX(CASE WHEN RiskLimitClient.CurrentLimit < RiskLimitClient.RequestedLimit THEN 1 ELSE 0 END) AS HasIncrease,
                                  MAX(CASE WHEN RiskLimitClient.CurrentLimit > RiskLimitClient.RequestedLimit THEN 1 ELSE 0 END) AS HasDecrease,
                                  COUNT(DISTINCT RiskLimitClient.ClientId)                                                       AS ClientCount
                           FROM OP_RiskLimitRequest AS RiskLimitRequest WITH (NOLOCK)
                                    INNER JOIN OP_RiskLimitClient AS RiskLimitClient WITH (NOLOCK)
                                               ON RiskLimitClient.RequestId = RiskLimitRequest.Id
                                    JOIN dbo.F_GetPermittedUsers(@userId) AS PermittedUsers
                                         ON PermittedUsers.UserId = RiskLimitRequest.CreatedUserId
                           WHERE (@beginDate IS NULL OR RiskLimitRequest.CreatedDate >= @beginDate)
                             AND (@endDate IS NULL OR RiskLimitRequest.CreatedDate <= @endDate)
                             AND (
                               (@isCompleted = 0 AND RiskLimitRequest.Status = 0)
                                   OR (@isCompleted = 1 AND RiskLimitRequest.Status IN (1, 2))
                               ) 
                           GROUP BY RiskLimitRequest.Id,
                                    RiskLimitRequest.CreatedDate,
                                    RiskLimitRequest.CreatedUserId,
                                    RiskLimitRequest.ControlledUserId,
                                    RiskLimitRequest.Firm,
                                    RiskLimitRequest.SalesmanId,
                                    RiskLimitRequest.Status,
									RiskLimitRequest.ControlledDate)

    SELECT d.RequestId                                                                   AS RequestNo,
           CONCAT(Users.Name, ' ', Users.Surname)                                        AS Name,
           ProfilePhoto.ImageUrl                                                         AS ProfilePhoto,
           d.RequestedLimit                                                              AS [Amount],
           d.CreatedDate                                     AS [Date],
           d.ClientCount,
           CASE
               WHEN d.HasIncrease = 1 AND d.HasDecrease = 1 THEN 2 -- həm artır, həm azalır
               WHEN d.HasIncrease = 1 THEN 0 -- artır
               WHEN d.HasDecrease = 1 THEN 1 -- azalır
               ELSE NULL
               END                                                                       AS ChangeType,
           SalesMan.Name                                                                 AS Salesman,
           SalesMan.Code                                                                 AS SalesmanCode,
           Currency.Code                                                                 AS Currency,
           CASE WHEN @isCompleted = 1 THEN CONCAT(Users1.Name, ' ', Users1.Surname) END  AS CommentName,
           CASE WHEN @isCompleted = 1 THEN d.ControlledDate END AS CommentDate,
           CASE
               WHEN @isCompleted = 1 THEN
                   CASE
                       WHEN d.Status = 1 THEN 0 -- təsdiq
                       WHEN d.Status = 2 THEN 1 -- imtina
                       END
               END                                                                       AS CommentStatus
    FROM RiskLimitData AS d
             INNER JOIN AbpUsers AS Users WITH (NOLOCK)
                        ON d.CreatedUserId = Users.Id
             INNER JOIN MD_Firm AS Firm WITH (NOLOCK)
                        ON d.Firm = Firm.Nr
             INNER JOIN MD_Currency AS Currency WITH (NOLOCK)
                        ON Currency.Type = Firm.LocalCurrencyTypeId AND Currency.Firm = Firm.Nr
             LEFT JOIN MD_SalesMan AS SalesMan WITH (NOLOCK)
                       ON SalesMan.TigerId = d.SalesmanId AND SalesMan.Firm = d.Firm
             LEFT JOIN AbpUsers AS Users1 WITH (NOLOCK)
                       ON d.ControlledUserId = Users1.Id
             LEFT JOIN AbpUserProfilePhoto AS ProfilePhoto WITH (NOLOCK)
                       ON ProfilePhoto.UserId = Users.Id
				where d.Firm=@firm
    ORDER BY d.CreatedDate DESC;
END;




