CREATE OR ALTER FUNCTION [dbo].[F_IM_GetInventories]
(
    @Firm int ,
    @TigerId int,
    @WarehouseNr int,
    @DivisionNr int,
    @DepartmentNr int,
    @InventoryStatus nvarchar(max),
    @StartDate date,
    @EndDate date,
    @RegistrationNr nvarchar(max),
    @ItemName nvarchar(max),
    @ItemCode nvarchar(max),
    @ClientTigerId int,
    @UserId int
)
returns table 
as 
return
(
select distinct inventory.Id          as Id,
       CostPrice             as CostPrice,
       WarehouseNr           as WarehouseNr,
       DivisionNr            as DivisionNr,
       DepartmentNr          as DepartmentNr,
       RegistrationNr        as RegistrationNr,
       item.Name             as ItemName,
       item.Code             as ItemCode,
       firm.Name             as FirmName,
       inventory.Firm        as FirmNr,
       RegistrationDate      as RegistrationDate,
       AmortizationBeginDate as AmortizationBeginDate,
       AmortizationPercent   as AmortizationPercent,
       inventory.ClientTigerId         as ClientTigerId,
       AmortizationTerm      as AmortizationTerm,
       inventory.Status      as InventoryStatus,
       CreationTime          as CreationTime,
       lastState.InventoryStateId               as StateId,
	   content.Id            as LocationId,
       SerialNr              as SerialNr
from IM_Inventory inventory with (nolock)
         join MD_Firm firm with (nolock) on inventory.Firm = firm.Nr and inventory.Status<>7
         join MD_Item item with (nolock) on item.TigerId = inventory.TigerId and item.IsDeleted = 0 and item.Firm = inventory.Firm
		 --left join IM_InventoryStateHistory history with (nolock) on history.InventoryId=inventory.Id and history.Firm=inventory.Firm
		 left join
(
    select h1.InventoryId, h1.Firm, h1.InventoryStateId
    from IM_InventoryStateHistory h1 with (nolock)
    where h1.InventoryStateId = (
        select max(h2.InventoryStateId)
        from IM_InventoryStateHistory h2 with (nolock)
        where h2.InventoryId = h1.InventoryId and h2.Firm = h1.Firm
    )
) lastState on lastState.InventoryId = inventory.Id and lastState.Firm = inventory.Firm
		 left join IM_StaticContent content with (nolock) on content.Id=lastState.InventoryStateId  --and content.Type=0

where inventory.Firm=@Firm 
		and (@ClientTigerId is null or inventory.ClientTigerId=@ClientTigerId)
	    and (@TigerId is null or inventory.TigerId = @TigerId)
        and (@WarehouseNr is null or WarehouseNr = @WarehouseNr)
        and (@DivisionNr is null or DivisionNr = @DivisionNr)
        and (@DepartmentNr is null or DepartmentNr = @DepartmentNr)
        and (@InventoryStatus is null or inventory.Status in (select value from F_SplitList(@InventoryStatus, ',')))
        and (@StartDate is null or RegistrationDate >= @StartDate)
        and (@EndDate is null or RegistrationDate <= @EndDate)
        and (@RegistrationNr is null or RegistrationNr like '%' + @RegistrationNr + '%')
        and (@ItemName is null or item.Name like '%' + @ItemName + '%')
        and (@ItemCode is null or item.Code like '%' + @ItemCode + '%')

);
