CREATE OR ALTER FUNCTION [dbo].[F_OP_GetDivisionBasedOrStandardPrice] (
    @divisionNr INT,
    @itemId INT,
    @firm SMALLINT,
    @priceDate DATETIME,
    @currencyType SMALLINT,
    @operationMask VARCHAR(50),
    @saleChannelMask VARCHAR(50)
)
RETURNS @ResultTable TABLE (
    Price DECIMAL(18, 2),
    VatIncluded BIT,
    IsConvertible BIT,
    TigerItemUnitId INT,
    Convfact1 INT,
    Convfact2 INT,
    TigerItemId INT
)
AS
BEGIN
    INSERT INTO @ResultTable (Price, VatIncluded, IsConvertible, TigerItemUnitId, Convfact1, Convfact2, TigerItemId)
    SELECT top 1 Price.Price, 
           Price.VatIncluded, 
           Price.IsConvertible, 
           Price.TigerItemUnitId , 
           Unit.Convfact1, 
           Unit.Convfact2, 
           Price.TigerItemId
    FROM MD_ItemPrice Price WITH (NOLOCK)
         INNER JOIN MD_ItemPriceDivisionMapping DMapping WITH (NOLOCK) ON (DMapping.Firm=Price.Firm AND DMapping.TigerId=Price.TigerId)
         INNER JOIN MD_ItemUnit Unit WITH (NOLOCK) ON Unit.TigerId = Price.TigerItemUnitId AND Unit.Firm=Price.Firm
    WHERE Price.TigerItemId=@itemId 
         AND Price.Firm=@firm AND Price.BeginDate<=@priceDate AND Price.EndDate>=@priceDate AND Price.Status=0 AND Price.IsDeleted=0
		 order by Price.Priority asc, Price.RegisteredDate desc
    RETURN;
END