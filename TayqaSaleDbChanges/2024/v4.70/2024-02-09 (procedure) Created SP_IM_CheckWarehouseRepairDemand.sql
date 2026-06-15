
create procedure  [dbo].[SP_IM_CheckWarehouseRepairDemand] @firm smallint, @inventoryId int, @warehouseNr int, @userId bigint
as
begin
		   if((select count(*) from IM_Inventory where Id=@inventoryId and Status not in (1,0)) >0 )
			begin
                 select N'InventoryIsNotInWarehouse' as [Message], cast(0 as bit) as IsValid;
			end
		   else if( (select count(*) from IM_WarehouseTransfer tr
					join IM_WarehouseTransferLineInventory line on line.WarehouseTransferId=tr.Id
					where tr.IsDeleted=0 and tr.IsActive=1 and tr.Status in (0,1,2) and line.Status=0
					and line.Id=@inventoryId and tr.Firm=@firm) > 0 )
             begin
                 select N'ThisInventoryExistInWarehouseTransferPackage' as [Message], cast(0 as bit) as IsValid;
             end
           else if((select count(*) from IM_WarehouseRepairDemand where Status not in (4,13,10) and InventoryId=@inventoryId and Firm =@firm)>0)
              begin
                    select N'ThisInventoryExistInWarehouseRepairDemand' as [Message], cast(0 as bit)  as IsValid;
              end
            else if((select count(*) from IM_InventoryDemand demand
						join IM_InventoryDemandInventoryMapping map on map.InventoryDemandId=demand.Id
						where demand.DemandStatus = 3  and map.InventoryId=@inventoryId and demand.Firm=@firm )>0)
                begin
                    select N'ThisInventoryExistInInventoryDemand' as [Message], cast(0 as bit)  as IsValid;
                end
			else
				begin
				select N'' as Message, cast(1 as bit) as IsValid;
				end
end
