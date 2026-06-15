CREATE PROCEDURE [dbo].[SP_MD_GetItemStandardPrices] @userId INT, @currentDate DATETIME, @firm SMALLINT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'WITH PermittedItems AS (
				SELECT Items.Firm, Items.TigerId AS TigerItemId
				FROM MD_Item Items
				WHERE Items.Status = 0
				  AND Items.IsDeleted = 0
				  AND Exists(SELECT DISTINCT Cat.Firm, ItemMapping.TigerItemId
				FROM MD_CatalogItemMapping ItemMapping WITH (NOLOCK)
						 INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON (Cat.Id = ItemMapping.CatalogId)
						 INNER JOIN MD_PermittedCatalog Pc WITH (NOLOCK) ON Pc.CatalogId = cat.Id AND Pc.UserId = @userId
					AND Items.TigerId = ItemMapping.TigerItemId AND Items.Firm = Cat.Firm)),

				 PermittedCurrencies AS (
					 SELECT Nr, LocalCurrencyTypeId AS CurrencyTypeId
					 FROM MD_Firm Firm WITH (NOLOCK)
							  JOIN MD_PermittedFirm PermittedFirm WITH (NOLOCK) ON Firm.Nr = PermittedFirm.Firm AND PermittedFirm.UserId = @userId)

			SELECT Price.TigerId,
				   Price.Firm,
				   Price.TigerItemId,
				   Price.TigerItemUnitId,
				   Price.BeginDate,
				   Price.EndDate,
				   Price.Price,
				   Price.CurrencyTypeId,
				   (CASE WHEN PriceMapping.DivisionNr = -1 THEN 100 ELSE 105 END) AS PriceType,
				   PriceMapping.DivisionNr AS PriceTypeId,
				   Price.OperationMask,
				   Price.VatIncluded,
				   Price.IsConvertible,
				   Price.RegisteredDate,
				   Price.Priority
			FROM [MD_ItemPrice] Price WITH (NOLOCK)
					 INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr = Price.Firm AND Currency.CurrencyTypeId = Price.CurrencyTypeId)
					 INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm = Price.Firm AND PermittedItems.TigerItemId = Price.TigerItemId)
					 INNER JOIN MD_ItemPriceDivisionMapping PriceMapping WITH (NOLOCK) ON (PriceMapping.TigerId = Price.TigerId AND PriceMapping.Firm = Price.Firm)
			WHERE Price.Status = 0
			  AND Price.IsDeleted = 0
			  AND Price.BeginDate <= @currentDate
			  AND Price.EndDate >= @currentDate
			  AND Price.SaleChannelMask LIKE ''1%'''
    
     IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and Price.Firm = @firm');
        END

    EXEC sp_executesql @sql, N'@userId INT, @currentDate DATETIME, @firm SMALLINT', @userId = @userId, @currentDate = @currentDate, @firm = @firm

END
GO


CREATE PROCEDURE [dbo].[SP_MD_GetItemSpecificPrices] @userId INT, @currentDate DATETIME, @firm SMALLINT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'WITH PermittedItems AS (
				SELECT Items.Firm, Items.TigerId AS TigerItemId
				FROM MD_Item Items
				WHERE Items.Status = 0
				  AND Items.IsDeleted = 0
				  AND Exists(SELECT DISTINCT Cat.Firm, ItemMapping.TigerItemId
				FROM MD_CatalogItemMapping ItemMapping WITH (NOLOCK)
						 INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON (Cat.Id = ItemMapping.CatalogId)
						 INNER JOIN MD_PermittedCatalog Pc WITH (NOLOCK) ON Pc.CatalogId = cat.Id AND Pc.UserId = @userId
					AND Items.TigerId = ItemMapping.TigerItemId AND Items.Firm = Cat.Firm)),

				 PermittedCurrencies AS (
					 SELECT Nr, LocalCurrencyTypeId AS CurrencyTypeId
					 FROM MD_Firm Firm WITH (NOLOCK)
							  JOIN MD_PermittedFirm PermittedFirm WITH (NOLOCK) ON Firm.Nr = PermittedFirm.Firm AND PermittedFirm.UserId = @userId),

				 PermittedClients AS (
					 SELECT PClient.Firm,
							PClient.ClientId,
							PriceClientGroup.GroupId AS PriceGroupId
					 FROM F_GetPermittedClientForUser(@userId) PClient
							  LEFT JOIN MD_ClientGroupData PriceClientGroup WITH (NOLOCK)
										ON (PriceClientGroup.Firm = PClient.Firm AND PriceClientGroup.ClientId = PClient.ClientId AND PriceClientGroup.GroupType = 1)
					 WHERE UserId = @userId)

			SELECT *
			FROM (SELECT Price.TigerId,
						 Price.Firm,
						 Price.TigerItemId,
						 Price.TigerItemUnitId,
						 Price.BeginDate,
						 Price.EndDate,
						 Price.Price,
						 Price.CurrencyTypeId,
						 110 AS PriceType,
						 Price.ClientGroupId AS PriceTypeId,
						 Price.OperationMask,
						 Price.VatIncluded,
						 Price.IsConvertible,
						 Price.RegisteredDate,
						 Price.Priority
			FROM MD_ItemSpecificClientGroupPrice Price WITH (NOLOCK)
					 INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr = Price.Firm AND Currency.CurrencyTypeId = Price.CurrencyTypeId)
					 INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm = Price.Firm AND PermittedItems.TigerItemId = Price.TigerItemId)
					 INNER JOIN PermittedClients PClient WITH (NOLOCK) ON (PClient.PriceGroupId = Price.ClientGroupId AND PClient.Firm = Price.Firm)
			WHERE Price.Status = 0
			  AND Price.IsDeleted = 0
			  AND Price.BeginDate <= @currentDate
			  AND Price.EndDate >= @currentDate
			  AND Price.SaleChannelMask LIKE ''1%''
			UNION ALL
			SELECT Price.TigerId,
				   Price.Firm,
				   Price.TigerItemId,
				   Price.TigerItemUnitId,
				   Price.BeginDate,
				   Price.EndDate,
				   Price.Price,
				   Price.CurrencyTypeId,
				   115 AS PriceType,
				   Price.ClientId AS PriceTypeId,
				   Price.OperationMask,
				   Price.VatIncluded,
				   Price.IsConvertible,
				   Price.RegisteredDate,
				   Price.Priority
			FROM MD_ItemSpecificClientPrice Price WITH (NOLOCK)
					 INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr = Price.Firm AND Currency.CurrencyTypeId = Price.CurrencyTypeId)
					 INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm = Price.Firm AND PermittedItems.TigerItemId = Price.TigerItemId)
					 INNER JOIN PermittedClients PClient WITH (NOLOCK) ON (PClient.ClientId = Price.ClientId AND PClient.Firm = Price.Firm)
			WHERE Price.Status = 0
			  AND Price.IsDeleted = 0
			  AND Price.BeginDate <= @currentDate
			  AND Price.EndDate >= @currentDate
			  AND Price.SaleChannelMask LIKE ''1%'') AllPrices
			WHERE 1 = 1'
    
     IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and AllPrices.Firm = @firm');
        END

    EXEC sp_executesql @sql, N'@userId INT, @currentDate DATETIME, @firm SMALLINT', @userId = @userId, @currentDate = @currentDate, @firm = @firm

END

GO


CREATE PROCEDURE [dbo].[SP_MD_GetItemSuggestedPrices] @userId INT, @currentDate DATETIME, @firm SMALLINT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'WITH PermittedItems AS (
				SELECT Items.Firm, Items.TigerId AS TigerItemId
				FROM MD_Item Items
				WHERE Items.Status = 0
				  AND Items.IsDeleted = 0
				  AND Exists(SELECT DISTINCT Cat.Firm, ItemMapping.TigerItemId
				FROM MD_CatalogItemMapping ItemMapping WITH (NOLOCK)
						 INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON (Cat.Id = ItemMapping.CatalogId)
						 INNER JOIN MD_PermittedCatalog Pc WITH (NOLOCK) ON Pc.CatalogId = cat.Id AND Pc.UserId = @userId
					AND Items.TigerId = ItemMapping.TigerItemId AND Items.Firm = Cat.Firm)),

				 PermittedClients AS (
					 SELECT DISTINCT PClient.Firm,
									 PClient.ClientId,
									 SuggestedClientGroup.GroupId AS SuggestedPriceGroupId
					 FROM F_GetPermittedClientForUser(@userId) PClient
							  LEFT JOIN MD_ClientGroupData SuggestedClientGroup WITH (NOLOCK)
										ON (SuggestedClientGroup.Firm = PClient.Firm AND SuggestedClientGroup.ClientId = PClient.ClientId AND
											SuggestedClientGroup.GroupType = 4)
					 WHERE UserId = @userId)

			SELECT Price.Id AS TigerId,
				   Price.Firm,
				   Price.ItemId TigerItemId,
				   Price.ItemUnitId TigerItemUnitId,
				   ''2018-01-01'' BeginDate,
				   ''2030-01-01'' EndDate,
				   Price.Price,
				   Price.CurrencyTypeId,
				   200 AS PriceType,
				   Price.ClientGroupId AS PriceTypeId,
				   ''1111100000'' OperationMask,
				   0 VatIncluded,
				   Price.IsConvertible,
				   Price.RegisteredDate,
				   Price.Priority
			FROM MD_ItemSuggestedPrice Price WITH (NOLOCK)
			WHERE Price.ItemId IN (SELECT ItemId FROM PermittedItems WITH (NOLOCK) WHERE Firm = Price.Firm)
			  AND Price.ClientGroupId IN (SELECT SuggestedPriceGroupId FROM PermittedClients WITH (NOLOCK) WHERE Firm = Price.Firm)'
    
     IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and Price.Firm = @firm');
        END

    EXEC sp_executesql @sql, N'@userId INT, @currentDate DATETIME, @firm SMALLINT', @userId = @userId, @currentDate = @currentDate, @firm = @firm

END