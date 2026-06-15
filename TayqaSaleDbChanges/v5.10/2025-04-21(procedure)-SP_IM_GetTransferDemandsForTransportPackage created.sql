CREATE OR ALTER procedure [dbo].[SP_IM_GetTransferDemandsForTransportPackage](@demandNo int null,
                                                                     @itemNameCode nvarchar(500) null,
                                                                     @clientNameCode nvarchar(500) null,
                                                                     @endDate datetime null,
                                                                     @startDate datetime null,
                                                                     @firm smallint null,
                                                                     @edino nvarchar(100) null,
                                                                     @userIdList nvarchar(500) = 0,
                                                                     @ignoredDemandIdList nvarchar(500) = 0,
                                                                     @warehouseNrList nvarchar(500) = 0,
                                                                     @saleChannel nvarchar(500) null,
                                                                     @currentUserId int,
                                                                     @sorting nvarchar(500) null,
                                                                     @maxResultCount int,
                                                                     @skipCount int = 0,
                                                                     @totalCount INT OUTPUT)
as

declare
    @Query nvarchar(max)='

	declare @Result table
                (
                    Id                       int,
                    DemandStatus             tinyint,
                    FromClientCode           nvarchar(150),
                    FromClientName           nvarchar(150),
                    FromClientEdino          nvarchar(150),
					ToClientCode             nvarchar(150),
					ToClientName             nvarchar(150),
					ToClientEdino            nvarchar(150),
                    InventoryRegistrationNr  nvarchar(50),
                    ItemCode                 nvarchar(150),
                    ItemName                 nvarchar(150),
                    SaleChannel              nvarchar(150),
                    ConfirmedDate            datetime,
                    Warehouse                nvarchar(150)
                );
