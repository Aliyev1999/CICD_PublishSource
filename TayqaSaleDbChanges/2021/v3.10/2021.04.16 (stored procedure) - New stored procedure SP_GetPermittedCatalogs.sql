CREATE PROCEDURE [dbo].[SP_GetPermittedCatalogs]
										@usersList NVARCHAR(MAX) = NULL,
										@itemNameOrCode NVARCHAR(50) = NULL,
										@catalogNameOrCode NVARCHAR(50) = NULL,
										@itemId INT = NULL
AS
BEGIN
    DECLARE @QUERY NVARCHAR(MAX) =
        'SELECT DISTINCT U.[Name], U.Surname, U.UserName, C.Name AS CatalogName, C.Code AS CatalogCode
		FROM MD_PermittedCatalog PC
			JOIN AbpUsers U ON PC.UserId = U.Id
			JOIN MD_Catalog C ON PC.CatalogId = C.Id
			LEFT JOIN MD_CatalogItemMapping CIM ON C.Id = CIM.CatalogId
			LEFT JOIN MD_Item I ON CIM.TigerItemId = I.TigerId
		WHERE (1 = 1)'

    IF (@usersList IS NOT NULL)
        BEGIN
			SET @Query = CONCAT(@Query, ' AND (U.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''',@usersList,''',',''','')))')
        END

	IF (@itemId IS NOT NULL AND @itemId <> 0)
        BEGIN
			SET @QUERY = CONCAT(@QUERY, ' AND (I.TigerId = @itemId)');
        END

	IF (@itemNameOrCode IS NOT NULL)
        BEGIN
			SET @QUERY = CONCAT(@QUERY, ' AND (I.Name LIKE ''%' + @itemNameOrCode + '%'' OR I.Code LIKE ''%' + @itemNameOrCode + '%'')');
        END

	IF (@catalogNameOrCode IS NOT NULL)
        BEGIN
			SET @QUERY = CONCAT(@QUERY, ' AND (C.Name LIKE ''%' + @catalogNameOrCode + '%'' OR C.Code LIKE ''%' + @catalogNameOrCode + '%'')');
        END
    EXEC sp_executesql @QUERY,
         N'
		 @usersList				NVARCHAR,
         @itemNameOrCode		NVARCHAR,
		 @catalogNameOrCode		NVARCHAR,
		 @itemId				INT',
         @usersList = @usersList,
		 @itemNameOrCode = @itemNameOrCode,
		 @catalogNameOrCode = @catalogNameOrCode,
		 @itemId = @itemId
END
