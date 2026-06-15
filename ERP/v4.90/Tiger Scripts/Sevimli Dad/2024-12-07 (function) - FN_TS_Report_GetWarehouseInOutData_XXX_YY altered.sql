ALTER Function [dbo].[FN_TS_Report_GetWarehouseInOutData_XXX_YY](@warehouseNr smallint, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                select DATE_            AS Date,
                       FICHENO          AS FicheNo,
                       isnull(concat(round(PRICE.Amount ,2),' ',Code),'')         AS Specode,
                       round(PRICE.TotalPrice,2) AS Amount,
                       'AZN'            AS CurrencyCode,
                       case
                           when TRCODE <> 25 then TRCODE
                           when TRCODE = 25 and SOURCEINDEX = @warehouseNr then 26
                           when TRCODE = 25 and DESTINDEX = @warehouseNr then TRCODE
                           end          as 'OperationType',
                       LOGICALREF       AS FicheId,
                       case
                           when IOCODE = 1 then 1
                           when IOCODE = 3 then 0
                           when IOCODE = 2 and SOURCEINDEX = @warehouseNr then 0
                           when IOCODE = 2 and DESTINDEX = @warehouseNr then 1
                           end          as 'InOut'
                from LG_XXX_YY_STFICHE STFICHE WITH (NOLOCK)
				 left join (select STLINE.STFICHEREF                          AS STFICHEREF,
                           sum(StPrice.MinimumPrice * STLINE.AMOUNT ) AS TotalPrice,
						   sum(STLINE.AMOUNT) as Amount,
						   UNITLINE.CODE as Code
                    from LG_XXX_YY_STLINE STLINE WITH (NOLOCK)
					         INNER JOIN LG_XXX_ITEMS ITEM WITH (NOLOCK) ON ITEM.LOGICALREF = STLINE.STOCKREF
                            INNER JOIN LG_XXX_UNITSETL UNITLINE WITH (NOLOCK) ON UNITLINE.LOGICALREF =STLINE.UOMREF
                             left join (select distinct ItemId, MinimumPrice
                                        from (select distinct Prices.TigerItemId                                                                         as ItemId,
                                                              Price /Units.Convfact2                                                                                     as MinimumPrice,
                                                              row_number() over (partition by  Prices.TigerItemId order by BeginDate desc) as rw
                                              from TayqaSale..MD_ItemPrice Prices
                                                       join TayqaSale..MD_ItemUnit Units
                                                            on Prices.TigerItemId = Units.TigerItemId and
                                                               Units.TigerId = Prices.TigerItemUnitId and
                                                               Units.IsDeleted = 0 and
                                                               Units.Firm = Prices.Firm
                                              where Prices.IsDeleted = 0
                                                and Status = 0
                                                and BeginDate <= GETDATE()
                                                and EndDate >= GETDATE()) Prices
                                        where rw = 1) StPrice on StPrice.ItemId = STLINE.STOCKREF
                    where --STLINE.TRCODE = 25 and STLINE.IOCODE = 2 and
					  STLINE.DATE_ BETWEEN @beginDate AND @endDate and STLINE.DESTINDEX=@warehouseNr
                    group by STLINE.STFICHEREF,UNITLINE.CODE) PRICE ON PRICE.STFICHEREF = STFICHE.LOGICALREF
                WHERE TRCODE IN (11, 12, 13, 14, 25, 50, 51)
                  AND DATE_ between @beginDate AND @endDate
                  and (SOURCEINDEX = @warehouseNr or DESTINDEX = @warehouseNr)
            )



