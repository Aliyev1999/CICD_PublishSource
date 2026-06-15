create procedure [dbo].[SP_IM_GetInventoryGeneralReportsQuery](@firm int null,
                                                              @tigerId int null,
                                                              @clientTigerId int null,
                                                              @registrationNr nvarchar(500) null,
                                                              @warehouseNr int null,
                                                              @divisionNr smallint null,
                                                              @departmentNr smallint null,
                                                              @itemNameOrCode nvarchar(500) null,
                                                              @clientNameOrCodeGroupCode nvarchar(500) null,
                                                              @startDate datetime null,
                                                              @endDate datetime null,
                                                              @inventoryStatuses nvarchar(500) null,
                                                              @producerCode nvarchar(500) null,
                                                              @groupCode nvarchar(500) null,
                                                              @specialCodes nvarchar(500) null,
                                                              @inventorySpecialCodes nvarchar(500) null,
                                                              @responsiblePersons nvarchar(500) null,
                                                              @responsiblePersons2 nvarchar(500) null,
                                                              @bulkClientCodes nvarchar(500) null,
                                                              @userId bigint null,
                                                              @salesmanTigerIds nvarchar(500) null,
                                                              @maxResultCount int,
                                                              @sorting nvarchar(500) null,
                                                              @skipCount int =0)
as
begin

-- Author: TayqaTech for TayqaSale (Kanan Mammadov)
-- Date: 12.12.2022 
-- Query: returns the result of general report in IM module


declare
    @Query nvarchar(max) ='
with InProgress as (select Inventory.Id                                   as InventoryId,
                           concat(FromClient.Code, '' -> '', ToClient.Code) as ClientCode,
                           concat(FromClient.Name, '' -> '', ToClient.Name) as ClientName,
                           1                                              as OrderNo
                    from IM_TransferDemand Demands with (nolock)
                             join IM_Inventory Inventory with (nolock) on Inventory.Id = Demands.InventoryId
                             join MD_Client FromClient with (nolock) on Demands.FromClientId = FromClient.TigerId and FromClient.Firm = Inventory.Firm
                             join MD_Client ToClient with (nolock) on Demands.ToClientId = ToClient.TigerId and ToClient.Firm = Inventory.Firm
                    where Demands.Status in (0, 1, 3, 4)
                    union
                    select Inventory.Id                                         as InventoryId,
                           concat(FromWarehouse.Nr, '' -> '', ToWarehouse.Nr)     as ClientCode,
                           concat(FromWarehouse.Name, '' -> '', ToWarehouse.Name) as ClientName,
                           1                                                    as OrderNo
                    from IM_WarehouseTransferLineInventory Lines with (nolock)
                             join IM_WarehouseTransfer Transfer with (nolock) on Transfer.Id = Lines.WarehouseTransferId
                             join MD_Warehouse FromWarehouse with (nolock) on FromWarehouse.Nr = Transfer.FromWarehouse and FromWarehouse.Firm = Transfer.Firm
                             join MD_Warehouse ToWarehouse with (nolock) on ToWarehouse.Nr = Transfer.ToWarehouse and ToWarehouse.Firm = Transfer.Firm
                             join IM_Inventory Inventory with (nolock) on Lines.InventoryId = Inventory.Id
                    where Lines.Status = 0),

     List as (select coalesce(InProgress.InventoryId, Others.InventoryId) as InventoryId,
                     coalesce(InProgress.ClientCode, Others.ClientCode)   as ClientCode,
                     coalesce(InProgress.ClientName, Others.ClientName)   as ClientName,
                     coalesce(Others.ClientId, 1)                         as ClientId

              from InProgress
                       full outer join (select Id             as InventoryId,
                                               Client.TigerId as ClientId,
                                               Client.Code    as ClientCode,
                                               Client.Name    as ClientName,
                                               2              as OrderNo
                                        from IM_Inventory Inventory with (nolock)
                                                 left join MD_Client Client with (nolock) on Client.TigerId = Inventory.ClientTigerId and Client.Firm = Inventory.Firm) Others
                                       on Others.InventoryId = InProgress.InventoryId),
