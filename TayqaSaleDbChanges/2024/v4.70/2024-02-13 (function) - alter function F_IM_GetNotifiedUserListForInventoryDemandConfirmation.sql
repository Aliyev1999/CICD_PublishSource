
alter   function [dbo].[F_IM_GetNotifiedUserListForInventoryDemandConfirmation](@inventoryDemandId int)
    RETURNS @T TABLE
               (
                   UserId int
               )
AS
begin

    declare @creatorUserId int = (select CreatorUserId
                                  from IM_InventoryDemand with (nolock)
                                  where Id = @inventoryDemandId)

    insert into @T (UserId)
    select ParentId as UserId
    from F_UIM_GetOrganizationUserParents(@creatorUserId, 0)
    where ParentId in (select UserId from UIM_UserProperty where Specode1 = 'INV')
    return
end