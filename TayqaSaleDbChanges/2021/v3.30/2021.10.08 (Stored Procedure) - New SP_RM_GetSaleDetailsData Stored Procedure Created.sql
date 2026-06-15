/****** Object:  StoredProcedure [dbo].[SP_RM_GetSalePlanReportingDetailsDataForItemGroups]    Script Date: 10/8/2021 3:13:43 PM ******/
CREATE PROCEDURE [dbo].[SP_RM_GetSalePlanReportingDetailsDataForItemGroups](
											@firm SMALLINT =NULL,
											@clients NVARCHAR(500)= NULL,
											@items NVARCHAR(500) =NULL,
											@itemGroups NVARCHAR(500) =NULL,
											@months NVARCHAR(500) =NULL,
											@year INT= NULL,
											@planType INT =NULL,
											@userId INT =NULL,
											@salesmanId INT= NULL,
											@currencyType SMALLINT= NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
			SELECT ItemGroup.Id                          as ItemGroupId,
       ItemGroup.Code                        as ItemGroupCode,
       ItemGroup.Name                        as ItemGroupName,
       FactQuery.ItemId                         as ItemId,
       FactQuery.ItemCode                            as ItemCode,
       FactQuery.ItemName                            as ItemName,
       --UserPlan.Month                        as Month,
	   DATENAME(month, DATEADD(month, UserPlan.Month-1, CAST(''2021-01-01'' AS DATETIME)))	AS [Month],
       UserPlan.Year                         as Year,
       SUM(UserPlan.Quantity)                as PlanQuantity,
       SUM(UserPlan.Amount)                  as PlanAmount,
       ROUND(SUM(FactQuery.FactQuantity), 2) as FactQuantity,
       ROUND(SUM(FactQuery.FactAmount), 2)   as FactAmount,
       ROUND(SUM(FactQuery.FactQuantity) / IIF(SUM(UserPlan.Quantity) = 0, 1, SUM(UserPlan.Quantity)) * 100,
             2)                              as QuantityProportion,
       ROUND(SUM(FactQuery.FactAmount) / IIF(SUM(UserPlan.Amount) = 0, 1, SUM(UserPlan.Amount)) * 100,
             2)                              as AmountProportion,
       ROUND((SUM(FactQuery.FactQuantity) / IIF(SUM(UserPlan.Quantity) = 0, 1, SUM(UserPlan.Quantity)) * 100) -
             LAG(SUM(FactQuery.FactQuantity) / IIF(SUM(UserPlan.Quantity) = 0, 1, SUM(UserPlan.Quantity)) * 100) OVER (
                 PARTITION BY ItemGroup.Id ORDER BY ItemGroup.Id, FactQuery.ItemId, UserPlan.Month, UserPlan.Year),
             2)                              as QuantityTrend,
       ROUND((SUM(FactQuery.FactAmount) / IIF(SUM(UserPlan.Amount) = 0, 1, SUM(UserPlan.Amount)) * 100) -
             LAG(SUM(FactQuery.FactAmount) / IIF(SUM(UserPlan.Amount) = 0, 1, SUM(UserPlan.Amount)) * 100) OVER (
                 PARTITION BY ItemGroup.Id ORDER BY ItemGroup.Id, FactQuery.ItemId, UserPlan.Month, UserPlan.Year),
             2)                              as AmountTrend
FROM MD_ItemGroupPlanForUser UserPlan
         WITH (NOLOCK)
         JOIN MD_ItemGroupItemMapping PlanItems WITH (NOLOCK)
              ON UserPlan.ItemGroupId = PlanItems.GroupId AND UserPlan.Firm = PlanItems.Firm and UserPlan.[Year]=@year
         --JOIN MD_Item Items WITH (NOLOCK) on Items.TigerId = PlanItems.ItemId AND Items.Firm = PlanItems.Firm
        join MD_Firm firm on PlanItems.Firm = @firm and PlanItems.Firm = Firm.Nr and firm.LocalCurrencyTypeId = @currencyType
         JOIN MD_ItemGroup ItemGroup WITH (NOLOCK) on ItemGroup.Id = UserPlan.ItemGroupId
         JOIN UIM_UserEmployeeMapping UserEmployee
    WITH (NOLOCK) on UserPlan.Firm = UserEmployee.Firm AND UserEmployee.UserId = UserPlan.UserId and UserEmployee.UserId = @userId -- and UserEmployee.[EmployeeId] = @salesmanId
         JOIN(SELECT MONTH(Invoice.Date) AS Month,
                      YEAR(Invoice.Date)  AS Year,
                      Invoice.Firm        AS Firm,
                      Line.ItemId,
					  Items.Name			AS ItemName,
					  Items.Code			AS ItemCode,
                      ROUND(SUM(IIF(Invoice.Type = 4, (Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                            SUM(IIF(Invoice.Type = 2, (Quantity * Line.Price) - Line.DiscountAmount, 0)),
                            2)            AS FactAmount,
                      ROUND(
                                  SUM(IIF(Invoice.Type = 4, (Unit.Convfact2 / Unit.Convfact1) * Quantity, 0)) -
                                  SUM(IIF(Invoice.Type = 2, (Unit.Convfact2 / Unit.Convfact1) * Quantity, 0)),
                                  2)      AS FactQuantity
               FROM ERP_Invoice Invoice WITH (NOLOCK)
                        JOIN ERP_InvoiceLine Line WITH (NOLOCK) ON Line.InvoiceId = Invoice.Id AND Invoice.SalesmanId = @salesmanId
						JOIN MD_Item Items WITH (NOLOCK) on Items.TigerId = Line.ItemId AND Items.Firm = Invoice.Firm AND (Items.IsDeleted IS NULL OR Items.IsDeleted = 0) AND Items.Status = 0
                        JOIN MD_ItemUnit Unit WITH (NOLOCK)
                             on Unit.Code = Line.ItemUnitCode and Line.ItemId = Unit.TigerItemId and Unit.Firm = Items.Firm and Unit.IsDeleted = 0
                        JOIN MD_Client Client WITH (NOLOCK)
                             ON Client.TigerId = Invoice.ClientId and Client.Firm = Invoice.Firm
               WHERE Invoice.IsDeleted = 0
                 AND IsCancelled = 0 AND Line.LineType<>1
                 and (Client.IsDeleted is null or Client.IsDeleted=0) and Client.[Status]=0'

    IF @clients IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (Client.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@clients,''',',''','')))')
		END

	IF @items IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (Items.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@items,''',',''','')))')
		END

	SET @Query = CONCAT(@Query, ' GROUP BY MONTH(Invoice.Date), YEAR(Invoice.Date), Invoice.Firm, Line.ItemId, Items.Name, Items.Code) FactQuery
              ON FactQuery.Year = UserPlan.Year AND FactQuery.Month = UserPlan.Month AND
                 FactQuery.Firm = UserPlan.Firm AND
                 PlanItems.ItemId = FactQuery.ItemId
                 where
                 -- (Items.IsDeleted is null or Items.IsDeleted = 0) and Items.Status=0
				 1=1')

	--IF @items IS NOT NULL
	--	BEGIN
	--		SET @Query = CONCAT(@Query, ' AND (Items.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@items,''',',''','')))')
	--	END

	IF @months IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (USERPLAN.[Month] IN (SELECT LTRIM(Value) FROM F_SplitList(''',@months,''',',''','')))')
		END

	IF @itemGroups IS NOT NULL
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (ItemGroup.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''',@itemGroups,''',',''','')))')
		END

	IF @planType = 1
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (UserPlan.Quantity <> 0)')
		END

	IF @planType = 2
		BEGIN
			SET @Query = CONCAT(@Query, ' AND (UserPlan.Amount <> 0)')
		END

	SET @Query = CONCAT(@Query, 'group by ItemGroup.Id, ItemGroup.Code, ItemGroup.Name, UserPlan.Month, UserPlan.Year, FactQuery.ItemId, FactQuery.ItemCode, FactQuery.ItemName')

	PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@clients NVARCHAR(500),
											@items NVARCHAR(500),
											@itemGroups NVARCHAR(500),
											@months NVARCHAR(500),
											@year INT,
											@planType INT,
											@userId INT,
											@salesmanId INT,
											@currencyType SMALLINT',
									@firm=@firm,
									@clients=@clients,
									@items=@items,
									@itemGroups = @itemGroups,
									@months = @months,
									@year = @year,
									@planType = @planType,
									@userId = @userId,
									@salesmanId = @salesmanId,
									@currencyType = @currencyType
END