Data as (
select Inventory.Id                    as InventoryId,
       Inventory.CostPrice             as InventoryCostPrice,
       Inventory.FirstInputCostPrice   as InventoryFirstInputCostPrice,
       Inventory.WarehouseNr           as InventoryWarehouseNr,
       Inventory.DivisionNr            as InventoryDivisionNr,
       Inventory.DepartmentNr          as InventoryDepartmentNr,
       Inventory.RegistrationNr        as InventoryRegistrationNr,
       Item.Name                       as InventoryItemName,
       Item.Code                       as InventoryItemCode,
       Firm.Name                       as InventoryFirmName,
       Inventory.Firm                  as InventoryFirmNr,
       Inventory.RegistrationDate      as InventoryRegistrationDate,
       Inventory.AmortizationBeginDate as InventoryAmortizationBeginDate,
       Inventory.AmortizationPercent   as InventoryAmortizationPercent,
       Inventory.AmortizationTerm      as InventoryAmortizationTerm,
       Inventory.CreationTime          as InventoryCreationTime,
       Inventory.StateId               as InventoryStateId,
       Item.GroupCode                  as InventoryEdino,
       CreatorUser.UserName            as InventoryCreatorUserName,
       Inventory.SerialNr              as InventorySerialNr,
       Inventory.ResponsiblePerson     as InventoryResponsiblePerson,
       Inventory.ResponsiblePerson2    as InventoryResponsiblePerson2,
       Inventory.Status                as InventoryStatus,
       Inventory.Description           as InventoryDescription,
       Inventory.SpecialCode           as InventorySpecialCode,
       Inventory.SpecialCode2          as InventorySpecialCode2,
       Inventory.SpecialCode3          as InventorySpecialCode3,
       Salesman.Name                   as InventoryResponsiblePersonName,
       Manager.Name                    as InventoryResponsiblePerson2Name,
       Division.Name                   as InventoryDivisionName,
       Firm.Nr                         as InventoryClientFirm,
       List.ClientId                   as InventoryClientTigerId,
       List.ClientCode                 as InventoryClientCode,
       List.ClientName                 as InventoryClientName,
       count(Item.TigerId) over ()     as TotalRecordCount
from List
         join IM_Inventory Inventory with (nolock) on Inventory.Id = List.InventoryId
         join MD_Firm Firm with (nolock) on Firm.Nr = Inventory.Firm and Firm.IsActive = 1
         join MD_Item Item with (nolock) on Item.TigerId = Inventory.TigerId and Inventory.Firm = Item.Firm
         join MD_Division Division with (nolock) on Division.Nr = Inventory.DivisionNr and Division.Firm = Inventory.Firm
         left join AbpUsers CreatorUser with (nolock) on Inventory.CreatorUserId = CreatorUser.Id
         left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = Inventory.ResponsiblePerson and Salesman.Firm = Inventory.Firm and Salesman.IsDeleted = 0
         left join MD_Salesman Manager with (nolock) on Manager.TigerId = Inventory.ResponsiblePerson2 and Manager.Firm = Inventory.Firm and Manager.IsDeleted = 0
where 1 = 1
'

if @firm is not null set @Query = concat(@Query, ' and Firm.Nr = @firm ')
if @tigerId is not null set @Query = concat(@Query, ' and Item.TigerId = @tigerId ')
if @clientTigerId is not null set @Query = concat(@Query, ' and List.ClientId = @clientTigerId ')
if @registrationNr is not null set @Query = concat(@Query, ' and (Inventory.RegistrationNr like ''%''+@registrationNr+''%'')')
if @warehouseNr is not null set @Query = concat(@Query, ' and Inventory.WarehouseNr = @warehouseNr ')
if @divisionNr is not null set @Query = concat(@Query, ' and Inventory.DivisionNr = @divisionNr ')
if @departmentNr is not null set @Query = concat(@Query, ' and Inventory.DepartmentNr = @departmentNr ')
if @warehouseNr is not null set @Query = concat(@Query, ' and Inventory.WarehouseNr = @warehouseNr ')
if @itemNameOrCode is not null set @Query = concat(@Query, ' and (Item.Code like ''%''+@itemNameOrCode+''%'' or Item.Name like ''%''+@itemNameOrCode+''%'')')
if @clientNameOrCodeGroupCode is not null
    set @Query = concat(@Query, ' and (List.ClientCode like ''%''+@clientNameOrCodeGroupCode+''%'' or List.ClientName like ''%''+@clientNameOrCodeGroupCode+''%'')')
if @startDate is not null set @Query = concat(@Query, ' and Inventory.RegistrationDate >= @startDate')
if @endDate is not null set @Query = concat(@Query, ' and Inventory.RegistrationDate <= @endDate')
if @inventoryStatuses is not null set @Query = concat(@Query, ' AND (Inventory.Status IN (SELECT LTRIM(Value) FROM F_SplitList(''', @inventoryStatuses, ''',', ''','')))')
if @producerCode is not null set @Query = concat(@Query, ' and (Item.ProducerCode like ''%''+@producerCode+''%'' or Item.ProducerName like ''%''+@producerCode+''%'')')
if @groupCode is not null set @Query = concat(@Query, ' and (Item.GroupCode like ''%''+@groupCode+''%'' or Item.GroupName like ''%''+@groupCode+''%'')')
if @specialCodes is not null
    set @Query = concat(@Query,
                        ' and (Item.SpecialCode like ''%''+@specialCodes+''%'' or Item.SpecialCode2 like ''%''+@specialCodes+''%'' or Item.SpecialCode3 like ''%''+@specialCodes+''%'' or Item.SpecialCode4 like ''%''+@specialCodes+''%'' or Item.SpecialCode5 like ''%''+@specialCodes+''%'')')
