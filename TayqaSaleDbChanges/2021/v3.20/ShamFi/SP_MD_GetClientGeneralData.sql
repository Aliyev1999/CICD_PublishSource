USE [TayqaSale]
GO
-- Originally written by TayqaTech, last modified by TayqaTech (KM) to replace...
-- Specode1 and Specode2 with town and city respectively in certain group of users
ALTER PROC [dbo].[SP_MD_GetClientGeneralData] @userId INT, @firm SMALLINT = 0
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
        SELECT Client.Firm,
               Client.TigerId,
               Client.Code,
               Client.Name,
               Client.Edino,
               Client.Taxno,
               IIF(@userId in (select UserId from UIM_UserProperty where Specode1 = ''Storecheck''), Client.Town,
                   Client.SpecialCode)               as SpecialCode,
               Client.SpecialCodeDesc,
               IIF(@userId in (select UserId from UIM_UserProperty where Specode1 = ''Storecheck''), Client.City,
                   Client.SpecialCode2)              as SpecialCode2,
               Client.SpecialCode2Desc,
               Client.SpecialCode3,
               Client.SpecialCode3Desc,
               Client.SpecialCode4,
               Client.SpecialCode4Desc,
               Client.SpecialCode5,
               Client.SpecialCode5Desc,
               Client.AuthorizationCode,
               Client.AuthorizationCodeDesc,
               Client.CardType,
               Client.Status,
               Client.IdentityNo,
               Client.Latitude,
               Client.Longitude,
               Client.Name2,
               PayPlan.Code                          AS PaymentPlanCode,
               PayPlan.Name                          AS PaymentPlanName,
               TradingGroup.Code                     AS TradingGroupCode,
               TradingGroup.Name                     AS TradingGroupName,
               PayPlan.TigerId                       AS PaymentPlanId,
               (CASE
                    WHEN Client.RegisteredDate >= PClient.RegisteredDate THEN Client.RegisteredDate
                    ELSE PClient.RegisteredDate END) As RegisteredDate

        FROM MD_Client Client WITH (NOLOCK)
                 INNER JOIN (SELECT Firm, ClientId, max(RegisteredDate) AS RegisteredDate
                             FROM (
                                      SELECT Firm, ClientId, RegisteredDate
                                      FROM F_GetPermittedClientForUserWithRegisteredDate(@userId)
                                      UNION
                                      SELECT Firm, ClientId, RegisteredDate
                                      FROM F_GetAllPermittedClientWithRegisteredDate() pc
                                               JOIN F_Hybrid_GetPermittedUsers(@userId) pu ON pc.UserId = pu.UserId
                                          and (select Type from F_GetUserRootType(@userId)) = ''Hybrid'')
                                      AS GroupT
                             GROUP BY Firm, ClientId) PClient
                            ON (PClient.Firm = Client.Firm AND PClient.ClientId = Client.TigerId)
                 LEFT JOIN MD_TradingGroup TradingGroup WITH (NOLOCK) ON TradingGroup.Code = Client.TradingGroupCode
                 LEFT JOIN MD_PaymentPlan PayPlan WITH (NOLOCK)
                           ON (Client.Firm = PayPlan.Firm AND Client.PaymentPlanId = PayPlan.TigerId)
        WHERE 1 = 1';

    IF (@firm > 0) SET @sql = CONCAT(@sql, ' and Client.Firm = @firm');

    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT', @userId = @userId, @firm = @firm
END