
CREATE PROCEDURE [dbo].[SP_SM_RetrieveItemList] @firmId SMALLINT, @clientId BIGINT, @docType TINYINT
AS
BEGIN
if @clientId=192366 select 2657 as ItemId else

    select cast(TigerItemId as int) as ItemId from MD_CatalogItemMapping where CatalogId in (571,100731)
END
 




