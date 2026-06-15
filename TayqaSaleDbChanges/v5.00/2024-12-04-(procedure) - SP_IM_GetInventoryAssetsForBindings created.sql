CREATE OR ALTER procedure [dbo].[SP_IM_GetInventoryAssetsForBindings](
    @firmNr smallint,
    @assetNumber nvarchar(100),
    @warehouseIds nvarchar(max),
    @itemCodeName nvarchar(100),
    @currentUserId int,
    @sorting nvarchar(100),
    @skipCount int,
    @maxResultCount int,
    @totalCount int output
)
as
begin

    declare @query nvarchar(max);
    declare @Result table
                    (
                       
                        AssetNumber   nvarchar(50),
                        WarehouseNr   smallint,
						Warehouse     nvarchar(100),
                        ItemCode      nvarchar(50),
                        ItemName     nvarchar(100)
                        
                        
                    )

    set @query =
            '
    
   select Asset.AssetNr                   as AssetNumber,
           cast(Warehouse.Nr as smallint) as WarehouseNr,
           Warehouse.Name                 as Warehouse,
           Item.Code                      as ItemCode,
           Item.Name                      as ItemName

    from IM_Asset Asset with (nolock)
			 join F_GetAllPermittedUsers(@currentUserId) Permitted on Permitted. UserId = asset.CreatorUserId
             join MD_Warehouse Warehouse with (nolock) on Warehouse.Nr = Asset.WarehouseNr and Warehouse.Firm = Asset.Firm and Warehouse.IsDeleted = 0
             join MD_Item Item with (nolock) on Item.TigerId = Asset.ItemId and Item.Firm = Asset.Firm and Item.IsDeleted = 0 and Item.Status = 0
    where    Asset.IsDeleted = 0  and  Asset.Status = 2
    and not exists (
        select 1
        from IM_AssetBinding Binding with (nolock)
        where Binding.AssetId = Asset.Id 
          and binding.Status=1 
    )
            '
    

    if @firmNr is not null
        set @query = concat(@query, ' and (asset.Firm = @firmNr)')

    if @itemCodeName is not null
        set @query = concat(@query, ' and (Item.Name like ''%''+@itemCodeName+''%'' or Item.Code like ''%''+@itemCodeName+''%'' )')

    if @assetNumber is not null
        set @query = concat(@query, ' and (Asset.AssetNr = @assetNumber)')

    if @warehouseIds is not null
        set @query = concat(@query, ' and (Warehouse.Nr in (select value from string_split(@warehouseIds, '','')))')

    if @sorting is null set @Query = concat(@Query, ' order by Asset.AssetNr desc ')

    if @sorting is not null set @Query = concat(@Query, ' order by ' + @sorting)
    insert into @Result

    EXEC sp_executesql @query,
         N'     @firmNr smallint,
				@assetNumber nvarchar(100),
				@warehouseIds nvarchar(max),
				@itemCodeName nvarchar(100),
				@currentUserId int,
				@sorting nvarchar(100),
				@skipCount int,
				@maxResultCount int,
				@totalCount int output
			',
                @firmNr=@firmNr ,
				@assetNumber=@assetNumber ,
				@warehouseIds=@warehouseIds ,
				@itemCodeName=@itemCodeName ,
				@currentUserId=@currentUserId ,
				@sorting=@sorting ,
				@skipCount =@skipCount,
				@maxResultCount=@maxResultCount  ,
				@totalCount =@totalCount

    set @TotalCount = (select count(AssetNumber) from @Result);

    select *
    from @Result
    order by coalesce(@sorting, 'AssetNumber') desc
    offset @skipCount rows fetch next @maxResultCount rows only

end