CREATE OR ALTER procedure [dbo].[SP_IM_GetInventoryDemandsForTransportPackage](@demandNo int null,
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
                                                                     @inventoryRegistrationNr nvarchar(500) null,
                                                                     @inventoryDemandType tinyint null,
                                                                     @currentUserId int,
                                                                     @sorting nvarchar(500) null,
                                                                     @maxResultCount int,
                                                                     @skipCount int =0,
                                                                     @totalCount INT OUTPUT
)
AS

declare
    @Query nvarchar(max)='

	declare @Result table
                (
                    Id                       int,
                    DemandStatus             tinyint,
                    DemandType               tinyint,
                    ClientCode               nvarchar(150),
                    ClientName               nvarchar(150),
                    Edino              nvarchar(150),
                    InventoryRegistrationNr  nvarchar(50),
                    ItemTigerId              int,
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
select distinct demand.Id                          as Id,
       DemandStatus                                as DemandStatus,
       DemandType                                  as DemandType,
       client.Code                                 as ClientCode,
       client.Name                                 as ClientName,
       client.Edino                                as Edino,    
       inventory.RegistrationNr                    as InventoryRegistrationNr,
	   item.TigerId                                as ItemTigerId,
       item.Code                                   as ItemCode,
       item.Name                                   as ItemName,
	   client.SaleChannel                          as SaleChannel,
	   demand.ConfirmedDate                        as ConfirmedDate,
       warehouse.Name                              as Warehouse

from IM_InventoryDemand demand with (nolock)
           join MD_Client client with (nolock) on client.TigerId = demand.ClientTigerId and client.Firm=demand.Firm
           join MD_Item item with (nolock) on item.TigerId = demand.ItemTigerId and item.Firm = demand.Firm
           join MD_Warehouse warehouse with (nolock) on warehouse.Nr = demand.Warehouse and warehouse.Firm = demand.Firm
           left join IM_InventoryDemandInventoryMapping inventorymapping with (nolock) on inventorymapping.InventoryDemandId = demand.Id
           left join IM_Inventory inventory with (nolock) on inventory.Id = inventorymapping.InventoryId
		   left join IM_TransportPackageDemandMapping mapping with (nolock) on demand.Id = mapping.InventoryDemandId
           left join IM_InventoryTransportPackage package with (nolock) on package.Id = mapping.TransportPackageId and package.PackageStatus = 3
		 
')
    if @IsAdmin = 0
        set @Query =
                concat(@Query, ' join  MD_PermittedWarehouse Permittedinput with (nolock) on Permittedinput.TigerWarehouseNr = demand.Warehouse  and Permittedinput.UserId = @currentUserId
   ')

   set @Query = concat(@Query,
                            ' where  demand.DemandStatus=1  and  not exists (
    select  1
    from IM_TransportPackageDemandMapping mapping with (nolock)
    join IM_InventoryTransportPackage package with (nolock)
        on package.Id = mapping.TransportPackageId
    where mapping.InventoryDemandId = demand.Id
      and package.PackageStatus in (0, 1, 2)
)')
    if @StartDate is not null or @EndDate is not null
        set @Query = concat(@Query,
                            ' and  (demand.CreationTime between @startDate and @endDate  )')
    if @itemNameCode is not null
        set @Query = concat(@Query,
                            ' and (item.Code LIKE ''%'' + @itemNameCode + ''%'' OR item.Name LIKE ''%'' + @itemNameCode + ''%'')')
	if @demandNo is not null
        set @Query = concat(@Query,
                            ' and (demand.Id = @demandNo )')
    if @clientNameCode is not null
        set @Query = concat(@Query,
                            ' and (client.Code LIKE ''%'' + @clientNameCode + ''%'' OR client.Name LIKE ''%'' + @clientNameCode + ''%'')')
    if @firm is not null
        set @Query = concat(@Query,
                            ' and  (demand.Firm = @firm)');
	    
	if @inventoryDemandType is not null
        set @Query = concat(@Query,
                            ' and  (demand.DemandType = @inventoryDemandType)');

    if @edino is not null
        set @Query = concat(@Query,
                            ' and (client.Edino like ''%'' + @edino + ''%'' )')
    if @inventoryRegistrationNr is not null
        set @Query = concat(@Query,
                            ' and (inventory.RegistrationNr  LIKE ''%'' + @inventoryRegistrationNr + ''%'' )')
    if @saleChannel is not null
        set @Query = concat(@Query,
                            ' and (client.SaleChannel  LIKE ''%'' + @saleChannel + ''%'' )')
    if @warehouseNrList is not null
        set @Query = concat(@Query,
                            ' and (demand.Warehouse in (select ltrim(Value) from F_SplitList(@warehouseNrList, '','')))')
	if @userIdList is not null
        set @Query = concat(@Query,
                            ' and (demand.CreatorUserId in (select ltrim(Value) from F_SplitList(@userIdList, '','')))')
	if @ignoredDemandIdList is not null 
        set @Query = concat(@Query,
                            ' and (demand.Id not in (select ltrim(Value) from F_SplitList(@ignoredDemandIdList, '','')))')

    set @Query = concat(@Query, ') 

	insert into @Result (Id,DemandStatus,DemandType,ClientCode,ClientName,Edino ,InventoryRegistrationNr ,ItemTigerId,ItemCode,ItemName,SaleChannel,ConfirmedDate, Warehouse)

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
                        @inventoryRegistrationNr nvarchar(500) null,
                        @inventoryDemandType tinyint null,
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
         @inventoryRegistrationNr=@inventoryRegistrationNr,
         @inventoryDemandType =@inventoryDemandType,
         @currentUserId =@currentUserId,
         @sorting =@sorting,
         @maxResultCount =@maxResultCount,
         @skipCount =@skipCount,
         @totalCount =@totalCount OUTPUT;