ALTER Function [dbo].[FN_TS_Report_GetWarehouseInOutData_XXX_YY](@warehouseNr smallint, @beginDate datetime, @endDate datetime)
    RETURNS @T TABLE
               (
                   Date          datetime,
                   FicheNo       nvarchar(100),
                   Specode       nvarchar(100),
				   Amount		 float,
				   CurrencyCode  nvarchar(10),
                   OperationType int,
                   FicheId       int,
                   InOut         int
               )
    AS
    BEGIN

        -- Date: 27.06.2022 21:44
        -- Author: TayqaTech for TayqaSale platform ERP Reports (Kanan Mammadov)
        -- Description: Specode is replaced with the sum of prices in the transfer list


        -- Step 1: find division of the warehouse
        declare @divisionNr int = (select DivisionNr
                                   from TayqaSale..MD_Warehouse with (nolock)
                                   where Nr = @warehouseNr
                                     and Firm = 2)

        -- Step 2: Find group Id based on Division Nr
        declare @groupId int = (select GroupId
                                from TayqaSale..MD_ClientGroupInfo with (nolock)
                                where Firm = 2
                                  and GroupType = 1
                                  and cast(right(GroupCode, 3) as int) = @divisionNr
                                  and GroupCode <> 'Diger')


        -- Return query results
        insert into @T (Date, FicheNo, Specode, Amount, CurrencyCode, OperationType, FicheId, InOut)

select DATE_                            AS Date,
       case
           when @WarehouseNr = SOURCEINDEX then concat(STFICHE.FICHENO, ' - ', InWarehouse.Name)
           when @WarehouseNr = DESTINDEX then concat(STFICHE.FICHENO, ' - ', OutWarehouse.Name)
           else STFICHE.FICHENO end     as FicheNo,
       '' AS Specode, -- THIS IS THE TOTAL PRICE OF THE TRANSFER OPERATION,
       round(PRICE.TotalPrice,2)                             AS Amount,
       'AZN'                             AS CurrencyCode,
       case
           when TRCODE <> 25 then TRCODE
           when TRCODE = 25 and SOURCEINDEX = @warehouseNr then 26
           when TRCODE = 25 and DESTINDEX = @warehouseNr then TRCODE
           end                          AS OperationType,
       LOGICALREF                       AS FicheId,
       case
           when IOCODE = 1 then 0
           when IOCODE = 3 then 1
           when IOCODE = 2 and SOURCEINDEX = @warehouseNr then 1
           when IOCODE = 2 and DESTINDEX = @warehouseNr then 0
           end                          AS InOut

from LG_XXX_YY_STFICHE STFICHE WITH (NOLOCK)

         left join TayqaSale..MD_Warehouse InWarehouse with (nolock) on STFICHE.DESTINDEX = InWarehouse.Nr --and @WarehouseNr = STFICHE.DESTINDEX
         left join TayqaSale..MD_Warehouse OutWarehouse  with (nolock) on STFICHE.SOURCEINDEX = OutWarehouse.Nr --and @WarehouseNr = STFICHE.SOURCEINDEX
    -- Finding total amount for a fiche
         left join (select STLINE.STFICHEREF                          AS STFICHEREF,
                           sum(isnull(Price.MinimumPrice,StPrice.MinimumPrice) * STLINE.AMOUNT * UINFO2) AS TotalPrice

                    from LG_XXX_YY_STLINE STLINE WITH (NOLOCK)

                             -- Finding prices for items with minimum unit
                             left join (select ItemId, MinimumPrice
                                        from (select ClientGroupId                                                                              as ClientGroupId,
                                                     Prices.TigerItemId                                                                         as ItemId,
                                                     Prices.Price / Units.Convfact2                                                             as MinimumPrice,
                                                     row_number() over (partition by ClientGroupId, Prices.TigerItemId order by BeginDate desc) as rw -- ensures the latest price
                                              from TayqaSale..MD_ItemSpecificClientGroupPrice Prices with (nolock)
                                                       join TayqaSale..MD_ItemUnit Units with (nolock)
                                                            on Prices.TigerItemId = Units.TigerItemId and
                                                               Units.TigerId = Prices.TigerItemUnitId and
                                                               Units.IsDeleted = 0 and
                                                               Units.Firm = Prices.Firm
                                              where Units.Firm = 2
                                                and Prices.IsDeleted = 0
                                                and OperationMask like '11111%'
                                                and ClientGroupId = @groupId) Prices
                                        where rw = 1) Price on Price.ItemId = STLINE.STOCKREF
                             left join (select distinct ItemId, MinimumPrice
                                        from (select distinct Prices.TigerItemId                                                                         as ItemId,
                                                              Price /Units.Convfact2                                                                                     as MinimumPrice,
                                                              row_number() over (partition by  Prices.TigerItemId order by BeginDate desc) as rw
                                              from TayqaSale..MD_ItemPrice Prices with (nolock)
                                                       join TayqaSale..MD_ItemUnit Units with (nolock)
                                                            on Prices.TigerItemId = Units.TigerItemId and
                                                               Units.TigerId = Prices.TigerItemUnitId and
                                                               Units.IsDeleted = 0 and
                                                               Units.Firm = Prices.Firm
                                              where Units.Firm = 2
                                                and Prices.IsDeleted = 0
												and OperationMask like '11111%'
                                                and Status = 0
                                                and BeginDate <= GETDATE()
                                                and EndDate >= GETDATE()) Prices
                                        where rw = 1) StPrice on StPrice.ItemId = STLINE.STOCKREF
                    where STLINE.TRCODE = 25 and STLINE.IOCODE = 2 and
					  STLINE.DATE_ BETWEEN @beginDate AND @endDate
                    group by STLINE.STFICHEREF) PRICE ON PRICE.STFICHEREF = STFICHE.LOGICALREF

WHERE TRCODE IN (11, 12, 13, 14, 25, 50, 51)
  AND DATE_ between @beginDate AND @endDate
  and (SOURCEINDEX = @warehouseNr or DESTINDEX = @warehouseNr)

  

        return
    END