if @inventorySpecialCodes is not null
    set @Query = concat(@Query,
                        ' and (Inventory.SpecialCode like ''%''+@inventorySpecialCodes+''%'' or Inventory.SpecialCode2 like ''%''+@inventorySpecialCodes+''%'' or Inventory.SpecialCode like ''%''+@inventorySpecialCodes+''%'')')

if @responsiblePersons is not null set @Query = concat(@Query, ' AND (Inventory.Responsible IN (SELECT LTRIM(Value) FROM F_SplitList(''', @responsiblePersons, ''',', ''','')))')
if @responsiblePersons2 is not null set @Query = concat(@Query, ' AND (Inventory.Responsible2 IN (SELECT LTRIM(Value) FROM F_SplitList(''', @responsiblePersons2, ''',', ''','')))')
if @bulkClientCodes is not null set @Query = concat(@Query, ' AND (List.ClientCode IN (SELECT LTRIM(Value) FROM F_SplitList(''', @bulkClientCodes, ''',', ''','')))')

if @userId is not null
    set @Query = concat(@Query, ' AND (Inventory.ClientTigerId IN (select distinct ClientId
                                from MD_SalesmanClientMapping ClientMapping
                                         join UIM_UserEmployeeMapping SalesmanMapping
                                              on ClientMapping.SalesmanId = SalesmanMapping.EmployeeId and ClientMapping.Firm = SalesmanMapping.Firm and SalesmanMapping.Status = 0
                                where UserId = @userId))')

if @salesmanTigerIds is not null
    set @Query = concat(@Query, ' AND (Inventory.ClientTigerId IN (select distinct ClientId
                                                                    from MD_SalesmanClientMapping Mapping with (nolock)
                                                                    where Firm = @firm and SalesmanId in (select Value from F_SplitList(''', @salesmanTigerIds, ''',', ''',''))))')


set @Query = concat(@Query, ' ) select * from Data ')

if @skipCount is not null set @Query = concat(@Query, 'order by ' + @sorting + '  offset @skipCount rows fetch next @maxResultCount rows only')


    exec sp_executesql @Query, N'@firm int = 1,
    @tigerId int = null,
    @clientTigerId int = null,
    @registrationNr nvarchar(500) = null,
    @warehouseNr int = null,
    @divisionNr smallint = null,
    @departmentNr smallint = null,
    @itemNameOrCode nvarchar(500) = null,
    @clientNameOrCodeGroupCode nvarchar(500) = null,
    @startDate datetime = null,
    @endDate datetime = null,
    @inventoryStatuses nvarchar(500) = null,
    @producerCode nvarchar(500) = null,
    @groupCode nvarchar(500) = null,
    @specialCodes nvarchar(500) = null,
    @inventorySpecialCodes nvarchar(500) = null,
    @responsiblePersons nvarchar(500) = null,
    @responsiblePersons2 nvarchar(500) = null,
    @bulkClientCodes nvarchar(500) = null,
    @userId bigint = null,
    @salesmanTigerIds nvarchar(500) = null,
    @maxResultCount int = null,
    @sorting nvarchar(500) = null,
    @skipCount int =0',
         @firm = @firm,
         @tigerId = @tigerId,
         @clientTigerId = @clientTigerId,
         @registrationNr = @registrationNr,
         @warehouseNr = @warehouseNr,
         @divisionNr = @divisionNr,
         @departmentNr = @departmentNr,
         @itemNameOrCode = @itemNameOrCode,
         @clientNameOrCodeGroupCode = @clientNameOrCodeGroupCode,
         @startDate = @startDate,
         @endDate = @endDate,
         @inventoryStatuses = @inventoryStatuses,
         @producerCode = @producerCode,
         @groupCode = @groupCode,
         @specialCodes = @specialCodes,
         @inventorySpecialCodes = @inventorySpecialCodes,
         @responsiblePersons = @responsiblePersons,
         @responsiblePersons2 = @responsiblePersons2,
         @bulkClientCodes = @bulkClientCodes,
         @userId = @userId,
         @salesmanTigerIds = @salesmanTigerIds,
         @maxResultCount = @maxResultCount,
         @sorting = @sorting,
         @skipCount = @skipCount
end