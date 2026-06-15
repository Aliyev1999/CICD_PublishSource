/****** Object:  StoredProcedure [dbo].[SP_RM_GetSalePlanReportMasterData]    Script Date: 10/8/2021 3:09:46 PM ******/

CREATE PROCEDURE [dbo].[SP_RM_GetSalePlanReportMasterData](
    @firm SMALLINT =NULL,
    @users NVARCHAR(500)= NULL,
    @itemGroups NVARCHAR(500)= NULL,
    @clients NVARCHAR(500)= NULL,
    @items NVARCHAR(500)= NULL,
    @months NVARCHAR(500) =NULL,
    @years NVARCHAR(500) =NULL,
    @currentUser INT =NULL,
    @groupingType INT =null)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
SELECT Users.UserName                                                             AS UserName,
       Users.Id                                                                   AS UserId,
       Salesman.[Name]                                                            AS SalesmanName,
       Salesman.TigerId                                                           AS SalesmanId,
       Firm.[Name]                                                                AS FirmName,
       Firm.Nr                                                                    AS FirmNr,
       DATENAME(MONTH,
                DATEADD(month, UserPlan.[Month] - 1, CAST(''2021-01-01'' AS DATE))) AS [Month],
       UserPlan.[Year]                                                            AS [Year],
       Firm.LocalCurrencyTypeId                                                   AS CurrencyId,
       PlanCurrency.Code                                                          AS CurrencyCode,
       sum(UserPlan.Quantity)                                                     AS PlanQuantity,
       sum(UserPlan.Amount)                                                       AS PlanAmount,
       sum(FactQuery.FactQuantity)                                                     AS FactQuantity,
       sum(FactQuery.FactAmount)                                                       AS FactAmount,
       round(sum(FactQuery.FactQuantity) / iif(sum(UserPlan.Quantity) = 0, 1, sum(UserPlan.Quantity)) * 100,
             2)                                                                   AS QuantityProportion,
       round(sum(FactQuery.FactAmount) / iif(sum(UserPlan.Amount) = 0, 1, sum(UserPlan.Amount)) * 100,
             2)                                                                   AS AmountProportion,
       round((sum(FactQuery.FactAmount) / iif(sum(UserPlan.Quantity) = 0, 1, sum(UserPlan.Quantity)) * 100) -
             lag(round(sum(FactQuery.FactQuantity) / iif(sum(UserPlan.Quantity) = 0, 1, sum(UserPlan.Quantity)) * 100, 2))
                 OVER (order by Users.UserName, Salesman.[Name], Salesman.TigerId, Firm.[Name], UserPlan.Month, UserPlan.Year),
             2)                                                                   AS QuantityTrend,
       round((sum(FactQuery.FactAmount) / iif(sum(UserPlan.Amount) = 0, 1, sum(UserPlan.Amount)) * 100) -
             lag(sum(FactQuery.FactAmount) / iif(sum(UserPlan.Amount) = 0, 1, sum(UserPlan.Amount)) * 100)
                 OVER (order by Users.UserName, Salesman.[Name], Salesman.TigerId, Firm.[Name], UserPlan.Month, UserPlan.Year),
             2)                                                                   AS AmountTrend
