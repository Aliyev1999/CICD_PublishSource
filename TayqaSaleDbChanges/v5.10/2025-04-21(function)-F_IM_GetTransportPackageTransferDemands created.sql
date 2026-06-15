CREATE OR ALTER FUNCTION [dbo].[F_IM_GetTransportPackageTransferDemands](@transportPackageId int)
    Returns Table
        AS
        RETURN(

        select demand.Id                                                     as Id,
               package.PackageStatus                                         as DemandStatus,
               package.PackageDemandType                                     as DemandType,
               fromclient.Code                                               as FromClientCode,
               fromclient.Name                                               as FromClientName,
               fromclient.Edino                                              as FromClientEdino,
               toclient.Code                                                 as ToClientCode,
               toclient.Name                                                 as ToClientName,
               toclient.Edino                                                as ToClientEdino,
               inventory.RegistrationNr                                      as InventoryRegistrationNr,
               item.Code                                                     as ItemCode,
               item.Name                                                     as ItemName,
               Cast(row_number() over (order by demand.Id desc) as smallint) as OrderNo,
               warehouse.Name                                                as Warehouse
        from IM_TransferDemand demand with (nolock)
                 join IM_TransportPackageTransferDemandMapping mapping with (nolock)
                      on demand.Id = mapping.TransferDemandId
                 join IM_InventoryTransportPackage package with (nolock) on package.Id = mapping.TransportPackageId
                 join IM_Inventory inventory with (nolock) on inventory.Id = demand.InventoryId
                 left join MD_Client fromclient with (nolock) on fromclient.TigerId = demand.FromClientId
                 left join MD_Client toclient with (nolock) on toclient.TigerId = demand.ToClientId
                 left join MD_Item item with (nolock) on item.TigerId = inventory.TigerId and item.Firm = inventory.Firm
                 left join MD_Warehouse warehouse with (nolock)
                           on warehouse.Nr = demand.WarehouseNr and warehouse.Firm = inventory.Firm
        where package.Id = @transportPackageId)