create procedure [dbo].[SP_IM_GetInventoryWarehouseTransferLines](@firm smallint, @beginDate date, @endDate date,
                                                                 @UserId int, @viewMode tinyint)
AS
begin
    --11/22/2022
-- Author: created by Shahri Yahyayeva
-- Description: The query returns the inventory warehouse transfer package lines

select Packages.Id                            as PackageId,
       concat(users.Name, ' ', users.Surname) as ReceiverUserFullName,
       Packages.FromDivision                  as OutDivisionNr,
       Packages.FromWarehouse                 as OutWarehouseNr,
       Packages.ToDivision                    as InDivisionNr,
       Packages.ToWarehouse                   as InWarehouseNr,
       Packages.Status                        as Status,
       Items.Code                             as ItemCode,
       Items.Name                             as ItemName,
       Items.TigerId                          as ItemId,
       case
           when @viewMode = 1 then Lines.SelectedCount -- if send -> Original selected count
           when @viewMode = 2 then InventoryCount.Count -- if receive -> see added inventory count
           end                                as PlannedCount,
       Inventory.RegistrationNr               as RegistrationNr,
       PackageInventories.Status              as InventoryStatus

from IM_WarehouseTransfer Packages with (nolock)
         join AbpUsers users with (nolock) on users.Id = Packages.ReceiverUserId
         join IM_WarehouseTransferLine Lines with (nolock) on Packages.Id = Lines.WarehouseTransferId
         join Md_Item Items with (nolock) on Lines.ItemId = Items.TigerId and Items.Firm = Packages.Firm and Items.CardType = 4
         left join IM_WarehouseTransferLineInventory PackageInventories with (nolock)
                   on Packages.Id = PackageInventories.WarehouseTransferId and PackageInventories.ItemId = Lines.ItemId
         left join IM_Inventory Inventory on Inventory.Id = PackageInventories.InventoryId and Inventory.Firm = Packages.Firm

         left join (select WarehouseTransferId, ItemId, count(InventoryId) Count
                    from IM_WarehouseTransferLineInventory with (nolock)
                    group by WarehouseTransferId, ItemId) InventoryCount
                   on Lines.WarehouseTransferId = InventoryCount.WarehouseTransferId and Lines.ItemId = InventoryCount.ItemId

         left join MD_PermittedTransferWarehousesMapping Mapping
                   on Packages.Firm = Mapping.Firm and @viewMode = 1 and Mapping.ExitWarehouseNr = Packages.FromWarehouse and
                      Mapping.UserId = @UserId

where @Firm = Packages.Firm and Packages.IsActive=1 and Packages.IsDeleted=0
  and cast(Packages.CreationTime as date) between cast(@beginDate as date) and cast(@endDate as date)
  and ((@viewMode = 1 and Mapping.ExitWarehouseNr is not null) -- if user is in send tab -> should see packages from his warehouses
    or
       (@viewMode = 2 and ReceiverUserId = @UserId and Packages.Status > 0 and Count is not null)) -- if user is in receive tab -> should see incoming packages for HIM only


end 