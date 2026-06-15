CREATE Procedure [dbo].[SP_IM_CheckRepairConsumption] @CheckConsumptionType CheckConsumptionType readonly
as
begin
    Declare @Result ConsumptionOutput;

    Insert into @Result (ItemId, IsValidated)
    select ois.TigerItemId as ItemId, iif(ct.Quantity > ois.RealAmount, 0, 1) as IsValidated
    from OP_ItemStock ois
             join @CheckConsumptionType ct on ois.TigerItemId = ct.ItemId and ois.WarehouseNr = ct.WarehouseNr

    select * from @Result
end