ALTER procedure [dbo].[SP_IM_GetInventoryDemands](@clientCodeOrName nvarchar(500) null,
                                                  @itemNameOrCode nvarchar(500) null,
                                                  @creatorUserSpecodes nvarchar(500) null,
                                                  @demandNoInventoryNrContractNr nvarchar(500) null,
                                                  @endDate datetime null,
                                                  @startDate datetime null,
                                                  @firm smallint null,
                                                  @edino nvarchar(100) null,
                                                  @statusList nvarchar(500) null,
                                                  @userList nvarchar(500) = 0,
                                                  @inventoryDemandType tinyint null,
                                                  @isDocumented bit null,
                                                  @printStatus tinyint null,
                                                  @reserved bit null,
                                                  @step tinyint null,
                                                  @saleChannel nvarchar(500) null,
                                                  @loggedInUser int,
                                                  @isDeliveryRequired bit null,
                                                  @searchForDemandCreationTime bit)
as
begin

    declare @UserType nvarchar(100) = (select Type
                                       from F_GetRootTypeOfAllUsersIncludingInActive()
                                       where UserId = @loggedInUser)

    declare @sql nvarchar(max) =
        '
with Data as (select Demands.Id                                          as Id,
                     Inventory.RegistrationNr                            as InventoryRegistrationNr,
					 Inventory.Id								         as InventoryId,
                     Demands.ContractNr                                  as ContractNr,
                     Specodes.Specode1                                   as CreatorUserSpecode1,
                     Specodes.Specode2                                   as CreatorUserSpecode2,
                     Specodes.Specode3                                   as CreatorUserSpecode3,
					 Specodes.Specode4									 as CreatorUserSpecode4,
					 Specodes.Specode5									 as CreatorUserSpecode5,
                     cast(IsDocumented as bit)                           as IsDocumented,
                     cast(0 as bit)                                      as IsTransferDemand,
                     cast(iif(Images.Id is not null, 1, 0)    as bit)    as HasImages,
                     cast(Reserved as bit)                               as Reserved,
                     Demands.CreationTime                                as CreationTime,
                     CreatorUser.UserName                                as CreatorUserName,
                     Demands.Description collate Azeri_Latin_100_CI_AS   as Description,
                     Clients.SaleChannel                                 as SaleChannel,
                     InventoryState.Description                          as State,
                     Demands.Step                                        as Step,
                     CreatorUser.Id				                         as CreatorUserId,
                     Clients.Code                                        as ClientCode,
                     Clients.Name                                        as ClientName,
                     Clients.Edino                                       as Edino,
                     Items.Code                                          as ItemCode,
                     Items.Name                                          as ItemName,
                     Items.TigerId                                       as ItemTigerId,
                     Content.Name                                        as DemandReason,
                     cast(iif(Demands.DemandStatus = 5, 1, 0) as bit)    as Cancelled,
                     Demands.DemandStatus                                as DemandStatus,
					 cast(0 as tinyint)									 as TransferDemandStatus,
                     cast(0 as bit)										 as IsDeliveryRequired,
                     Demands.ConfirmedDate                               as ConfirmedDate,
                     Demands.ConfirmedDate2                              as ConfirmedDate2,
                     Demands.RejectedDate                                as RejectedDate,
                     Demands.RejectedDate2                               as RejectedDate2,
                     Demands.CancelledDate                               as CancelledDate,
					 CancelledUser.UserName                              as CancelledUserName,
                     ConfirmedUser.UserName                              as ConfirmedUserName,
                     ConfirmedUser.UserName                              as ConfirmedUserName2,
                     ConfirmedUser.UserName                              as ConfirmedUserFullName2,
                     ConfirmedUser.UserName                              as RejectedUserName2,
                     ConfirmedUser.UserName                              as RejectedUserName,
                     ConfirmedUser.UserName                              as RejectedUserFullName2,
                     DemandType                                          as DemandType,
                     Division.Name                                       as Division,
                     Warehouse.Name                                      as Warehouse,
                     Warehouse.Nr                                        as WarehouseNr,
                     Firm.Name                                           as FirmName,
                     Firm.Nr                                             as Firm,
                     PrintStatus,
                     CancelReason,
                     ParentUserDescription collate Azeri_Latin_100_CI_AS as ParentUserDescription,
                     ParentUserDescription collate Azeri_Latin_100_CI_AS as ParentUserDescription2,
                     ParentUserDescription collate Azeri_Latin_100_CI_AS as RejectedUserDescription2,
                     ParentUserDescription collate Azeri_Latin_100_CI_AS as ConfirmedUserDescription2,

                     Demands.ConfirmedUserId,
                     Demands.ConfirmedUserId2,
                     Demands.RejectedUserId,
                     Demands.RejectedUserId2                             as RejectedUserId2,
                     Demands.DocumentedDate                              as DocumentedDate,
                     Clients.Taxno                                       as ClientTaxNo


              from IM_InventoryDemand Demands with (nolock)
                       join MD_Firm Firm with (nolock) on Firm.Nr = Demands.Firm
                       join AbpUsers CreatorUser with (nolock) on CreatorUser.Id = Demands.CreatorUserId
                       join MD_Client Clients with (nolock) on Clients.Firm = Demands.Firm and Clients.TigerId = Demands.ClientTigerId
                       join MD_Item Items with (nolock) on Items.TigerId = Demands.ItemTigerId and Items.Firm = Clients.Firm
                       join IM_StaticContent Content with (nolock) on Content.Id = Demands.InventoryDemandReasonId
                  and ((Content.Type = 2 and Demands.DemandType = 1) or (Content.Type = 1 and Demands.DemandType = 2))
                       join MD_Division Division with (nolock) on Division.Nr = Demands.Division and Division.Firm = Demands.Firm
                       join MD_Warehouse Warehouse with (nolock) on Warehouse.Nr = Demands.Warehouse and Warehouse.Firm = Demands.Firm
                       left join AbpUsers ConfirmedUser with (nolock) on ConfirmedUser.Id = Demands.ConfirmedUserId
					   left join AbpUsers CancelledUser with (nolock) on CancelledUser.Id = Demands.CancelledUserId
                       left join IM_InventoryDemandImage Images with (nolock) on Images.InventoryDemandId = Demands.Id
                       left join IM_InventoryDemandInventoryMapping Mapping with (nolock) on Mapping.InventoryDemandId = Demands.Id
                       left join IM_Inventory Inventory on Inventory.Id = Mapping.InventoryId
                       left join UIM_UserProperty Specodes on Specodes.UserId = CreatorUser.Id and Specodes.Firm = Firm.Nr
                       left join IM_StaticContent InventoryState on Inventory.StateId = InventoryState.Id
              where Demands.DemandStatus not in (0, 2)
                --and ((@searchForDemandCreationTime = 1 and Demands.CreationTime between @startDate and @endDate)
                --      or (@searchForDemandCreationTime = 0 and Demands.ConfirmedDate between @startDate and @endDate and Demands.DemandStatus > 0))
				and ((@searchForDemandCreationTime = 1 and cast(Demands.CreationTime as date) between cast(@startDate as date) and cast(dateadd(day, -1, @endDate) as date))
                      or (@searchForDemandCreationTime = 0 and cast(Demands.ConfirmedDate as date) between cast(@startDate as date) and cast(dateadd(day, -1, @endDate) as date) and Demands.DemandStatus > 0))
                      and Firm.Nr = @firm


              union all


              select Transfer.Id                                                  as Id,
                     Inventory.RegistrationNr                                     as InventoryRegistrationNr,
					 Inventory.Id												  as InventoryId,
                     ''''                                                         as ContractNr,
                     Specodes.Specode1                                            as CreatorUserSpecode1,
                     Specodes.Specode2                                            as CreatorUserSpecode2,
                     Specodes.Specode3                                            as CreatorUserSpecode3,
					 Specodes.Specode4											  as CreatorUserSpecode4,
					 Specodes.Specode5											  as CreatorUserSpecode5,
                     cast(iif(DocumentedUserId is not null, 1, 0) as bit)         as IsDocumented,
                     cast(1 as bit)                                               as IsTransferDemand,
                     cast(iif(Images.Id is not null, 1, 0)    as bit)             as HasImages,
                     cast(0 as bit)                                               as Reserved,
                     Transfer.CreationTime                                        as CreationTime,
                     CreatorUser.UserName                                         as CreatorUserName,
                     Transfer.CreatedUserNote collate Azeri_Latin_100_CI_AS       as Description,
                     concat(FromClient.SaleChannel, '' - '', ToClient.SaleChannel)as SaleChannel,
                     InventoryState.Description                                   as State,
                     cast(1 as tinyint)                                           as Step,
                     CreatorUser.Id                                    as CreatorUserId,
                     concat(FromClient.Code, '' -> '', ToClient.Code)             as ClientCode,
                     concat(FromClient.Name, '' -> '', ToClient.Name)             as ClientName,
                     concat(FromClient.Edino, '' -> '', ToClient.Edino)           as Edino,
                     Items.Code                                                   as ItemCode,
                     Items.Name                                                   as ItemName,
                     Items.TigerId                                                as ItemTigerId,
                     Content.Name                                                 as DemandReason,
                     cast(iif(Transfer.Status = 6, 1, 0) as bit)                  as Cancelled,
                     cast(0 as tinyint)											  as DemandStatus,
                     Transfer.Status                                              as TransferDemandStatus,
					 Transfer.IsDeliveryRequired                                  as IsDeliveryRequired,
                     Transfer.ConfirmedDate                                       as ConfirmedDate,
                     Transfer.ConfirmedDate                                       as ConfirmedDate2,
                     Transfer.RejectedDate                                        as RejectedDate,
                     Transfer.RejectedDate                                        as RejectedDate2,
                     Transfer.CancelledDate                                       as CancelledDate,
                     CancelledUser.UserName                                       as CancelledUserName,
                     ConfirmedUser.UserName                                       as ConfirmedUserName,
                     ConfirmedUser.UserName                                       as ConfirmedUserName2,
                     ConfirmedUser.UserName                                       as ConfirmedUserFullName2,
                     RejectedUser.UserName                                        as RejectedUserName2,
                     RejectedUser.UserName                                        as RejectedUserName,
                     RejectedUser.UserName                                        as RejectedUserFullName2,
                     cast(3 as tinyint)                                           as DemandType,
                     Division.Name                                                as Division,
                     Warehouse.Name                                               as Warehouse,
                     Warehouse.Nr                                                 as WarehouseNr,
                     Firm.Name                                                    as FirmName,
                     Firm.Nr                                                      as Firm,
                     Transfer.PrintStatus                                         as PrintStatus,
                     CancelledUserDescription collate Azeri_Latin_100_CI_AS       as CancelReason,
                     coalesce(Transfer.ConfirmedUserDescription, Transfer.RejectedUserDescription) collate Azeri_Latin_100_CI_AS as ParentUserDescription,
                     coalesce(Transfer.ConfirmedUserDescription, Transfer.RejectedUserDescription) collate Azeri_Latin_100_CI_AS as ParentUserDescription2,
                     coalesce(Transfer.ConfirmedUserDescription, Transfer.RejectedUserDescription) collate Azeri_Latin_100_CI_AS as RejectedUserDescription2,
                     coalesce(Transfer.ConfirmedUserDescription, Transfer.RejectedUserDescription) collate Azeri_Latin_100_CI_AS as ConfirmedUserDescription2,
                     Transfer.ConfirmedUserId,
                     Transfer.ConfirmedUserId                                     as ConfirmedUserId2,
                     Transfer.RejectedUserId,
                     Transfer.RejectedUserId                                      as RejectedUserId2,
                     Transfer.ConfirmedDate                                       as DocumentedDate,
                     concat(FromClient.Taxno, '' - '', ToClient.Taxno)              as ClientTaxNo


              from IM_TransferDemand Transfer with (nolock)
                       join IM_Inventory Inventory with (nolock) on Inventory.Id = Transfer.InventoryId
                       join MD_Firm Firm with (nolock) on Firm.Nr = Inventory.Firm
                       join AbpUsers CreatorUser with (nolock) on CreatorUser.Id = Transfer.CreatorUserId
                       join MD_Client FromClient with (nolock) on FromClient.Firm = Inventory.Firm and FromClient.TigerId = Transfer.FromClientId
                       join MD_Client ToClient with (nolock) on ToClient.Firm = Inventory.Firm and ToClient.TigerId = Transfer.ToClientId
                       join MD_Item Items with (nolock) on Items.TigerId = Inventory.TigerId and Items.Firm = Inventory.Firm
                       join IM_StaticContent Content with (nolock) on Content.Id = Transfer.ReasonId
                       join MD_Division Division with (nolock) on Division.Nr = Transfer.DivisionNr and Division.Firm = Inventory.Firm
                       join MD_Warehouse Warehouse with (nolock) on Warehouse.Nr = Transfer.WarehouseNr and Warehouse.Firm = Inventory.Firm
                       left join AbpUsers ConfirmedUser with (nolock) on ConfirmedUser.Id = Transfer.ConfirmedUserId
                       left join AbpUsers CancelledUser with (nolock) on CancelledUser.Id = Transfer.CancelledUserId
					   left join AbpUsers RejectedUser with (nolock) on RejectedUser.Id = Transfer.RejectedUserId
                       left join IM_TransferDemandImages Images with (nolock) on Images.TransferDemandId = Transfer.Id
                       left join UIM_UserProperty Specodes on Specodes.UserId = CreatorUser.Id and Specodes.Firm = Firm.Nr
                       left join IM_StaticContent InventoryState on Inventory.StateId = InventoryState.Id
              where 
			  ((@searchForDemandCreationTime = 1 and cast(Transfer.CreationTime as date) between cast(@startDate as date) and cast(dateadd(day, -1, @endDate) as date))
                     or (@searchForDemandCreationTime = 0 and cast(Transfer.ConfirmedDate as date) between cast(@startDate as date) and cast(dateadd(day, -1, @endDate) as date)))
			  --((@searchForDemandCreationTime = 1 and Transfer.CreationTime between @startDate and @endDate)
     --                or (@searchForDemandCreationTime = 0 and Transfer.ConfirmedDate between @startDate and @endDate))
                     and Firm.Nr = @firm AND Transfer.Status NOT IN (0, 2))

select distinct Data.*
from Data
         left join [F_UIM_GetOrganizationTreeAllUsersIncludeInActiveDeleted](@loggedInUser) u on u.UserId = Data.CreatorUserId and u.ParentType in (''App'', ''Hybrid'')

where ((@UserType = ''Hybrid'' and u.UserId is not null)
    or (@UserType <> ''Hybrid''))

'

    if @clientCodeOrName is not null
        set @sql = concat(@sql,
                          ' and (ClientCode like ''%''+@clientCodeOrName+''%'' or ClientName like ''%''+@clientCodeOrName+''%'')')

    if @itemNameOrCode is not null
        set @sql = concat(@sql,
                          ' and (ItemName like ''%''+@itemNameOrCode+''%'' or ItemCode like ''%''+@itemNameOrCode+''%'')')

    if @creatorUserSpecodes is not null
        set @sql = concat(@sql,
                          ' and (CreatorUserSpecode1 like ''%''+@creatorUserSpecodes+''%'' or CreatorUserSpecode2 like ''%''+@creatorUserSpecodes+''%'' or CreatorUserSpecode3 like ''%''+@creatorUserSpecodes+''%'' or CreatorUserSpecode4 like ''%'' +@creatorUserSpecodes+ ''%'' or CreatorUserSpecode5 like ''%'' +@creatorUserSpecodes+ ''%'')')

    if @demandNoInventoryNrContractNr is not null
        set @sql = concat(@sql,
                          ' and (InventoryRegistrationNr like ''%''+@demandNoInventoryNrContractNr+''%'' or Id like ''%''+@demandNoInventoryNrContractNr+''%'' or ContractNr like ''%''+@demandNoInventoryNrContractNr+''%'')')

    if @userList is not null
        set @sql = concat(@sql, ' AND (CreatorUserId IN (SELECT LTRIM(Value) FROM F_SplitList(''', @userList, ''',', ''','')))')

    if @inventoryDemandType is not null
        set @sql = concat(@sql, ' and (DemandType = @inventoryDemandType)')

    if @isDocumented is not null
        set @sql = concat(@sql, ' and (IsDocumented = @isDocumented)')

    if @printStatus is not null
        set @sql = concat(@sql, ' and (PrintStatus = @printStatus)')

    if @reserved is not null
        set @sql = concat(@sql, ' and Reserved = @reserved')

    if @step is not null
        set @sql = concat(@sql, ' and Step = @step')

    if @saleChannel is not null
        set @sql = concat(@sql, ' and (SaleChannel like ''%''+@saleChannel+''%'')')

    if @edino is not null
        set @sql = concat(@sql, ' and (Edino like ''%''+@edino+''%'')')

    if @isDeliveryRequired is not null
        set @sql = concat(@sql, ' and (IsDeliveryRequired = @isDeliveryRequired)')


    if @statusList is not null
        begin
            declare @statusFilter nvarchar(max)=' AND ( ';

            if CHARINDEX('1', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  DemandStatus = 1 OR TransferDemandStatus = 1 OR');
                END

            if CHARINDEX('3', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  DemandStatus = 3 OR');
                END

            if CHARINDEX('4', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  DemandStatus = 4 OR TransferDemandStatus = 5 OR');
                END

            if CHARINDEX('5', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  DemandStatus = 5 OR TransferDemandStatus = 6 OR');
                END

            if CHARINDEX('6', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  TransferDemandStatus = 3 OR');
                END

            if CHARINDEX('7', @statusList) > 0
                BEGIN
                    set @statusFilter = concat(@statusFilter, '  TransferDemandStatus = 4 OR');
                END

            set @statusFilter = concat(LEFT(@statusFilter, len(@statusFilter) - 2), ' )');
            set @sql = concat(@sql, @statusFilter);
        end

    --insert into QueryResultTest (String) values (@sql)

    EXEC sp_executesql @sql,
         N' @clientCodeOrName nvarchar(500) ,
            @itemNameOrCode nvarchar(500) ,
            @creatorUserSpecodes nvarchar(500) ,
            @demandNoInventoryNrContractNr nvarchar(500) ,
            @endDate datetime ,
            @startDate datetime ,
            @firm smallint ,
			@edino nvarchar(100),
            @statusList nvarchar(500) ,
            @userList nvarchar(500) ,
            @inventoryDemandType tinyint ,
            @isDocumented bit ,
            @printStatus tinyint ,
            @reserved bit ,
            @step tinyint ,
            @saleChannel nvarchar(500),
            @loggedInUser int,
            @UserType nvarchar(100),
            @isDeliveryRequired tinyint,
            @searchForDemandCreationTime bit',
         @clientCodeOrName=@clientCodeOrName,
         @itemNameOrCode=@itemNameOrCode,
         @creatorUserSpecodes=@creatorUserSpecodes,
         @demandNoInventoryNrContractNr=@demandNoInventoryNrContractNr,
         @endDate=@endDate,
         @startDate=@startDate,
         @firm=@firm,
         @edino=@edino,
         @statusList=@statusList,
         @userList=@userList,
         @inventoryDemandType=@inventoryDemandType,
         @isDocumented=@isDocumented,
         @printStatus=@printStatus,
         @reserved=@reserved,
         @step=@step,
         @saleChannel=@saleChannel,
         @loggedInUser=@loggedInUser,
         @UserType=@UserType,
         @isDeliveryRequired = @isDeliveryRequired,
         @searchForDemandCreationTime=@searchForDemandCreationTime
    print (cast(@sql as ntext))

end
GO


