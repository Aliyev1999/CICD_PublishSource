
ALTER PROCEDURE [dbo].[SP_SM_RetrieveItemList] @firmId SMALLINT, @clientId BIGINT, @docType TINYINT, @userId int
AS
BEGIN

    declare @CurrentUserId int

    select @CurrentUserId = Id from AbpUsers where IsActive = 1 and IsDeleted = 0

--select cast(TigerId as int) as ItemId from MD_Item where TigerId=2621

    select cast(a.TigerItemId as int) as ItemId,
           1                          as OrderNo,
           Cast(3 as float)           as SuggestedQuantity,
           'Note'                     as Note
    from MD_UserGroupItemMapping a
             join MD_UserGroupMapping b on a.GroupId = b.GroupId
             join MD_CatalogItemMapping c on a.TigerItemId = c.TigerItemId
--     where UserId = @userId

END