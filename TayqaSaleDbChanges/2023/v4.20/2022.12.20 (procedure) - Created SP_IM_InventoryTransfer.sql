CREATE PROCEDURE [dbo].[SP_IM_InventoryTransfer](
    @startDate DATETIME NULL,
    @endDate DATETIME NULL,
    @firm SMALLINT NULL,
    @inventoryNr NVARCHAR(50) NULL,
    @statuses NVARCHAR(50) NULL,
    @packageId int NULL,
    @exitDivisions NVARCHAR(MAX) null,
    @exitWarehouses NVARCHAR(MAX) null,
    @entranceDivisions NVARCHAR(MAX) null,
    @entranceWarehouses NVARCHAR(MAX) null,
    @receiverUsers NVARCHAR(MAX) null,
    @actNumber NVARCHAR(50) null,
    @currentUserId INT null,
    @skipCount INT NULL,
    @takeCount INT NULL,
    @sort NVARCHAR(50) NULL)
AS
BEGIN

--Transfer hali ucun ekrana yuklenecek data-da yalniz bu serti odeyen baglamalari gosterek:
--Web istifadeci ucun hamisini gosterek
--Hibrid istifadeci ucun: 
--Ya baglamanin cixis is yerine ve anbarina yetkim olmalidir
--Ya baglamanin giris is yerine ve anbarina yetkim olmalidir
--Ya altimdaki istifadeciler ucun 1 ve ya 2-ci sert kecerlidir

-- Author: TayqaTech for TayqaSale (Kanan Mammadov)
-- Date: 08.12.2022
-- Query: returns the grid result for Inventory Transfer Planning screen in portal

    declare @IsAdminUser bit = (select dbo.FN_UIM_CheckUserIsAdmin(@currentUserId))
    declare @UserType nvarchar(10) = (select Type from F_GetRootTypeOfUsers() where UserId = @currentUserId)
    declare @filter nvarchar(max) = ' '

    if @IsAdminUser = 0 and @UserType = 'Hybrid'
        set @filter = '  and (Packages.FromWarehouse in (select ExitWarehouseNr
            from MD_PermittedTransferWarehousesMapping Mapping
                     join F_UIM_GetOrganizationTreeUsers(@currentUserId) Users on Users.UserId = Mapping.UserId and Firm = @firm)
                          or Packages.ToWarehouse in (select EnteranceWarehouseNr
            from MD_PermittedTransferWarehousesMapping Mapping
                     join F_UIM_GetOrganizationTreeUsers(@currentUserId) Users on Users.UserId = Mapping.UserId and Firm = @firm))'


    ------------------------------------------------------------------------------------------------------------------------------------

    declare @Query nvarchar(max) = '

select Firm.Name                                       as FirmName,
       Packages.Id                                     as PackageId,
       Packages.Status                                 as PackageStatus,
       FromDiv.Name                                    as ExitDivision,
       ToDiv.Name                                      as EntranceDivision,
       FromWho.Name                                    as ExitWarehouse,
       ToWho.Name                                      as EntranceWarehouse,
       Receiver.UserName                               as ReceiverUser,
       Packages.ActNumber                              as ActNumber,
       isnull(PackageCounts.ItemSort , 0)			   as ItemSort,
       isnull(PackageCounts.SentInventoryCount, 0)     as SentInventoryCount,
       isnull(PackageCounts.ReceivedInventoryCount, 0) as ReceivedInventoryCount,
       isnull(PackageCounts.RejectedInventoryCount, 0) as RejectedInventoryCount,
       Packages.IsActive                               as IsActive,
       Packages.CreationTime                           as CreationDate,
	   count(Packages.Id) over ()					   as TotalCount

