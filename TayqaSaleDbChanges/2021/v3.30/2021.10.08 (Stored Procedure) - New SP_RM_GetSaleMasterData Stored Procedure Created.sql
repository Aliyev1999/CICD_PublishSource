/****** Object:  StoredProcedure [dbo].[SP_RM_GetSaleMasterData]    Script Date: 10/8/2021 3:19:24 PM ******/
CREATE  PROCEDURE [dbo].[SP_RM_GetSaleMasterData](
    @firm SMALLINT =NULL,
    @users NVARCHAR(500)= NULL,
    @currentUser INT= NULL,
    @months NVARCHAR(500)= NULL,
    @years NVARCHAR(500)= NULL,
    @itemGroups NVARCHAR(500)= NULL,
    @clients NVARCHAR(500)= NULL,
    @items NVARCHAR(500)= NULL,
    @forAmount bit =null)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    IF @forAmount = 0
        SET @Query =
                '
		select ItemGroup.Id                                           as ItemGroupId,
			   ItemGroup.Name                                         as ItemGroupName,
			   ItemGroup.Code                                         as ItemGroupCode,
			   Items.Firm                                             as FirmNr,
			   Firm.Name                                              as FirmName,
			   MainUnit.Code                                          as CurrencyOrItemUnitCode,
			   DATENAME(month, DATEADD(month, MONTH(Invoice.[Date]) - 1,
									   CAST(''20210101'' AS DATETIME))) as [Month],
			   YEAR(Invoice.[Date])                                   as [Year],
			   ROUND(SUM(IIF(Invoice.Type = 4 and Line.LineType = 0,
							 (ItemUnit.Convfact2 / IIF(ItemUnit.Convfact1 = 0, 1, ItemUnit.Convfact1)) * Line.Quantity, 0)) -
					 SUM(IIF(Invoice.Type = 2 and Line.LineType = 0,
							 (ItemUnit.Convfact2 / IIF(ItemUnit.Convfact1 = 0, 1, ItemUnit.Convfact1)) * Line.Quantity, 0)),
					 2)                                               as AmountOrQuantity
		from MD_ItemGroup ItemGroup with (nolock)
				 join MD_ItemGroupItemMapping ItemGroupItems with (nolock) on ItemGroupItems.GroupId = ItemGroup.Id
				 join MD_Item Items with (nolock) on Items.TigerId = ItemGroupItems.ItemId and ItemGroupItems.Firm = Items.Firm and
						 (Items.IsDeleted is null or Items.IsDeleted = 0) and Items.Firm = 9 and Items.[Status] = 0
				 join ERP_InvoiceLine Line with (nolock) on Line.ItemId = Items.TigerId
				 join ERP_Invoice Invoice with (nolock) on Invoice.Id = Line.InvoiceId and Invoice.Firm = Items.Firm and Invoice.IsDeleted = 0 and Invoice.IsCancelled = 0
				 join MD_Client Clients with (nolock) on Invoice.ClientId = Clients.TigerId and Invoice.Firm = Clients.Firm and
														 (Clients.IsDeleted is null or Clients.IsDeleted = 0) and Clients.[Status] = 0
				 join MD_Firm Firm with (nolock) on Firm.Nr = Items.Firm
				 join MD_ItemUnit ItemUnit with (nolock) on ItemUnit.Firm = Items.Firm and ItemUnit.Code = Line.ItemUnitCode and
															ItemUnit.TigerItemId = Line.ItemId and ItemUnit.TigerItemId = Items.TigerId and ItemUnit.IsDeleted = 0 
				 left join MD_ItemUnit MainUnit with (nolock) on MainUnit.TigerItemId = Items.TigerId and MainUnit.IsMainUnit = 1 and MainUnit.Firm = Items.Firm and MainUnit.IsDeleted = 0 
				 join (SELECT distinct EmployeeId from UIM_UserEmployeeMapping UserEmployee with (nolock) join 
									 F_GetPermittedUsers(2) PermittedUser on PermittedUser.UserId = UserEmployee.UserId
									 where UserEmployee.Firm = @firm
									 ) Users on Users.EmployeeId = Invoice.SalesmanId '
    ELSE
        SET @Query =
                '
                select ItemGroup.Id                                                                               as ItemGroupId,
                       ItemGroup.Name                                                                             as ItemGroupName,
                       ItemGroup.Code                                                                             as ItemGroupCode,
                       Items.Firm                                                                                 as FirmNr,
                       Firm.Name                                                                                  as FirmName,
                       Currency.Code                                                                              as CurrencyOrItemUnitCode,
                       DATENAME(month, DATEADD(month, MONTH(Invoice.[Date]) - 1, CAST(''2021-01-01'' AS DATETIME))) as [Month],
                       YEAR(Invoice.[Date])                                                                       as [Year],
                       ROUND(SUM(IIF(Invoice.Type = 4 and Line.LineType = 0, (Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                             SUM(IIF(Invoice.Type = 2 and Line.LineType = 0, (Quantity * Line.Price) - Line.DiscountAmount, 0)),
                             2)                                                                                   as AmountOrQuantity
                from MD_ItemGroup ItemGroup with (nolock)
                         join MD_ItemGroupItemMapping ItemGroupItems with (nolock) on ItemGroupItems.GroupId = ItemGroup.Id
                         join MD_Item Items with (nolock) on Items.TigerId = ItemGroupItems.ItemId and ItemGroupItems.Firm = Items.Firm and Items.Firm = @firm and (Items.IsDeleted is null or Items.IsDeleted = 0) and Items.[Status] = 0
                         join ERP_InvoiceLine Line with (nolock) on Line.ItemId = Items.TigerId
                         join ERP_Invoice Invoice with (nolock) on Invoice.Id = Line.InvoiceId and Invoice.Firm = Items.Firm and Invoice.IsDeleted = 0 and Invoice.IsCancelled = 0
                         join MD_Client Clients with (nolock) on Invoice.ClientId = Clients.TigerId and Invoice.Firm = Clients.Firm and (Clients.IsDeleted is null or Clients.IsDeleted = 0) and Clients.[Status] = 0
                         join MD_Firm Firm with (nolock) on Firm.Nr = Items.Firm
                         join MD_Currency Currency with (nolock) on Currency.Type = Firm.LocalCurrencyTypeId and Currency.Firm = Firm.Nr
                         where Invoice.SalesmanId IN (SELECT EmployeeId from UIM_UserEmployeeMapping UserEmployee with (nolock) join 
									 F_GetPermittedUsers(@currentUser) PermittedUser on PermittedUser.UserId = UserEmployee.UserId)'


IF @users IS NOT NULL
        SET @Query =
                CONCAT(@Query, ' AND (Invoice.SalesmanId in (select EmployeeId from UIM_UserEmployeeMapping 
				where UserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @users,''',', ''', ''))))')

    IF @itemGroups IS NOT NULL
        SET @Query =
                CONCAT(@Query, ' AND (ItemGroup.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @itemGroups, ''',',
                       ''','')))')

    IF @items IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Items.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @items, ''',',
                            ''','')))')

    IF @clients IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Clients.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @clients, ''',',
                            ''','')))')

    IF @years IS NOT NULL
        SET @Query =
                CONCAT(@Query, ' AND (YEAR(Invoice.[Date]) IN (SELECT LTRIM(Value) FROM F_SplitList(''', @years, ''',',
                       ''','')))')

    IF @months IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (MONTH(Invoice.[Date]) IN (SELECT LTRIM(Value) FROM F_SplitList(''', @months,
                            ''',', ''','')))')

    IF @forAmount = 1
        SET @Query = CONCAT(@Query,
                            ' group by ItemGroup.Id, ItemGroup.Name, ItemGroup.Code, Items.Firm, Firm.Name, Currency.Code, Month(Invoice.[Date]), YEAR(Invoice.[Date])')
    ELSE
        SET @Query = CONCAT(@Query,
                            ' group by ItemGroup.Id, ItemGroup.Name, ItemGroup.Code, Items.Firm, Firm.Name, MONTH(Invoice.[Date]), YEAR(Invoice.[Date]), MainUnit.Code')

    PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@users NVARCHAR(500),
											@currentUser INT,
											@months NVARCHAR(500),
											@years NVARCHAR(500),
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
