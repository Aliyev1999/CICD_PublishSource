CREATE OR ALTER procedure [dbo].[SP_MD_GetOrderItemGroups](
    @userId int,
    @firm smallint
)
as
begin

    with UserGroupPermitted as (select ItemGroup.OrderItemGroupId,
                                       1 as Type
                                from MD_UserGroupPermittedOrderItemGroup ItemGroup with (nolock)
                                         join MD_UserGroupMapping Mapping with (nolock) on ItemGroup.UserGroupId = Mapping.GroupId
                                where Mapping.UserId = @userId
                                  and Mapping.Firm = @firm

                                union all

                                select Permitted.OrderItemGroupId,
                                       2 as Type
                                from MD_PermittedOrderItemGroup Permitted with (nolock)
                                where Permitted.UserId = @userId),
         RankedPermissions as (select OrderItemGroupId,
                                      Type,
                                      row_number() over ( partition by OrderItemGroupId order by Type) as rn
                               from UserGroupPermitted)

    select mapping.ItemId, RankedPermissions.OrderItemGroupId as GroupId, mapping.Firm
    from RankedPermissions
             join MD_OrderItemGroupItemMapping mapping with (nolock) on mapping.GroupId = RankedPermissions.OrderItemGroupId
             join MD_OrderItemGroup g with (nolock) on mapping.GroupId = g.Id and mapping.Firm = g.Firm
             join F_GetAllPermittedItems() pItem ON mapping.Firm = pItem.Firm and mapping.ItemId = pItem.TigerItemId and pItem.UserId = @UserId
             join MD_Item Item on pItem.Firm = Item.Firm AND pItem.TigerItemId = Item.TigerId
    where Item.Status = 0
      AND Item.IsDeleted = 0
      and g.Firm = @firm
      and rn = 1


end