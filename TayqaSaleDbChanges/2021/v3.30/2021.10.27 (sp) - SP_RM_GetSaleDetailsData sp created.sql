CREATE  PROCEDURE [dbo].[SP_RM_GetSaleDetailsData](
    @firm SMALLINT =NULL,
    @users NVARCHAR(500)= NULL,
    @currentUser INT =NULL,
    @months NVARCHAR(500) =NULL,
    @years NVARCHAR(500)= NULL,
    @itemGroups NVARCHAR(500)= NULL,
    @clients NVARCHAR(500)= NULL,
    @items NVARCHAR(500)= NULL,
	@forAmount bit= null)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

	IF @forAmount = 1
		SET @Query =
            '
			select
				Items.TigerId												as ItemId,
				ItemGroupItems.GroupId										as ItemGroupId,
				ItemGroupItems.Firm											as Firm,
				Items.Name													as ItemName,
				Items.Code													as ItemCode,
			DATENAME(month, DATEADD(month, MONTH(Invoice.[Date]) - 1, CAST(''2021-01-01'' AS DATETIME))) as [Month],
			ROUND(SUM(IIF(Invoice.Type = 4 and Line.LineType = 0, (Quantity * Line.Price) - Line.DiscountAmount, 0)) -
						 SUM(IIF(Invoice.Type = 2 and Line.LineType = 0, (Quantity * Line.Price) - Line.DiscountAmount, 0)),
						 2) AS AmountOrQuantity
			from MD_ItemGroupItemMapping ItemGroupItems
			join MD_Item Items with (nolock) on Items.TigerId = ItemGroupItems.ItemId and ItemGroupItems.Firm = Items.Firm and Items.Firm = @firm and (Items.IsDeleted is null or Items.IsDeleted = 0) and Items.[Status] = 0-- and (@itemGroup IS NULL OR ItemGroupItems.GroupId = @itemGroup)
			join ERP_InvoiceLine Line with (nolock) on Line.ItemId = Items.TigerId
			join ERP_Invoice Invoice with (nolock) on Invoice.Id = Line.InvoiceId and Invoice.Firm = Items.Firm and Invoice.IsDeleted = 0 and Invoice.IsCancelled = 0 --and YEAR(Invoice.[Date])=@year
			join MD_Client Clients with (nolock) on Invoice.ClientId = Clients.TigerId and Invoice.Firm = Clients.Firm and (Clients.IsDeleted is null or Clients.IsDeleted = 0) and Clients.[Status] = 0
			join MD_Firm Firm with (nolock) on Firm.Nr = Items.Firm
			join MD_Currency Currency with (nolock) on Currency.Type = Firm.LocalCurrencyTypeId and Currency.Firm = Firm.Nr
		
		where Invoice.SalesmanId IN (SELECT EmployeeId from UIM_UserEmployeeMapping UserEmployee with (nolock) join 
									 F_GetPermittedUsers(@currentUser) PermittedUser on PermittedUser.UserId = UserEmployee.UserId) '
	ELSE
		SET @Query =
            'select
					Items.TigerId												as ItemId,
					ItemGroupItems.Firm											as Firm,
					ItemGroupItems.GroupId										as ItemGroupId,
					Items.Name													as ItemName,
					Items.Code													as ItemCode,
					DATENAME(month, DATEADD(month, MONTH(Invoice.[Date]) - 1,
										   CAST(''2021-01-01'' AS DATETIME)))	as [Month],
				   YEAR(Invoice.[Date])											as [Year],
				--    ROUND(SUM((ItemUnit.Convfact2 / IIF(ItemUnit.Convfact1 = 0, 1, ItemUnit.Convfact1)) * Line.Quantity),
				-- 		 2)														as AmountOrQuantity

                ROUND(SUM(IIF(Invoice.Type = 4 and Line.LineType = 0,
							 (ItemUnit.Convfact2 / IIF(ItemUnit.Convfact1 = 0, 1, ItemUnit.Convfact1)) * Line.Quantity, 0)) -
					 SUM(IIF(Invoice.Type = 2 and Line.LineType = 0,
							 (ItemUnit.Convfact2 / IIF(ItemUnit.Convfact1 = 0, 1, ItemUnit.Convfact1)) * Line.Quantity, 0)),
					 2)                                               as AmountOrQuantity

			from MD_ItemGroupItemMapping ItemGroupItems with (nolock)-- on ItemGroupItems.GroupId = ItemGroup.Id
					 join MD_Item Items with (nolock) on Items.TigerId = ItemGroupItems.ItemId and ItemGroupItems.Firm = Items.Firm and (Items.IsDeleted is null or Items.IsDeleted = 0) and Items.Firm=@firm and Items.[Status]=0 and Items.Firm=@firm -- and (@itemGroup IS NULL OR ItemGroupItems.GroupId = @itemGroup)
					 join ERP_InvoiceLine Line with (nolock) on Line.ItemId = Items.TigerId
					 join ERP_Invoice Invoice with (nolock) on Invoice.Id = Line.InvoiceId and Invoice.Firm = Items.Firm and Invoice.IsDeleted=0 and Invoice.IsCancelled=0 --and YEAR(Invoice.[Date])=@year
					 join MD_Client Clients with (nolock) on Invoice.ClientId = Clients.TigerId and Invoice.Firm = Clients.Firm and (Clients.IsDeleted is null or Clients.IsDeleted = 0) and Clients.[Status] = 0
					 join MD_ItemUnit ItemUnit with (nolock) on ItemUnit.Firm = Items.Firm and ItemUnit.Code = Line.ItemUnitCode and
																ItemUnit.TigerItemId = Line.ItemId and ItemUnit.TigerItemId = Items.TigerId and ItemUnit.IsDeleted = 0
					 left join MD_ItemUnit MainUnit with (nolock) on MainUnit.TigerItemId = Items.TigerId  and MainUnit.IsMainUnit = 1 and MainUnit.Firm = Items.Firm and MainUnit.IsDeleted = 0
			
			where Invoice.SalesmanId IN (SELECT EmployeeId from UIM_UserEmployeeMapping UserEmployee with (nolock) join 
									 F_GetPermittedUsers(@currentUser) PermittedUser on PermittedUser.UserId = UserEmployee.UserId)'

	IF @users IS NOT NULL
			SET @Query =
					CONCAT(@Query, ' AND (Invoice.SalesmanId in (select EmployeeId from UIM_UserEmployeeMapping 
					where UserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @users,''',', ''', ''))))')

	IF @items IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (Items.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @items, ''',', ''','')))')

    IF @clients IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (Clients.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @clients, ''',', ''','')))')

    IF @months IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (MONTH(Invoice.[Date]) IN (SELECT LTRIM(Value) FROM F_SplitList(''', @months, ''',', ''','')))')

	IF @itemGroups IS NOT NULL
			SET @Query = CONCAT(@Query, ' AND (ItemGroupItems.GroupId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @itemGroups, ''',', ''','')))')

	IF @years IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (YEAR(Invoice.[Date]) IN (SELECT LTRIM(Value) FROM F_SplitList(''', @years, ''',', ''','')))')

    SET @Query = CONCAT(@Query, ' group by ItemGroupItems.GroupId, YEAR(Invoice.[Date]), MONTH(Invoice.[Date]), ItemGroupItems.ItemId, Items.Name, Items.Code, Items.TigerId, ItemGroupItems.Firm')

    PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@users NVARCHAR(500),
											@currentUser INT,
											@months NVARCHAR(500),
											@years  NVARCHAR(500),
											@itemGroups NVARCHAR(500),
											@clients NVARCHAR(500),
											@items NVARCHAR(500),
											@forAmount BIT',
         @firm=@firm,
         @users=@users,
         @currentUser=@currentUser,
         @months = @months,
         @years = @years,
         @itemGroups = @itemGroups,
         @clients = @clients,
         @items = @items,
		 @forAmount = @forAmount
END