FROM MD_ItemGroupPlanForUser UserPlan with (nolock)
         join MD_ItemGroup ItemGroup with (nolock) on ItemGroup.Id = UserPlan.ItemGroupId
         join UIM_UserEmployeeMapping UserEmployee with (nolock)
              on UserEmployee.UserId = UserPlan.UserId and UserEmployee.Firm = UserPlan.Firm
         join MD_Salesman Salesman with (nolock)
              on Salesman.TigerId = UserEmployee.EmployeeId and Salesman.Firm = UserEmployee.Firm
         join AbpUsers Users with (nolock) on Users.Id = UserPlan.UserId and UserEmployee.UserId = Users.Id
         join F_GetPermittedUsers(@currentUser) PermittedUsers on PermittedUsers.UserId = Users.Id and UserEmployee.UserId = Users.Id
         join MD_Firm Firm with (nolock) on Firm.Nr = Salesman.Firm and Firm.IsActive = 1
         join MD_Currency PlanCurrency with (nolock)
              on PlanCurrency.Type = Firm.LocalCurrencyTypeId and PlanCurrency.Firm = Firm.Nr
         left join (SELECT MONTH(Invoice.[Date]) AS [Month],
                           YEAR(Invoice.[Date])  AS [Year],
                           SalesmanId            AS Salesman,
                           Invoice.Firm          AS Firm,
						   ItemMapping.GroupId   as ItemGroup,
                           round(sum(iif(Invoice.[Type] = 4, (Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                                 sum(iif(Invoice.[Type] = 2, (Quantity * Line.Price) - Line.DiscountAmount, 0)),
                                 2)              AS FactAmount,
                           round(sum(iif(Invoice.[Type] = 4, (InvoiceUnit.Convfact2 / InvoiceUnit.Convfact1) * Line.Quantity, 0)) -
                                 sum(iif(Invoice.[Type] = 2, (InvoiceUnit.Convfact2 / InvoiceUnit.Convfact1) * Line.Quantity, 0)),
                                 2)              AS FactQuantity
                    FROM ERP_Invoice Invoice with (nolock)
                             join ERP_InvoiceLine Line with (nolock) ON Line.InvoiceId = Invoice.Id
                             join MD_Item Item with (nolock) ON Line.ItemId = Item.TigerId AND Item.Firm = Invoice.Firm
                             join MD_ItemGroupItemMapping ItemMapping with (nolock) on ItemMapping.ItemId = Item.TigerId and ItemMapping.Firm = Item.Firm
                             join MD_Client Client with (nolock)
                                  ON Invoice.ClientId = Client.TigerId AND Invoice.Firm = Client.Firm
                             join MD_ItemUnit InvoiceUnit with (nolock)
                                  ON InvoiceUnit.Code = Line.ItemUnitCode AND Line.ItemId = InvoiceUnit.TigerItemId and InvoiceUnit.Firm=Item.Firm
                    WHERE Invoice.IsDeleted = 0 AND IsCancelled = 0 AND [Line].LineType<>1'


    IF @items IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Item.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @items, ''',',''','')))')

    IF @clients IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Client.[Code] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @clients, ''',',''','')))')


    SET @Query = CONCAT(@Query, ' GROUP BY MONTH(Invoice.[Date]),
                            YEAR(Invoice.[Date]),
                            SalesmanId,
                            Invoice.Firm,
							ItemMapping.GroupId) FactQuery
                            on FactQuery.Month = UserPlan.Month and FactQuery.Year = UserPlan.Year and
                            FactQuery.Salesman = UserEmployee.EmployeeId and FactQuery.ItemGroup = UserPlan.ItemGroupId
                             where 1=1')

    IF @firm IS NOT NULL
        SET @Query = CONCAT(@Query, 'AND (UserPlan.Firm=@firm)')

    IF @users IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (UserPlan.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @users, ''',',''', '')))')

    IF @months IS NOT NULL
        SET @Query =
                CONCAT(@Query, ' AND (UserPlan.[Month] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @months, ''',',''','')))')

    IF @years IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (UserPlan.[Year] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @years, ''',',''','')))')

--
    IF @itemGroups IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (ItemGroup.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @itemGroups, ''',',''','')))')

    IF @groupingType = 1
        SET @Query = CONCAT(@Query, ' AND (UserPlan.Quantity<>0)')

    IF @groupingType = 2
        SET @Query = CONCAT(@Query, ' AND (UserPlan.Amount<>0)')

    SET @Query = CONCAT(@Query, ' group by Users.UserName, Users.Id, Salesman.[Name], Salesman.TigerId, Firm.[Name], Firm.Nr, UserPlan.[Year], UserPlan.[Month],
                                    Firm.LocalCurrencyTypeId, PlanCurrency.Code')

    PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@users NVARCHAR(500),
											@itemGroups NVARCHAR(500),
											@clients NVARCHAR(500),
											@items NVARCHAR(500),
											@months NVARCHAR(500),
											@years  NVARCHAR(500),
											@currentUser INT,
											@groupingType INT',
         @firm=@firm,
         @users=@users,
         @itemGroups = @itemGroups,
         @clients = @clients,
         @items = @items,
         @months = @months,
         @years = @years,
         @currentUser=@currentUser,
         @groupingType=@groupingType
END
