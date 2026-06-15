CREATE OR ALTER PROCEDURE [dbo].[SP_IM_GetAssetList] @startDate DATETIME,
                                            @endDate DATETIME,
                                            @firm SMALLINT,
                                            @assetNr NVARCHAR(50),
                                            @serialNr NVARCHAR(50),
                                            @itemNameOrCode NVARCHAR(100),
                                            @status INT,
                                            @syncFlag BIT,
                                            @dontUseLikeFilterForAssetNr BIT,
                                            @responsiblePersonNameOrCode NVARCHAR(100),
                                            @responsiblePerson2NameOrCode NVARCHAR(100),
                                            @specialCodeFilter NVARCHAR(100),
                                            @divisionNrs NVARCHAR(MAX),
                                            @warehouseNrs NVARCHAR(MAX),
                                            @sorting NVARCHAR(50),
                                            @skipCount INT,
                                            @maxResultCount INT,
                                            @totalCount INT OUT
AS
BEGIN

    DECLARE @query NVARCHAR(MAX);
    DECLARE @totalCountQuery NVARCHAR(MAX);

    SET @query = 'SELECT
	asset. Id,
	asset. Firm,
	firm. Name FirmName,
	item. TigerId AS ItemId,
	item. Name AS ItemName,
	item. Code AS ItemCode,
	asset. AssetNr,
	asset. SerialNr,
	asset. PurchaseDate,
	asset. InitialCostPrice,
	asset. CurrentCostPrice,
	asset. AmortizationBeginDate,
	asset. AmortizationPercent,
	asset. AmortizationTerm,
	asset. SpecialCode,
	asset. SpecialCode2,
	asset. SpecialCode3,
	asset. Status,
	responsiblePerson. TigerId AS ResponsiblePerson,
	responsiblePerson. Code AS ResponsiblePersonCode,
    responsiblePerson. Name AS ResponsiblePersonName,
	responsiblePerson2.TigerId AS ResponsiblePerson2,
	responsiblePerson2.Code AS ResponsiblePerson2Code,
    responsiblePerson2.Name AS ResponsiblePerson2Name,
	asset. CreationTime,
	asset. CreatorUserId,
	asset. BindingType,
	asset. BindingReference,
	asset. WarehouseNr,
	asset. DivisionNr,
	warehouse. Name AS WarehouseName,
	division. Name AS DivisionName,
	creatorUser. Name AS CreatorUserName,
	asset. SyncFlag,
	CASE WHEN EXISTS(SELECT 1 FROM IM_AssetAttachment WITH(NOLOCK) WHERE ReferenceId = asset.Id) 
			 THEN CAST(1 AS BIT) 
			 ELSE CAST(0 AS BIT) 
         END AS HasAttachment
	FROM IM_Asset asset
	JOIN MD_Firm firm on asset. Firm = firm. Nr
	JOIN MD_Item item WITH(NOLOCK) on item. Firm = asset. Firm AND item. TigerId = asset. ItemId
	JOIN MD_Warehouse warehouse WITH(NOLOCK) ON asset. Firm = warehouse. Firm AND asset. WarehouseNr = warehouse. Nr
	JOIN MD_Division division WITH(NOLOCK) ON asset. Firm = division. Firm AND asset. DivisionNr = division. Nr
	LEFT JOIN MD_Salesman responsiblePerson WITH(NOLOCK) ON asset. ResponsiblePerson = responsiblePerson. TigerId and asset. Firm = responsiblePerson. Firm
	LEFT JOIN MD_Salesman responsiblePerson2 WITH(NOLOCK) ON asset. ResponsiblePerson2 = responsiblePerson2.TigerId and asset. Firm = responsiblePerson2.Firm
	JOIN AbpUsers creatorUser WITH(NOLOCK) on asset. CreatorUserId = creatorUser. Id 
	WHERE 1 = 1
