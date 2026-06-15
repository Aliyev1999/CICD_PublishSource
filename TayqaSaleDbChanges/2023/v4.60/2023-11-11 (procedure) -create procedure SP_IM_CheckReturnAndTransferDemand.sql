
create procedure  [dbo].[SP_IM_CheckReturnAndTransferDemand] @firm smallint, @actionType tinyint, @inventoryId int, @userId int
as
begin
    if(@actionType = 1)
        begin
           if( (select Count(*) from IM_TransferDemand ITD
                                join IM_Inventory II on II.Id=ITD.InventoryId
                                where ITD.Status in (0,1,3,4) and InventoryId=@inventoryId and II.Firm=@firm) > 0 )
             begin
                 select N'İnventara aid aktiv transfer tələbi mövcuddur' as Message, cast(0 as bit) as IsValid;
             end
           else if((select Count(Id) from IM_RepairDemand
                                     where Status in (0,1,2,5,6,7,8,9,11,12) and Firm=@firm and InventoryId=@inventoryId)>0)
              begin
                    select N'İnventara aid aktiv təmir tələbi mövcuddur' as Message, cast(0 as bit)  as IsValid;
              end
            else if((select count(*) from IM_Inventory II
									join IM_InventoryDemandInventoryMapping M on M.InventoryId=II.Id 
                                     join  IM_InventoryDemand IID on M.InventoryDemandId = IID.Id
                                     where  IID.DemandStatus in (0,1,3) and II.Firm = @firm and  II.Id=@inventoryId
                                     and IID.DemandType=2)>0)
                begin
                    select N'İnventara aid aktiv qaytarma tələbi mövcuddur' as Message, cast(0 as bit)  as IsValid;
                end
        else
          select N'' as Message, cast(1 as bit) as IsValid;
        end
    else if(@actionType=3 or @actionType=5)
        begin
            if((select Count(Id) from IM_RepairDemand where Status in (1,2,5,6,7,8,9,11,12) and InventoryId=@inventoryId)>0)
                begin
                    select N'İnventara aid aktiv təmir tələbi mövcuddur' as Message, cast(0 as bit) as IsValid;
                end
            else
                 select N'' as Message, cast(1 as bit) as IsValid;
        end
    else
      select N'' as Message, cast(1 as bit) as IsValid;
end