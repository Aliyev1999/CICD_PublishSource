
ALTER FUNCTION [dbo].[F_IM_GetInventoryFullHistoryReport](@inventoryId int,
    @startDate datetime null, @endDate datetime null, @sourceTypes nvarchar(200) null)
    -- Modified by Shahri Yahyayeva to add warehouse transfers
    -- Last modified by Kanan Mammadov to add client transfer demands

    RETURNS @fullHistory TABLE
                         (
                             OperationId   INT,
                             InventoryId   INT,
                             ClientCode    NVARCHAR(max),
                             ClientName    NVARCHAR(max),
                             CreatedDate   DATETIME,
                             EndDate       DATETIME,
                             UserName      NVARCHAR(max),
                             OperationType TINYINT,
                             SourceType    NVARCHAR(max),
                             HasImages     BIT
                         )
    as
    begin
        if CHARINDEX('TransferDemand', @sourceTypes) > 0 or @sourceTypes is null
            BEGIN
                insert into @fullHistory
                SELECT transferDemand.Id                        as OperationId,
                       inventory.Id                             as InventoryId,
                       fromClient.Code + ' -> ' + toClient.Code as ClientCode,
                       fromClient.Name + ' -> ' + toClient.Name as ClientName,
                       transferDemand.CreationTime              as CreatedDate,
                       transferDemand.CompletedDate             as EndDate,
                       creatorUser.UserName                     as UserName,
                       CAST(1 as tinyint)                       as OperationType,
                       'TransferDemand'                         as SourceType,
                       CASE
                           WHEN (SELECT COUNT(*)
                                 FROM IM_TransferDemandImages
                                 WHERE IM_TransferDemandImages.TransferDemandId = transferDemand.Id) > 0
                               THEN CONVERT(Bit, 1)
                           ELSE CONVERT(Bit, 0)
                           END                                  as HasImages
                FROM IM_Inventory inventory WITH (NOLOCK)
                         JOIN IM_TransferDemand transferDemand WITH (NOLOCK)
                              ON inventory.Id = transferDemand.InventoryId
                         JOIN MD_Client toClient WITH (NOLOCK)
                              ON transferDemand.ToClientId = toClient.TigerId AND inventory.Firm = toClient.Firm
                         JOIN MD_Client fromClient WITH (NOLOCK)
                              ON transferDemand.FromClientId = fromClient.TigerId AND inventory.Firm = fromClient.Firm
                         LEFT JOIN AbpUsers creatorUser WITH (NOLOCK) on transferDemand.CreatorUserId = creatorUser.Id
                where inventory.Id = @inventoryId
                  AND (@startDate Is NULL OR transferDemand.CreationTime >= @startDate)
                  AND (@endDate Is NULL OR transferDemand.CreationTime <= @endDate)
            END
        if CHARINDEX('InventoryDemand', @sourceTypes) > 0 or @sourceTypes is null
            BEGIN
                insert into @fullHistory
                SELECT id.Id                as OperationId,
                       inv.Id               as InventoryId,
                       c.Code               as ClientCode,
                       c.Name               as ClientName,
                       id.CreationTime      as CreatedDate,
                       id.CompletedDate     as EndDate,
                       creatorUser.UserName as UserName,
                       id.DemandType        as OperationType,
                       'InventoryDemand'    as SourceType,

                       CASE
                           WHEN (SELECT COUNT(*)
                                 FROM IM_InventoryDemandImage
                                 WHERE IM_InventoryDemandImage.InventoryDemandId = id.Id) > 0 THEN CONVERT(Bit, 1)
                           ELSE CONVERT(Bit, 0)
                           END              as HasImages

                FROM IM_Inventory inv WITH (NOLOCK)
                         JOIN MD_Item i WITH (NOLOCK) on inv.Firm = i.Firm AND inv.TigerId = i.TigerId
                         JOIN IM_InventoryDemandInventoryMapping idm WITH (NOLOCK) on idm.InventoryId = inv.Id
                         JOIN IM_InventoryDemand id WITH (NOLOCK) on idm.InventoryDemandId = id.Id
                         JOIN MD_Client c WITH (NOLOCK) on id.Firm = c.Firm AND id.ClientTigerId = c.TigerId
                         LEFT JOIN AbpUsers creatorUser WITH (NOLOCK) on id.CreatorUserId = creatorUser.Id
                where inv.Id = @inventoryId
                  AND (@startDate Is NULL OR id.CreationTime >= @startDate)
                  AND (@endDate Is NULL OR id.CreationTime <= @endDate)
            END
        if CHARINDEX('InventoryStateHistory', @sourceTypes) > 0 or @sourceTypes is null
            BEGIN
                insert into @fullHistory
                SELECT stateHistory.Id               as OperationId,
                       inv.Id                        as InventoryId,
                       c.Code                        as ClientCode,
                       c.Name                        as ClientName,
                       stateHistory.CreatedDate      as CreatdedDate,
                       stateHistory.CreatedDate      as EndDate,
                       creatorUser.UserName          as UserName,
                       stateHistory.StateHistoryType as OperationType,
                       'InventoryStateHistory'       as SourceType,

                       CASE
                           WHEN (SELECT COUNT(*)
                                 FROM IM_InventoryStateHistoryImage
                                 WHERE IM_InventoryStateHistoryImage.InventoryStateHistoryId = stateHistory.Id) > 0
                               THEN CONVERT(Bit, 1)
                           ELSE CONVERT(Bit, 0)
                           END                       as HasImages

                FROM IM_InventoryStateHistory stateHistory WITH (NOLOCK)
                         JOIN IM_Inventory inv WITH (NOLOCK) on stateHistory.InventoryId = inv.Id
                         JOIN MD_Item i WITH (NOLOCK) on inv.Firm = i.Firm AND inv.TigerId = i.TigerId
                         JOIN MD_Client c WITH (NOLOCK)
                              on stateHistory.ClientTigerId = c.TigerId AND stateHistory.Firm = c.Firm
                         LEFT JOIN AbpUsers creatorUser WITH (NOLOCK) on stateHistory.CreatorUserId = creatorUser.Id
                where stateHistory.InventoryId = @inventoryId
                  AND (@startDate Is NULL OR stateHistory.CreatedDate >= @startDate)
                  AND (@endDate Is NULL OR stateHistory.CreatedDate <= @endDate)
            END
        if CHARINDEX('WarehouseTransfer', @sourceTypes) > 0 or @sourceTypes is null
            BEGIN
                insert into @fullHistory
                select wtransfer.Id                                   as OperationId,
                       inventory.Id                                   as InventoryId,
                       concat(fromwhouse.Nr, ' -> ', towhouse.Nr)     as ClientCode,
                       concat(fromwhouse.Name, ' -> ', towhouse.Name) as ClientName,
                       wtransfer.CreationTime                         as CreatedDate,
                       wtransfer.CompletedDate                        as EndDate,
                       creatoruser.UserName                           as UserName,
                       cast(1 as tinyint)                             as OperationType,
                       'WarehouseTransfer'                            as SourceType,
                       cast(0 as bit)                                 as HasImages
                from IM_Inventory inventory with (nolock)
                         join IM_WarehouseTransferLineInventory wInventory with (nolock) on inventory.ID = wInventory.InventoryId
                         join IM_WarehouseTransfer wtransfer with (nolock) on wtransfer.Id = wInventory.WarehouseTransferId
                         join MD_Warehouse towhouse with (nolock) on towhouse.Nr = wtransfer.ToWarehouse and towhouse.Firm = wtransfer.Firm
                         join MD_Warehouse fromwhouse with (nolock) on fromwhouse.Nr = wtransfer.FromWarehouse and fromwhouse.Firm = wtransfer.Firm
                         left join AbpUsers creatoruser with (nolock) on wtransfer.CreatorUserId = creatoruser.Id
                where inventory.Id = @inventoryId
                  AND (@startDate Is NULL OR wtransfer.CreationTime >= @startDate)
                  AND (@endDate Is NULL OR wtransfer.CreationTime <= @endDate)
            END
        if CHARINDEX('RepairDemand', @sourceTypes) > 0 or @sourceTypes is null
            Begin
                insert into @fullHistory
                select d.Id               as OperationId,
                       d.InventoryId      as InventoryId,
                       c.Code             as ClientCode,
                       c.Name             as ClientName,
                       d.CreationTime     as CreatedDate,
                       d.CreationTime     as EndDate,
                       u.UserName         as UserName,
                       cast(1 as tinyint) as OperationType,
                       'RepairDemand'     as SourceType,

                       CASE
                           WHEN (SELECT COUNT(*)
                                 FROM IM_RepairAttachment
                                 WHERE IM_RepairAttachment.ReferenceId = d.Id
                                   and Type = 1) > 0
                               THEN CONVERT(Bit, 1)
                           ELSE CONVERT(Bit, 0)
                           END            as HasImages

                from IM_RepairDemand d with (nolock)
                         join MD_Client c with (nolock) on d.ClientId = c.TigerId and d.Firm = c.Firm
                         left join AbpUsers u with (nolock) on d.CreatorUserId = u.Id
                where d.InventoryId = @inventoryId
                  AND (@startDate Is NULL OR d.CreationTime >= @startDate)
                  AND (@endDate Is NULL OR d.CreationTime <= @endDate)
            End

        RETURN;
    end