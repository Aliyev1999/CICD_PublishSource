
ALTER PROC [dbo].[SP_MD_GetClientGeneralData] @userId INT, @firm SMALLINT = 0
AS
BEGIN

    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
	declare @IsAuditUser bit = (select iif(UserName like ''%''+''audit''+''%'', 1, 0) from AbpUsers where Id = @userId)
	SELECT 
			Client.Firm, 
			Client.TigerId, 
			Client.Code, 
			iif(
			  @IsAuditUser = 1, 
			  concat(Client.Name, '' - '', Client.Edino), 
			  Client.Name
			) as Name, 
			Client.Edino, 
			Client.Taxno, 
			Client.SpecialCode, 
			Client.SpecialCodeDesc, 
			Client.SpecialCode2, 
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
			PayPlan.Code AS PaymentPlanCode,
            case when exists (
                select ClientId 
                from MD_BannedClient 
                where Status = 0 and Firm = Client.Firm and ClientId = Client.TigerId
            ) then N''Qadağan olunmuş'' else '''' end as Note,
			PayPlan.Name AS PaymentPlanName, 
			TradingGroup.Code AS TradingGroupCode, 
			TradingGroup.Name AS TradingGroupName,
			PayPlan.TigerId AS PaymentPlanId, 
			(
			  CASE WHEN Client.RegisteredDate >= PClient.RegisteredDate THEN Client.RegisteredDate ELSE PClient.RegisteredDate END
			) As RegisteredDate, 
			Client.TigerParentId as ParentId ,
			''cart_black'' AS Icon,
			''#940000'' AS IconColor
			FROM MD_Client Client WITH(NOLOCK) 
			  INNER JOIN (SELECT  Firm, 
								  ClientId, 
								  max(RegisteredDate) AS RegisteredDate
                                            FROM (
                                            SELECT Firm, ClientId, RegisteredDate FROM F_GetPermittedClientForUserWithRegisteredDate(@userId)
								            UNION
								            SELECT Firm, ClientId, RegisteredDate FROM F_GetAllPermittedClientWithRegisteredDate() pc
								            JOIN F_Hybrid_GetPermittedUsers(@userId) pu ON pc.UserId = pu.UserId
                                             and (select Type from F_GetUserRootType(@userId)) =''Hybrid''   )
                                            AS GroupT
                                            GROUP BY Firm, ClientId) PClient ON (PClient.Firm=Client.Firm AND PClient.ClientId= Client.TigerId)
                                LEFT JOIN MD_TradingGroup TradingGroup WITH(NOLOCK) ON TradingGroup.Code=Client.TradingGroupCode
                                LEFT JOIN MD_PaymentPlan PayPlan WITH(NOLOCK) ON (Client.Firm=PayPlan.Firm AND Client.PaymentPlanId=PayPlan.TigerId)
                                WHERE Client.Status=0';
    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and Client.Firm = @firm');
        END
    
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT', @userId = @userId, @firm = @firm
END