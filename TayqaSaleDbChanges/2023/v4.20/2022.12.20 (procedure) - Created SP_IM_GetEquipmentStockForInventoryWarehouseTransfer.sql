create Procedure [dbo].[SP_IM_GetEquipmentStockForInventoryWarehouseTransfer] @firm smallint,
                                                                              @itemNameCode nvarchar(max),
                                                                              @groupCode nvarchar(max),
                                                                              @specodes nvarchar(max),
                                                                              @sorting nvarchar(max),
                                                                              @fromDivision smallint,
                                                                              @fromWarehouse int,
                                                                              @toDivision smallint,
                                                                              @toWarehouse int,
                                                                              @receiverUserId int,
                                                                              @skipCount int,
                                                                              @maxResultCount int,
                                                                              @ignoredTigerIds nvarchar(max)
AS
BEGIN

-- Author: TayqaTech for TayqaSale (Kanan Mammadov)
-- Date: 17.12.2022
-- Query: returns the stock info for selected warehouse in transfer planning screen

    declare @Query nvarchar(max)

    set @Query = '
with Equipments as (select Items.Firm as Firm, Items.TigerId as TigerId, Items.Name as ItemName, Items.Code as ItemCode, count(Equipment.Id) as Count
                    from IM_Inventory Equipment with (nolock)
                             join MD_Item Items with (nolock) on Items.TigerId = Equipment.TigerId and Items.Firm = Equipment.Firm and Items.IsDeleted = 0
                             left join IM_StaticContent Content with (nolock) on Content.Id = Equipment.StateId and Content.IsActive = 1 and Items.IsDeleted = 0
                    where Equipment.Status = 1 
					and Equipment.Firm = @firm
					and Equipment.WarehouseNr = @fromWarehouse
					and Equipment.DivisionNr = @fromDivision '

    if @itemNameCode is not null set @Query = CONCAT(@Query, ' and (Items.Code like ''%''+@itemNameCode+''%'' or Items.Name like ''%''+@itemNameCode+''%'')')

    if @groupCode is not null set @Query = CONCAT(@Query, ' and (Items.GroupCode like ''%''+@groupCode+''%'' or Items.GroupName like ''%''+@groupCode+''%'')')

    if @specodes is not null
        set @Query = concat(@Query,
                            ' and (Items.SpecialCode like ''%''+@specodes+''%'' or Items.SpecialCode2 like ''%''+@specodes+''%''  or Items.SpecialCode3 like ''%''+@specodes+''%'' or Items.SpecialCode4 like ''%''+@specodes+''%'' or
                            Items.SpecialCode5 like ''%''+@specodes+''%'')')

    if @ignoredTigerIds is not null
        set @Query = concat(@Query, ' AND (Items.TigerId NOT IN (SELECT LTRIM(Value) FROM F_SplitList(''', @ignoredTigerIds, ''',', ''','')))')


    set @Query = concat(@Query,
                        ' group by Items.Firm, Items.TigerId, Items.Name, Items.Code),

                             Reserved as (select ItemTigerId, Firm, count(*) as Count
                                          from IM_InventoryDemand with (nolock)
                                          where DemandType = 1
                                            and DemandStatus in (0, 1)
                                            and Reserved = 1
											and Warehouse = @fromWarehouse
                                          group by ItemTigerId, Firm),

                             Transfers as (select Lines.ItemId, Package.Firm , sum(Lines.SelectedCount) as Count
                                            from IM_WarehouseTransfer Package with (nolock)
                                                    join IM_WarehouseTransferLine Lines with (nolock) on Lines.WarehouseTransferId = Package.Id
                                            where --Package.IsActive = 1 and 
											Package.IsDeleted = 0
                                            and Package.Status = 0
                                            and Package.FromWarehouse = @fromWarehouse
                                            group by Lines.ItemId, Package.Firm),

                             Result as (

                                select Equipments.TigerId as ItemId,
                                       Equipments.ItemCode,
                                       Equipments.ItemName,
                                       Equipments.Count - isnull(Reserved.Count, 0) - isnull(Transfers.Count, 0)              as AvailableCount,
                                       count(Equipments.TigerId) over () as TotalRecordCount
                                from Equipments
                                         left join Reserved on Equipments.TigerId = Reserved.ItemTigerId and Equipments.Firm = Reserved.Firm
                                         left join Transfers on Equipments.TigerId = Transfers.ItemId and Equipments.Firm = Transfers.Firm
                                where Equipments.Count - isnull(Reserved.Count, 0) - isnull(Transfers.Count, 0) > 0)

                                select * from Result
                                order by ' + @sorting + '
		offset @skipCount rows 
		fetch next @maxResultCount rows only
')

    print @Query

    exec sp_executesql @Query, N'
			@firm smallint, 
			@itemNameCode nvarchar(max), 
			@groupCode nvarchar(max), 
			@specodes nvarchar(max),
			@sorting nvarchar(max),
			@fromDivision smallint,
			@fromWarehouse int,
			@toDivision smallint,
			@toWarehouse int,
			@receiverUserId int,
			@skipCount int,
			@maxResultCount int',
         @firm = @firm,
         @itemNameCode = @itemNameCode,
         @groupCode = @groupCode,
         @specodes= @specodes,
         @sorting =@sorting,
         @fromDivision =@fromDivision,
         @fromWarehouse =@fromWarehouse,
         @toDivision=@toDivision,
         @toWarehouse =@toWarehouse,
         @receiverUserId =@receiverUserId,
         @skipCount =@skipCount,
         @maxResultCount =@maxResultCount


END;