';

    IF (@startDate IS NOT NULL AND @endDate IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND asset. CreationTime BETWEEN  @startDate AND @endDate');
        END

    IF (@firm IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND asset. Firm = @firm');
        END

    IF (@assetNr IS NOT NULL)
        BEGIN
            IF (@dontUseLikeFilterForAssetNr = 1)
                BEGIN
                    SET @query = CONCAT(@query, ' AND asset. AssetNr = @assetNr');
                END
            ELSE
                BEGIN
                    SET @query = CONCAT(@query, ' AND asset. AssetNr LIKE ''%'' + @assetNr + ''%''');
                END
        END

    IF (@serialNr IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND asset. SerialNr LIKE ''%'' + @serialNr + ''%''');
        END

    IF (@itemNameOrCode IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND ( item. Name LIKE ''%'' + @itemNameOrCode + ''%'' OR item. Code LIKE ''%'' + @itemNameOrCode + ''%'')');
        END

    IF (@status IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND asset. Status = @status');
        END

    IF (@syncFlag IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND asset. SyncFlag = @syncFlag');
        END

    IF (@responsiblePersonNameOrCode IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query,
                                ' AND ( responsiblePerson. Name LIKE ''%'' + @responsiblePersonNameOrCode + ''%'' OR responsiblePerson. Code LIKE ''%'' + @responsiblePersonNameOrCode + ''%'' )');
        END

    IF (@responsiblePerson2NameOrCode IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query,
                                ' AND ( responsiblePerson2.Name LIKE ''%'' + @responsiblePerson2NameOrCode + ''%'' OR responsiblePerson2.Code LIKE ''%'' + @responsiblePerson2NameOrCode + ''%'' )');
        END

    IF (@specialCodeFilter IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND (asset.SpecialCode LIKE ''%'' + @specialCodeFilter + ''%'' OR asset. SpecialCode2 LIKE ''%'' + @specialCodeFilter + ''%'' OR asset. SpecialCode3 LIKE ''%'' + @specialCodeFilter + ''%'') ');
        END

	IF (@warehouseNrs IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND (asset.WarehouseNr IN (SELECT VALUE FROM F_SplitList(''', @warehouseNrs, ''',', ''','')))')
        END

	IF (@divisionNrs IS NOT NULL)
        BEGIN
            SET @query = CONCAT(@query, ' AND (asset.DivisionNr IN (SELECT VALUE FROM F_SplitList(''', @divisionNrs, ''',', ''','')))')
        END

    SET @totalCountQuery = CONCAT('SELECT @totalCount = COUNT(1) FROM (', @query, ' ) t');

    print (@totalCountQuery);

    EXECUTE sp_executesql @totalCountQuery,
            N'@startDate DATETIME,
            @endDate DATETIME,
            @firm SMALLINT,
            @assetNr NVARCHAR(50),
            @serialNr NVARCHAR(50),
            @itemNameOrCode NVARCHAR(50),
            @status INT,
            @syncFlag BIT,
            @dontUseLikeFilterForAssetNr BIT,
            @responsiblePersonNameOrCode NVARCHAR(100),
            @responsiblePerson2NameOrCode NVARCHAR(100),
            @specialCodeFilter NVARCHAR(100),
            @totalCount INT OUT',
            @startDate = @startDate,
            @endDate = @endDate,
            @firm = @firm,
            @assetNr = @assetNr,
            @serialNr = @serialNr,
            @itemNameOrCode = @itemNameOrCode,
            @status = @status,
            @syncFlag = @syncFlag,
            @dontUseLikeFilterForAssetNr = @dontUseLikeFilterForAssetNr,
            @responsiblePersonNameOrCode = @responsiblePersonNameOrCode,
            @responsiblePerson2NameOrCode = @responsiblePerson2NameOrCode,
            @specialCodeFilter = @specialCodeFilter,
            @totalCount = @totalCount OUT;

    SET @query = concat(@query, ' ORDER BY ' + @sorting + '  OFFSET @skipCount ROWS FETCH NEXT @maxResultCount ROWS ONLY')

    EXECUTE sp_executesql @query,
            N'@startDate DATETIME,
              @endDate DATETIME,
              @firm SMALLINT,
              @assetNr NVARCHAR(50),
              @serialNr NVARCHAR(50),
              @itemNameOrCode NVARCHAR(50),
              @status INT,
              @syncFlag BIT,
              @dontUseLikeFilterForAssetNr BIT,
              @responsiblePersonNameOrCode NVARCHAR(100),
              @responsiblePerson2NameOrCode NVARCHAR(100),
              @specialCodeFilter NVARCHAR(100),
              @sorting NVARCHAR(50),
              @skipCount INT,
              @maxResultCount INT,
              @totalCount INT OUT',
            @startDate = @startDate,
            @endDate = @endDate,
            @firm = @firm,
            @assetNr = @assetNr,
            @serialNr = @serialNr,
            @itemNameOrCode = @itemNameOrCode,
            @status = @status,
            @syncFlag = @syncFlag,
            @dontUseLikeFilterForAssetNr = @dontUseLikeFilterForAssetNr,
            @responsiblePersonNameOrCode = @responsiblePersonNameOrCode,
            @responsiblePerson2NameOrCode = @responsiblePerson2NameOrCode,
            @specialCodeFilter = @specialCodeFilter,
            @sorting = @sorting,
            @skipCount = @skipCount,
            @maxResultCount = @maxResultCount,
            @totalCount = @totalCount OUT;
END