from IM_WarehouseTransfer Packages with (nolock)
         join MD_Firm Firm with (nolock) on Firm.Nr = Packages.Firm
         join AbpUsers Receiver with (nolock) on Receiver.Id = Packages.ReceiverUserId

		 join MD_Division FromDiv with (nolock) on FromDiv.Firm=Packages.Firm and FromDiv.Nr = Packages.FromDivision
		 join MD_Division ToDiv with (nolock) on ToDiv.Firm=Packages.Firm and ToDiv.Nr = Packages.ToDivision
		 join MD_Warehouse FromWho with (nolock) on FromWho.Firm=Packages.Firm and FromWho.Nr = Packages.FromWarehouse
		 join MD_Warehouse ToWho with (nolock) on ToWho.Firm=Packages.Firm and ToWho.Nr = Packages.ToWarehouse

         left join (select Package.Id                             as PackageId,
                           count(distinct Lines.ItemId)           as ItemSort,
                           count(Inventories.InventoryId)         as SentInventoryCount,
                           sum(iif(Inventories.Status = 1, 1, 0)) as ReceivedInventoryCount,
                           sum(iif(Inventories.Status = 2, 1, 0)) as RejectedInventoryCount
                    from IM_WarehouseTransfer Package
                             join IM_WarehouseTransferLine Lines on Lines.WarehouseTransferId = Package.Id
                             left join IM_WarehouseTransferLineInventory Inventories
                                  on Inventories.WarehouseTransferId = Lines.WarehouseTransferId and Lines.ItemId = Inventories.ItemId
                             left join IM_Inventory Inventory with (nolock) on Inventory.Id = Inventories.InventoryId
                    where IsDeleted = 0 '

    if @inventoryNr is not null set @Query = CONCAT(@Query, ' and (Inventory.RegistrationNr like ''%''+@inventoryNr+''%'') ')

    set @Query = concat(@Query,
                        'group by Package.Id) PackageCounts on PackageCounts.PackageId = Packages.Id
                        where Packages.IsDeleted = 0 ', @filter)

	if @inventoryNr is not null set @Query = CONCAT(@Query, ' and (PackageCounts.PackageId is not null)')

    if @startDate is not null set @Query = concat(@Query, ' and CAST(Packages.CreationTime as Date) >= CAST(@startDate as Date) ')
    if @endDate is not null set @Query = concat(@Query, ' and CAST(Packages.CreationTime as Date) <= CAST(@endDate as date) ')
    if @firm is not null set @Query = concat(@Query, ' and Packages.Firm = @firm ')

    if @statuses is not null set @Query = concat(@Query, ' AND (Packages.Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @statuses, ''',', ''','')))')

    if @packageId is not null set @Query = concat(@Query, ' and Packages.Id = @packageId')

    if @exitDivisions is not null
        set @Query = concat(@Query, ' AND (Packages.FromDivision IN (SELECT LTRIM(Value) FROM F_SplitList(''', @exitDivisions, ''',', ''','')' +
                                                                                                                                      '))')
    if @entranceDivisions is not null
        set @Query = concat(@Query, ' AND (Packages.ToDivision IN (SELECT LTRIM(Value) FROM F_SplitList(''', @entranceDivisions, ''',', ''','')))')

    if @exitWarehouses is not null
        set @Query = concat(@Query, ' AND (Packages.FromWarehouse IN (SELECT LTRIM(Value) FROM F_SplitList(''', @exitWarehouses, ''',', ''','')))')

    if @entranceWarehouses is not null
        set @Query = concat(@Query, ' AND (Packages.ToWarehouse IN (SELECT LTRIM(Value) FROM F_SplitList(''', @entranceWarehouses, ''',', ''','')))')

    if @receiverUsers is not null
        set @Query = concat(@Query, ' AND (ReceiverUserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @receiverUsers, ''',', ''','')))')

    if @actNumber is not null set @Query = CONCAT(@Query, ' and (Packages.ActNumber like ''%''+@actNumber+''%'')')

    if @sort is not null or @skipCount is not null or @takeCount is not null
        set @Query = concat(@Query, ' order by ' + @sort + '
		offset @skipCount rows
		fetch next @takeCount rows only
')

    EXEC sp_executesql @Query, N'@startDate DATETIME NULL,
    @endDate DATETIME NULL,
    @firm SMALLINT NULL,
    @inventoryNr NVARCHAR(50) NULL,
    @statuses NVARCHAR(50) NULL,
    @packageId int NULL,
    @exitDivisions NVARCHAR(MAX) null,
    @exitWarehouses NVARCHAR(MAX) null,
    @entranceDivisions NVARCHAR(MAX) null,
    @entranceWarehouses NVARCHAR(MAX) null,
    @receiverUsers NVARCHAR(MAX) null,
    @actNumber NVARCHAR(50) null,
    @currentUserId INT null,
    @skipCount INT NULL,
    @takeCount INT NULL,
    @sort NVARCHAR(50) NULL',
         @startDate = @startDate,
         @endDate = @endDate,
         @firm = @firm,
         @inventoryNr = @inventoryNr,
         @statuses = @statuses,
         @packageId = @packageId,
         @exitDivisions = @exitDivisions,
         @exitWarehouses = @exitWarehouses,
         @entranceDivisions = @entranceDivisions,
         @entranceWarehouses = @entranceWarehouses,
         @receiverUsers = @receiverUsers,
         @actNumber = @actNumber,
         @currentUserId = @currentUserId,
         @skipCount = @skipCount,
         @takeCount = @takeCount,
         @sort = @sort
END