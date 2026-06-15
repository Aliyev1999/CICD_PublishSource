alter PROCEDURE [dbo].[SP_SM_RetrieveItemList] @firmId SMALLINT, @clientId BIGINT, @docType TINYINT
AS
BEGIN
    if @clientId = 192366
        select 2657             as ItemId,
               1                as OrderNo,
               cast(1 as float) as SuggestedQuantity,
               ''               as Note
    else

        select cast(TigerItemId as int) as ItemId,
               1                        as OrderNo,
               cast(1 as float)         as SuggestedQuantity,
               ''                       as Note
        from MD_CatalogItemMapping
        where CatalogId in (571, 100731)
END
go