'
declare
    @IsAdmin bit = (Select IsAdmin
                    FROM (select distinct IIF(r.Name = 'admin', CAST(1 AS bit), CAST(0 AS bit)) as IsAdmin
                          from AbpUsers u
                                   left join AbpUserRoles ur WITH (NOLOCK) on u.TenantId = ur.TenantId and u.Id = ur.UserId
                                   left join AbpRoles r WITH (NOLOCK) on ur.TenantId = r.TenantId and ur.RoleId = r.Id
                          where u.Id = @CurrentUserId) t);

    set @Query = concat(@Query, '
	
with Data as (
select distinct demand.Id                                   as Id,
       package.PackageStatus                       as DemandStatus,
       fromclient.Code                             as FromClientCode,
       fromclient.Name                             as FromClientName,
       fromclient.Edino                            as FromClientEdino,
       toclient.Code                               as ToClientCode,
       toclient.Name                               as ToClientName,
       toclient.Edino                              as ToClientEdino,
       inventory.RegistrationNr                    as InventoryRegistrationNr,
       item.Code                                   as ItemCode,
       item.Name                                   as ItemName,
	   coalesce(toclient.SaleChannel,fromclient.SaleChannel) as SaleChannel,
	   demand.ConfirmedDate                         as ConfirmedDate , 
       warehouse.Name                              as Warehouse
		 from IM_TransferDemand demand with (nolock) 
		 join IM_Inventory inventory with (nolock) on inventory.Id = demand.InventoryId
	     join MD_Client fromclient with (nolock) on fromclient.TigerId = demand.FromClientId 
         join MD_Client toclient with (nolock) on toclient.TigerId = demand.ToClientId 
		 join MD_Item item with (nolock) on item.TigerId = inventory.TigerId and item.Firm=inventory.Firm
         join MD_Warehouse warehouse with (nolock) on warehouse.Nr = demand.WarehouseNr and warehouse.Firm=inventory.Firm
		 left join IM_TransportPackageTransferDemandMapping mapping with (nolock) on demand.Id = mapping.TransferDemandId
         left join IM_InventoryTransportPackage package with (nolock) on package.Id = mapping.TransportPackageId
			   
		 
')
    if @IsAdmin = 0
        set @Query =
                concat(@Query, ' join  MD_PermittedWarehouse Permittedinput with (nolock) on Permittedinput.TigerWarehouseNr = demand.Warehouse  and Permittedinput.UserId = @currentUserId
   ')

   set @Query = concat(@Query,
                            ' where  demand.Status=1  and  not exists (
    select  1
    from IM_TransportPackageTransferDemandMapping mapping with (nolock)
    join IM_InventoryTransportPackage package with (nolock)
        on package.Id = mapping.TransportPackageId
    where mapping.TransferDemandId = demand.Id
      and package.PackageStatus in (0, 1, 2)
)')

    if @StartDate is not null or @EndDate is not null
        set @Query = concat(@Query,
                            '  and  (demand.ConfirmedDate between @startDate and @endDate)')
    if @itemNameCode is not null
        set @Query = concat(@Query,
                            ' and (item.Code LIKE ''%'' + @itemNameCode + ''%'' OR item.Name LIKE ''%'' + @itemNameCode + ''%'')')
	if @demandNo is not null
        set @Query = concat(@Query,
                            ' and ( demand.Id = @demandNo )')
    if @clientNameCode is not null
        set @Query = concat(@Query,
                            ' and (toclient.Code LIKE ''%'' + @clientNameCode + ''%'' OR toclient.Name LIKE ''%'' + @clientNameCode + ''%'' or fromclient.Code LIKE ''%'' + @clientNameCode + ''%'' OR fromclient.Name LIKE ''%'' + @clientNameCode + ''%'')')
    if @firm is not null
        set @Query = concat(@Query,
                            ' and  (inventory.Firm = @firm)');

    if @edino is not null
        set @Query = concat(@Query,
                            ' and (fromclient.Edino like ''%'' + @edino + ''%'' OR toclient.Edino like ''%'' + @edino + ''%'' )')
    if @saleChannel is not null
        set @Query = concat(@Query,
                            ' and (coalesce(toclient.SaleChannel,fromclient.SaleChannel)   LIKE ''%'' + @saleChannel + ''%'' )')
    if @warehouseNrList is not null
        set @Query = concat(@Query,
                            ' and (demand.WarehouseNr in (select ltrim(Value) from F_SplitList(@warehouseNrList, '','')))')
	if @userIdList is not null
        set @Query = concat(@Query,
                            ' and (demand.CreatorUserId in (select ltrim(Value) from F_SplitList(@userIdList, '','')))')

	if @ignoredDemandIdList is not null 
    set @Query = concat(@Query,
        ' and (demand.Id not in (select ltrim(Value) from F_SplitList(@ignoredDemandIdList, '','')))')


    set @Query = concat(@Query, ') 

	insert into @Result ( Id, DemandStatus,FromClientCode,FromClientName,FromClientEdino,ToClientCode,ToClientName,ToClientEdino,InventoryRegistrationNr,ItemCode ,ItemName ,SaleChannel,ConfirmedDate,Warehouse)

    select * from Data


set @totalCount = (select count(*) from @Result)


select * from @Result
    ')
    if @SkipCount is not null or @maxResultCount is not null
        set @Query = concat(@Query, ' order by  ' + isnull(@Sorting, 'Id desc') + ' offset @SkipCount rows fetch next @maxResultCount rows only')


    exec sp_executesql @Query, N' 
						@demandNo int null,
                        @itemNameCode nvarchar(500) null,
                        @clientNameCode nvarchar(500) null,
                        @endDate datetime null,
                        @startDate datetime null,
                        @firm smallint null,
                        @edino nvarchar(100) null,
                        @userIdList nvarchar(500) = 0,
                        @ignoredDemandIdList nvarchar(500) = 0,
                        @warehouseNrList nvarchar(500) = 0,
                        @saleChannel nvarchar(500) null,
                        @currentUserId int,
                        @sorting nvarchar(500) null,
                        @maxResultCount int,
                        @skipCount int =0,
                        @totalCount INT OUTPUT',
         @demandNo =@demandNo,
         @itemNameCode =@itemNameCode,
         @clientNameCode = @clientNameCode,
         @endDate =@endDate,
         @startDate =@startDate,
         @firm =@firm,
         @edino =@edino,
         @userIdList =@userIdList,
         @ignoredDemandIdList =@ignoredDemandIdList,
         @warehouseNrList =@warehouseNrList,
         @saleChannel =@saleChannel,
         @currentUserId =@currentUserId,
         @sorting =@sorting,
         @maxResultCount =@maxResultCount,
         @skipCount =@skipCount,
         @totalCount =@totalCount OUTPUT;