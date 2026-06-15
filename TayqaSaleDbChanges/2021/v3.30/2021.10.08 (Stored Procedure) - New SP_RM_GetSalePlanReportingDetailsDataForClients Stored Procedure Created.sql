/****** Object:  StoredProcedure [dbo].[SP_RM_GetSalePlanReportingDetailsDataForClients]    Script Date: 10/8/2021 3:12:20 PM ******/
CREATE PROCEDURE [dbo].[SP_RM_GetSalePlanReportingDetailsDataForClients](
											@firm SMALLINT =NULL,
											@clientCodeNameOrEdino NVARCHAR(500) =NULL,
											@clientSpecialCodes NVARCHAR(500)= NULL,
											@itemCodeOrName NVARCHAR(500)= NULL,
											@itemGroups NVARCHAR(500)= NULL,
											@months NVARCHAR(500)= NULL,
											@years NVARCHAR(500) =NULL,
											@planType INT= NULL,
											@userId INT=NULL,
											@salesmanId INT =NULL,
											@currencyType SMALLINT= NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
			SELECT ClientId																				AS ClientId,
				   ClientCode																			AS ClientCode,
				   ClientName																			AS ClientName,
                   ITEMGROUP.Code                                                                       AS ItemGroupCode,
                   ITEMGROUP.Name                                                                       AS ItemGroupName,
				   FACTQUERY.ItemId																		AS ItemId,
				   FACTQUERY.ItemCode																	AS ItemCode,
				   FACTQUERY.ItemName																	AS ItemName,
				   DATENAME(month, DATEADD(month, UserPlan.Month-1, CAST(''2021-01-01'' AS DATETIME)))	AS [Month],
				   USERPLAN.Year                         AS [Year],
				   ROUND(SUM(FACTQUERY.FactQuantity), 2) AS FactQuantity,
				   ROUND(SUM(FACTQUERY.FactAmount), 2)   AS FactAmount,
				   ROUND(SUM(FACTQUERY.FactQuantity) -
						 LAG(SUM(FACTQUERY.FactQuantity))
							 OVER (PARTITION BY ClientId ORDER BY ClientId, ClientCode, ClientName, USERPLAN.Month, USERPLAN.Year),
						 2)                              AS QuantityTrend,
				   ROUND(SUM(FACTQUERY.FactAmount) -
						 LAG(SUM(FACTQUERY.FactAmount))
							 OVER (PARTITION BY ClientId ORDER BY ClientId, ClientCode, ClientName, USERPLAN.Month, USERPLAN.Year),
						 2)                              AS AmountTrend
			FROM MD_ItemGroupPlanForUser USERPLAN WITH (NOLOCK)
				JOIN MD_ItemGroupItemMapping PLANITEMS WITH (NOLOCK) ON USERPLAN.ItemGroupId = PLANITEMS.GroupId AND USERPLAN.Firm = PLANITEMS.Firm
                JOIN MD_ItemGroup ITEMGROUP WITH (NOLOCK) ON USERPLAN.ItemGroupId = ITEMGROUP.Id 
				JOIN UIM_UserEmployeeMapping USEREMPLOYEE
				WITH (NOLOCK) ON USERPLAN.Firm = USEREMPLOYEE.Firm AND USEREMPLOYEE.UserId = USERPLAN.UserId AND USEREMPLOYEE.EmployeeId = @salesmanId
					 JOIN (SELECT MONTH(INVOICE.Date) AS [Month],
								  YEAR(INVOICE.Date)  AS [Year],
								  SalesmanId          AS Salesman,
								  CLIENT.TigerId      AS ClientId,
								  CLIENT.Code         AS ClientCode,
								  CLIENT.Name         AS ClientName,
								  INVOICE.Firm        AS Firm,
								  ITEM.Code           AS ItemCode,
								  ITEM.Name           AS ItemName,
								  [LINE].ItemId,
								  ROUND(SUM(IIF(INVOICE.Type = 4, (Quantity * [LINE].Price) - [LINE].DiscountAmount, 0)) -
										SUM(IIF(INVOICE.Type = 2, (Quantity * [LINE].Price) - [LINE].DiscountAmount, 0)),
										2)            AS FactAmount,
								  ROUND(
											  SUM(IIF(INVOICE.Type = 4, (UNIT.Convfact2 / UNIT.Convfact1) * Quantity, 0)) -
											  SUM(IIF(INVOICE.Type = 2, (UNIT.Convfact2 / UNIT.Convfact1) * Quantity, 0)),
											  2)      AS FactQuantity
						   FROM ERP_Invoice INVOICE WITH (NOLOCK)
									JOIN ERP_InvoiceLine [LINE] WITH (NOLOCK) ON [LINE].InvoiceId = INVOICE.Id
									JOIN MD_Item ITEM WITH (NOLOCK) ON [LINE].ItemId = ITEM.TigerId AND INVOICE.Firm = ITEM.Firm AND ITEM.Firm = @firm
									JOIN MD_Firm FIRM ON ITEM.Firm = FIRM.Nr AND FIRM.LocalCurrencyTypeId = @currencyType
									JOIN MD_ItemUnit UNIT WITH (NOLOCK) ON UNIT.Code = [LINE].ItemUnitCode AND [LINE].ItemId = UNIT.TigerItemId and UNIT.Firm = ITEM.Firm
									JOIN MD_Client CLIENT WITH (NOLOCK) ON CLIENT.TigerId = INVOICE.ClientId AND CLIENT.Firm = INVOICE.Firm

						   WHERE
								INVOICE.IsDeleted = 0 AND
								IsCancelled = 0 AND
                                [LINE].LineType<>1 AND
								(ITEM.IsDeleted IS NULL OR ITEM.IsDeleted = 0) AND ITEM.[Status] = 0 AND
								(CLIENT.IsDeleted IS NULL OR CLIENT.IsDeleted = 0) AND CLIENT.[Status] = 0'

    IF @clientCodeNameOrEdino IS NOT NULL
		BEGIN
            SET @Query = CONCAT(@Query, ' AND (CLIENT.Code LIKE ''%'' + @clientCodeNameOrEdino + ''%'' OR CLIENT.Name LIKE ''%'' + @clientCodeNameOrEdino + ''%'' OR CLIENT.Edino LIKE ''%'' + @clientCodeNameOrEdino + ''%'')')
		END

    IF @clientSpecialCodes IS NOT NULL
		BEGIN
            SET @Query = CONCAT(@Query, ' AND (CLIENT.SpecialCode LIKE ''%'' + @clientSpecialCodes + ''%'' OR CLIENT.SpecialCode2 LIKE ''%'' + @clientSpecialCodes + ''%'' OR CLIENT.SpecialCode3 LIKE ''%'' + @clientSpecialCodes + ''%'' OR CLIENT.SpecialCode4 LIKE ''%'' + @clientSpecialCodes + ''%'' OR CLIENT.SpecialCode5 LIKE ''%'' + @clientSpecialCodes + ''%'')')
		END

	IF @itemCodeOrName IS NOT NULL
		BEGIN
            SET @Query = CONCAT(@Query, ' AND (ITEM.Code LIKE ''%'' + @itemCodeOrName + ''%'' OR ITEM.Name LIKE ''%'' + @itemCodeOrName + ''%'')')
		END

	SET @Query = CONCAT(@Query, 'GROUP BY MONTH(INVOICE.Date),
											YEAR(INVOICE.Date),
											SalesmanId,
											CLIENT.TigerId,
											CLIENT.Code,
											CLIENT.Name,
											INVOICE.Firm,
                                            ITEM.Code,
											ITEM.Name,
											[LINE].ItemId) FACTQUERY
								  ON
									FACTQUERY.Year = USERPLAN.Year AND
									FACTQUERY.Month = USERPLAN.Month AND
									FACTQUERY.Firm = USERPLAN.Firm AND
									FACTQUERY.Salesman = USEREMPLOYEE.EmployeeId AND
									PLANITEMS.ItemId = FACTQUERY.ItemId
									WHERE
										(USERPLAN.UserId = @userId)')

    IF @years IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (FACTQUERY.[Year] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@years,''',',''','')))')
		END

	IF @months IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (USERPLAN.[Month] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@months,''',',''','')))')
		END

	IF @itemGroups IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (USERPLAN.ItemGroupId IN (SELECT LTRIM(Value) FROM F_SplitList(''',@itemGroups,''',',''','')))')
		END

	IF @planType = 1
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (USERPLAN.Quantity <> 0)')
		END

	IF @planType = 2
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (USERPLAN.Amount <> 0)')
		END

	SET @Query = CONCAT(@Query, ' GROUP BY ClientId, ClientCode, ClientName, USERPLAN.Month, USERPLAN.Year, FACTQUERY.ItemId, FACTQUERY.ItemCode, FACTQUERY.ItemName, ITEMGROUP.Name, ITEMGROUP.Code')

	PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@clientCodeNameOrEdino NVARCHAR(500),
											@clientSpecialCodes NVARCHAR(500),
											@itemCodeOrName NVARCHAR(500),
											@itemGroups NVARCHAR(500),
											@months NVARCHAR(500),
											@years NVARCHAR(500) NULL,
											@planType INT,
											@userId INT,
											@salesmanId INT,
											@currencyType SMALLINT',
									@firm=@firm,
									@clientCodeNameOrEdino=@clientCodeNameOrEdino,
                                    @clientSpecialCodes=@clientSpecialCodes,
									@itemCodeOrName=@itemCodeOrName,
									@itemGroups = @itemGroups,
									@months = @months,
									@years = @years,
									@planType = @planType,
									@userId = @userId,
									@salesmanId = @salesmanId,
									@currencyType = @currencyType
END

