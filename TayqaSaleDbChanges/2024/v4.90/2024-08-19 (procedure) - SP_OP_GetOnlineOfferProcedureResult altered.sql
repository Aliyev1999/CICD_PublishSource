ALTER proc [dbo].[SP_OP_GetOnlineOfferProcedureResult](@clientId int,
                                                       @templateId int,
                                                       @catalogIds nvarchar(MAX),
                                                       @operationId tinyint,
                                                       @date datetime = null,
                                                       @userId int)
AS
BEGIN
    SET NOCOUNT ON;
    if @templateId < 1000000
        begin

            Declare @Query nvarchar(max);

            select @Query = ProcedureName
            from OP_OnlineOfferTemplate t with (nolock)
            where Id = @templateId


            SET @Query = CONCAT(@Query, ' @clientId, @catalogIds, @operationId, @date, @userId')

            EXEC sp_executesql @Query, N'@clientId int,

                @catalogIds nvarchar(MAX) = null,
                    @operationId tinyint,
                    @date datetime = null,
                    @userId int',
                 @clientId=@clientId,
                 @catalogIds=@catalogIds,
                 @operationId=@operationId,
                 @date=@date,
                 @userId = @userId
        end

    else
        begin
            select distinct Item.TigerId   as ItemId,
                            Unit.Code      as UnitCode,
                            1              as Quantity,
                            1              as Price,
                            cast(1 as bit) as CanRemove,
                            cast(1 as bit) as CanDecrease,
                            cast(1 as bit) as IsCampaignItem,
                            cast(0 as bit) as IsSpecialItem,
                            cast(0 as bit) as IsRecommendedItem,
                            cast(0 as bit) as IsBestSellingItem,
                            ''             as Note

            from SPEC_ProductInfo Po
                     join MD_Item Item with (nolock) on Po.ProductCode = Item.Code COLLATE SQL_Latin1_General_CP1_CI_AS
                     join MD_CatalogItemMapping map with (nolock) on map.TigerItemId = Item.TigerId and map.CanSell = 1
                     join MD_PermittedCatalog cat with (nolock) on cat.CatalogId = map.CatalogId and cat.UserId = @userId
                     join (SELECT unit.TigerItemId, unit.Code
                           FROM MD_ItemUnit Unit WITH (NOLOCK)
                           WHERE Unit.IsForSale = 1
                             and LineNr = 1) Unit on Unit.TigerItemId = Item.TigerId
            where AuditId = @templateId - 1000000
              and EnoughStock = 0
        end
END

