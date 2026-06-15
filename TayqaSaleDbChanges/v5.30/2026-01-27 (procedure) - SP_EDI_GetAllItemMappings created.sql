Create or ALTER   procedure [dbo].[SP_EDI_GetAllItemMappings]
@Firm smallint,
@BuyerCompanies nvarchar(max),
@BuyerItemCode nvarchar(100),
@EanBarcode nvarchar(100),
@SellerItemNameOrCode nvarchar(100),
@SkipCount INT,
@TakeCount INT,
@Sorting NVARCHAR(100),
@TotalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
	set @TotalCount = 1;
  DECLARE @sql NVARCHAR(MAX);

  set @sql = 'declare @Result table (
  
				Id					int,
				Firm				nvarchar(50),
				BuyerCompanyCode	nvarchar(50),
				BuyerCompanyName    nvarchar(50),
				BuyerItemCode       nvarchar(20),
				EanBarcode          nvarchar(20),
				SellerItemCode      nvarchar(50),
				SellerItemName      nvarchar(50),
				DividerUnit             float,
				CreationTime        datetime)
				
	insert into @Result (Id ,Firm,BuyerCompanyCode ,BuyerCompanyName ,BuyerItemCode ,EanBarcode , SellerItemCode ,SellerItemName, DividerUnit, CreationTime)'

  set @sql = concat(@sql,'Select 
			 itemMapping.Id            as Id,
			 firm.Name				   as Firm, 
			 company.Code			   as BuyerCompanyCode,
			 company.Name			   as BuyerCompanyName,
			 itemMapping.BuyerItemCode as BuyerItemCode, 
			 itemMapping.EanBarcode	   as EanBarcode, 
			 item.Code				   as SellerItemCode,
			 item.Name				   as SellerItemName,
			 itemMapping.Divider	   as DividerUnit,
			 itemMapping.CreationTime  as CreationTime

		From EDI_ItemMapping itemMapping
		Join MD_Firm firm on itemMapping.Firm = firm.Nr
		Join EDI_Company company on itemMapping.BuyerCompanyId = company.Id
		Join MD_Item item on itemMapping.SellerItemId = item.TigerId
		where itemMapping.IsDeleted = 0 ')

	if @BuyerCompanies is not null
	set @sql = concat(@sql, ' and company.Id in (select value from F_SplitList(@BuyerCompanies, '',''))')

	if @Firm is not null
	set @sql = concat(@sql, ' and firm.Nr = @Firm ')

	if @BuyerItemCode is not null
    set @sql = concat(@sql, ' and (itemMapping.BuyerItemCode like ''%''+@BuyerItemCode+ ''%'')')

	if @EanBarcode is not null
    set @sql = concat(@sql, ' and (itemMapping.EanBarcode like ''%''+@EanBarcode +''%'')')

    if @SellerItemNameOrCode is not null
        set @sql = concat(@sql, ' and (item.Name like ''%''+@SellerItemNameOrCode+''%'' or item.Code like ''%''+@SellerItemNameOrCode+''%'')')

	set @sql = concat(@sql,'set @TotalCount = (select count(*) from @Result)
		
							select * from @Result');
		
    if @SkipCount is not null or @TakeCount is not null
        set @sql = concat(@sql, ' ORDER BY  ' + isnull(@Sorting, 'CreationTime desc') + ' offset @SkipCount rows fetch next @TakeCount rows only');

	PRINT CAST(@sql AS NTEXT);


	    exec sp_executesql @sql, N'  @Firm smallint,
								     @BuyerCompanies nvarchar(max),
									 @BuyerItemCode nvarchar(100),
									 @EanBarcode nvarchar(100),
									 @SellerItemNameOrCode nvarchar(100),
									 @SkipCount int,
									 @TakeCount int,
									 @Sorting nvarchar(max) ,
									 @TotalCount int out',
		 @Firm = @Firm,
		 @BuyerCompanies = @BuyerCompanies,
		 @BuyerItemCode = @BuyerItemCode,
		 @EanBarcode = @EanBarcode,
		 @SellerItemNameOrCode = @SellerItemNameOrCode,
         @SkipCount =@SkipCount,
         @TakeCount =@TakeCount,
         @Sorting=@Sorting,
         @TotalCount = @TotalCount out
END