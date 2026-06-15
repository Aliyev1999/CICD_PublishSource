CREATE OR ALTER PROCEDURE [dbo].[SP_Edi_GetOrderOperations] @Firm INT = NULL,
                                                  @StartDate DATETIME = NULL,
                                                  @EndDate DATETIME = NULL,
                                                  @IsDeliveryDate BIT = 0,
                                                  @BuyerCompany NVARCHAR(MAX) = NULL,
                                                  @SupplierClientNameCode NVARCHAR(200) = NULL,
                                                  @Status NVARCHAR(MAX) = NULL,
                                                  @EdiOrderNumber NVARCHAR(100) = NULL,
                                                  @ERPOrderNumber NVARCHAR(100) = NULL,
                                                  @SkipCount INT = 0,
                                                  @TakeCount INT = 50,
                                                  @Sorting NVARCHAR(500),
                                                  @TotalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Result TABLE
                    (
                        Id                    INT,
                        OrderDate             DATETIME,
                        DeliveryDate          DATETIME,
                        EdiOrderNumber        NVARCHAR(100),
                        BuyerCompanyCode      NVARCHAR(100),
                        BuyerCompanyName      NVARCHAR(200),
                        BuyerDeliveryLocation NVARCHAR(200),
                        SupplierCompanyCode   NVARCHAR(100),
                        SupplierCompanyName   NVARCHAR(200),
                        SupplierClientCode    NVARCHAR(100),
                        SupplierClientName    NVARCHAR(200),
                        Amount                FLOAT,
                        ItemCount             INT,
                        Status                TINYINT,
                        Result                NVARCHAR(200),
                        ERPOrderNumber        NVARCHAR(100),
                        Note                  NVARCHAR(MAX)
                    );

    declare @Query nvarchar(max) = '
select Orders.Id                                 as Id,
       Orders.OrderDate                          as OrderDate,
       Orders.ExpectedDeliveryDate               as DeliveryDate,
       Orders.OrderNumber                        as EdiOrderNumber,
       Buyer.Code                                as BuyerCompanyCode,
       Buyer.Name                                as BuyerCompanyName,
       ClientMap.DeliveryLocationName            as BuyerDeliveryLocation,
       Seller.Code                               as SupplierCompanyCode,
       Seller.Name                               as SupplierCompanyName,
       Client.Code                               as SupplierClientCode,
       Client.Name                               as SupplierClientName,
       round(sum(Line.Quantity * Line.Price), 2) as Amount,
       count(Line.Id)                            as ItemCount,
       Orders.Status                             as Status,
       cast(Orders.Status as nvarchar(100))      as Result,
       Result.FicheNo                            as ERPOrderNumber,
       ''''                                      as Note
from EDI_OrderLine Line with (nolock)
         join EDI_Order Orders with (nolock) on Line.OrderId = Orders.Id
         join EDI_Company Buyer with (nolock) on Buyer.Id = Orders.BuyerCompanyId and Buyer.IsDeleted = 0
         join EDI_Company Seller with (nolock) on Seller.Id = Orders.SellerCompanyId and Seller.IsDeleted = 0
         left join EDI_ClientRelation ClientMap with (nolock)
                   on ClientMap.BuyerCompanyId = Buyer.Id and ClientMap.DeliveryLocationCode = Orders.DeliveryLocationCode and ClientMap.IsDeleted = 0
         left join MD_Client Client with (nolock) on Client.TigerId = ClientMap.ClientId and Client.Firm = ClientMap.Firm and Client.IsDeleted = 0
         left join (select distinct OrderId, last_value(FicheNo) over (order by RegisteredDate) as FicheNo from EDI_IntegrationResultLog with (nolock)) Result on Result.OrderId = Orders.Id
where Orders.IsDeleted = 0 '

    if @Firm is not null
        set @Query = concat(@Query, ' and Orders.Firm = @Firm ')

    if @StartDate is not null and @IsDeliveryDate = 0
        set @Query = concat(@Query, ' and Orders.OrderDate between @StartDate and @EndDate ')

    if @StartDate is not null and @IsDeliveryDate = 1
        set @Query = concat(@Query, ' and Orders.ExpectedDeliveryDate between @StartDate and @EndDate ')

    if @BuyerCompany is not null
        set @Query = concat(@Query, ' and (Buyer.Id in (select value from F_SplitList(@BuyerCompany, '','')))')

    if @SupplierClientNameCode is not null
        set @Query = concat(@Query,
                            ' and (Client.Name like ''%'' + @SupplierClientNameCode + ''%'' or Client.Code like ''%'' + @SupplierClientNameCode + ''%'')')

    if @Status is not null
        set @Query = concat(@Query, ' and (Orders.Status in (select value from F_SplitList(@Status, '','')))')

    if @EdiOrderNumber is not null
        set @Query = concat(@Query, ' and Orders.OrderNumber like ''%'' + @EdiOrderNumber + ''%''')

    if @ERPOrderNumber is not null
        set @Query = concat(@Query, ' and Result.FicheNo like ''%'' + @ERPOrderNumber + ''%''')


    set @Query = concat(@Query, N' group by Orders.Id, Orders.OrderDate, Orders.ExpectedDeliveryDate, Orders.OrderNumber, Buyer.Code, Buyer.Name,
                                           ClientMap.DeliveryLocationName, Seller.Code, Seller.Name, Client.Code, Client.Name, Orders.Status, Result.FicheNo ')

    insert into @Result
        exec sp_executesql @Query, N'
            @Firm INT = NULL,
            @StartDate DATETIME = NULL,
            @EndDate DATETIME = NULL,
            @IsDeliveryDate BIT = 0,
            @BuyerCompany NVARCHAR(MAX) = NULL,
            @SupplierClientNameCode NVARCHAR(200) = NULL,
            @Status NVARCHAR(MAX) = NULL,
            @EdiOrderNumber NVARCHAR(100) = NULL,
            @ERPOrderNumber NVARCHAR(100) = NULL',
             @Firm = @Firm,
             @StartDate = @StartDate,
             @EndDate = @EndDate,
             @IsDeliveryDate = @IsDeliveryDate,
             @BuyerCompany = @BuyerCompany,
             @SupplierClientNameCode = @SupplierClientNameCode,
             @Status = @Status,
             @EdiOrderNumber = @EdiOrderNumber,
             @ERPOrderNumber = @ERPOrderNumber


    set @TotalCount = (select count(Id) from @Result);

    select *
    from @Result
    order by coalesce(@Sorting, 'OrderDate DESC')
    offset @SkipCount rows fetch next @TakeCount rows only

END;
go