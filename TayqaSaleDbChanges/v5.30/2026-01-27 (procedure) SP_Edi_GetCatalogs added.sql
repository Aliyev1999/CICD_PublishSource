CREATE OR ALTER PROCEDURE [dbo].[SP_Edi_GetCatalogs] @StartDate DATETIME = NULL,
                                            @EndDate DATETIME = NULL,
                                            @BuyerCompany NVARCHAR(255) = NULL,
                                            @EANBarcode NVARCHAR(100) = NULL,
                                            @BuyerItemCode NVARCHAR(100) = NULL,
                                            @SupplierItemCode NVARCHAR(100) = NULL,
                                            @ItemName NVARCHAR(100) = NULL,
                                            @SkipCount INT = 0,
                                            @TakeCount INT = 50,
                                            @Sorting NVARCHAR(100) = N'RegisteredDate DESC',
                                            @TotalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Catalogs TABLE
                      (
                          Id                   INT,
                          BuyerCompanyCode     NVARCHAR(100),
                          BuyerCompanyName     NVARCHAR(200),
                          SupplierCompanyCode  NVARCHAR(100),
                          SupplierCompanyName  NVARCHAR(200),
                          EANBarcode           NVARCHAR(100),
                          BuyerItemCode        NVARCHAR(100),
                          BuyerItemName        NVARCHAR(200),
                          SupplierItemCode     NVARCHAR(100),
                          BuyerItemUnitCode    NVARCHAR(50),
                          SupplierItemUnitCode NVARCHAR(50),
                          PackSize             float,
                          Price                float,
                          MinOrderQuantity     float,
                          RegisteredDate       DATETIME
                      );

    declare @Query nvarchar(max) = N'
select Catalog.Id                 as Id,
       Buyer.Code                 as BuyerCompanyCode,
       Buyer.Name                 as BuyerCompanyName,
       Seller.Code                as SupplierCompanyCode,
       Seller.Name                as SupplierCompanyName,
       CatalogItem.Ean            as EANBarcode,
       CatalogItem.BuyerItemCode  as BuyerItemCode,
       CatalogItem.Description    as BuyerItemName,
       Item.Code                  as SupplierItemCode,
       CatalogItem.EdiUnit        as BuyerItemUnitCode,
       UnitMapping.TayqaUnitCode  as SupplierItemUnitCode,
       UnitPackSize               as PackSize,
       Price                      as Price,
       MinOrderQuantity           as MinOrderQuantity,
       CatalogItem.RegisteredDate as RegisteredDate

from EDI_Catalog Catalog with (nolock)
         join EDI_Company Buyer with (nolock) on Buyer.Id = Catalog.BuyerCompanyId
         join EDI_Company Seller with (nolock) on Seller.Id = Catalog.SellerCompanyId
         join EDI_CatalogItem CatalogItem with (nolock) on Catalog.Id = CatalogItem.CatalogId
         left join EDI_ItemMapping Mapping with (nolock) on Mapping.BuyerItemCode = CatalogItem.BuyerItemCode
         left join MD_Item Item with (nolock) on Item.TigerId = Mapping.SellerItemId and Mapping.Firm = Item.Firm and Item.IsDeleted = 0
         left join EDI_UnitMapping UnitMapping with (nolock) on UnitMapping.EdiUnitCode = CatalogItem.EdiUnit

where 1 = 1
'

    if @StartDate is not null or @EndDate is not null
        set @Query = concat(@Query, ' and CatalogItem.RegisteredDate between @StartDate and @EndDate')

    IF @BuyerCompany IS NOT NULL AND LTRIM(RTRIM(@BuyerCompany)) <> ''
        BEGIN
            SET @Query = @Query + '
        AND Buyer.Id IN (
            SELECT CAST(value AS INT)
            FROM STRING_SPLIT(@BuyerCompany, '','')
        )'
        END

    if @EANBarcode is not null
        set @Query = concat(@Query, ' and CatalogItem.Ean like ''%'' + @EANBarcode + ''%''')

    if @BuyerItemCode is not null
        set @Query = concat(@Query, ' and CatalogItem.BuyerItemCode like ''%'' + @BuyerItemCode + ''%''')

    if @SupplierItemCode is not null
        set @Query = concat(@Query, ' and Item.Code like ''%'' + @SupplierItemCode + ''%''')

    if @ItemName is not null
        set @Query = concat(@Query, ' and CatalogItem.Description like ''%'' + @ItemName + ''%''')

    insert into @Catalogs
        exec sp_executesql @Query, N'
            @StartDate DATETIME = NULL,
            @EndDate DATETIME = NULL,
            @BuyerCompany NVARCHAR(255) = NULL,
            @EANBarcode NVARCHAR(100) = NULL,
            @BuyerItemCode NVARCHAR(100) = NULL,
            @SupplierItemCode NVARCHAR(100) = NULL,
            @ItemName NVARCHAR(100) = NULL',
             @StartDate = @StartDate,
             @EndDate = @EndDate,
             @BuyerCompany = @BuyerCompany,
             @EANBarcode = @EANBarcode,
             @BuyerItemCode = @BuyerItemCode,
             @SupplierItemCode = @SupplierItemCode,
             @ItemName = @ItemName


    SELECT @TotalCount = COUNT(*) FROM @Catalogs;

    SELECT *
    FROM @Catalogs
    ORDER BY coalesce(@Sorting, ' RegisteredDate DESC ')
    OFFSET @SkipCount ROWS FETCH NEXT @TakeCount ROWS ONLY;
END;
go