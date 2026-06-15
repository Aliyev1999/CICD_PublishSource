CREATE procedure [dbo].[SP_IM_GetInventoryWarehouseTransferEquipments](@warehouseTransferIds nvarchar(max), @firms nvarchar(max),
                                                                      @fromWarehouses nvarchar(max) null, @fromDivisions nvarchar(max) null)
as
begin

	declare @Query nvarchar(max) = '
	declare @table table (
	WarehouseTransferId int, 
	TigerId bigint, 
	ItemCode nvarchar(1000),
	ItemName nvarchar(1000),
	SelectedCount int,
	FromDivision smallint,
	FromWarehouse smallint,
	InventoryCount int
	)
insert into @table (WarehouseTransferId,TigerId,ItemCode,ItemName,SelectedCount,FromDivision,FromWarehouse,InventoryCount)
select Packages.Id                    as WarehouseTransferId,
       Items.TigerId                  as TigerId,
       Items.Code                     as ItemCode,
       Items.Name                     as ItemName,
       Lines.SelectedCount            as SelectedCount,
       FromDivision                   as FromDivision,
       FromWarehouse                  as FromWarehouse,
       count(Inventories.InventoryId) as InventoryCount

from IM_WarehouseTransfer Packages with (nolock)
         join IM_WarehouseTransferLine Lines with (nolock) on Lines.WarehouseTransferId = Packages.Id
         join MD_Item Items with (nolock) on Lines.ItemId = Items.TigerId and Items.Firm = Packages.Firm
         left join IM_WarehouseTransferLineInventory Inventories with (nolock) on Inventories.WarehouseTransferId = Lines.WarehouseTransferId
    and Inventories.ItemId = Lines.ItemId
where 1=1 '
if @warehouseTransferIds is not null
        set @Query = concat(@Query, ' AND (Packages.Id IN (SELECT LTRIM(Value) FROM F_SplitList(''', @warehouseTransferIds, ''',', ''','')))')

if @fromDivisions is not null
        set @Query = concat(@Query, ' AND (Packages.FromDivision IN (SELECT LTRIM(Value) FROM F_SplitList(''', @fromDivisions, ''',', ''','')))')

if @fromWarehouses is not null
        set @Query = concat(@Query, ' AND (Packages.FromWarehouse IN (SELECT LTRIM(Value) FROM F_SplitList(''', @fromWarehouses, ''',', ''','')))')

set @Query = concat (@Query, 'group by Packages.Id, Items.TigerId, Items.Code, Items.Name, Lines.SelectedCount, FromDivision, FromWarehouse')


set @Query = concat(@Query, ';

with Equipments as (select WarehouseNr, Items.Firm as Firm, Items.TigerId as TigerId, Items.Name as ItemName, Items.Code as ItemCode, count(Equipment.Id) as Count
                    from IM_Inventory Equipment with (nolock)
                             join MD_Item Items with (nolock) on Items.TigerId = Equipment.TigerId and Items.Firm = Equipment.Firm and Items.IsDeleted = 0
                             left join IM_StaticContent Content with (nolock) on Content.Id = Equipment.StateId and Content.IsActive = 1 and Items.IsDeleted = 0
                    where Equipment.Status = 1
                    group by WarehouseNr, Items.Firm, Items.TigerId, Items.Name, Items.Code),

     Reserved as (select Warehouse, ItemTigerId, Firm, count(*) as Count
                  from IM_InventoryDemand with (nolock)
                  where DemandType = 1
                    and DemandStatus in (0, 1)
                    and Reserved = 1
                  group by Warehouse, ItemTigerId, Firm),

     Transfers as (select FromWarehouse, Lines.ItemId, Package.Firm, sum(Lines.SelectedCount) as Count
                   from IM_WarehouseTransfer Package with (nolock)
                            join IM_WarehouseTransferLine Lines with (nolock) on Lines.WarehouseTransferId = Package.Id
                   where --Package.IsActive = 1 and
                       Package.IsDeleted = 0
                     and Package.Status = 0
                   group by FromWarehouse, Lines.ItemId, Package.Firm),
	Data as (
select Equipments.WarehouseNr,
       Equipments.TigerId                                                        as ItemId,
       iif(Equipments.Count - isnull(Reserved.Count, 0) - isnull(Transfers.Count, 0)<0,0,Equipments.Count - isnull(Reserved.Count, 0) 
														- isnull(Transfers.Count, 0)) as AvailableCount
from Equipments
         left join Reserved on Equipments.TigerId = Reserved.ItemTigerId and Equipments.Firm = Reserved.Firm and Reserved.Warehouse = Equipments.WarehouseNr
         left join Transfers on Equipments.TigerId = Transfers.ItemId and Equipments.Firm = Transfers.Firm and Transfers.FromWarehouse = Equipments.WarehouseNr)

	select WarehouseTransferId,
       cast (TigerId as int) ,
       ItemCode,
       ItemName,
       SelectedCount,
       FromDivision,
       FromWarehouse,
       InventoryCount,
       FromWarehouse             WarehouseNr,
       cast (TigerId as int)                   ItemId,
       isnull(AvailableCount, 0) AvailableCount
	
	from @table t left join Data on t.FromWarehouse = Data.WarehouseNr and t.TigerId = Data.ItemId
	order by t.ItemName

')


exec sp_executesql @Query, N'@warehouseTransferIds nvarchar(max), @firms nvarchar(max), @fromWarehouses nvarchar(max),@fromDivisions nvarchar(max) ', @warehouseTransferIds = @warehouseTransferIds,
@firms=@firms,@fromWarehouses=@fromWarehouses,@fromDivisions=@fromDivisions
    end