CREATE OR ALTER FUNCTION [dbo].[F_IM_GetTransportPackageInventoryDemands](@transportPackageId int)
    Returns Table
        AS
        RETURN(

        select demand.Id                                                     as Id,
               DemandStatus                                                  as DemandStatus,
               DemandType                                                    as DemandType,
               client.Code                                                   as ClientCode,
               client.Name                                                   as ClientName,
               client.Edino                                                  as Edino,
               inventory.RegistrationNr                                      as InventoryRegistrationNr,
               item.Code                                                     as ItemCode,
               item.Name                                                     as ItemName,
               CAST(row_number() over (order by demand.Id desc) as smallint) as OrderNo,
               warehouse.Name                                                as Warehouse

        from IM_InventoryDemand demand with (nolock)
                 join IM_TransportPackageDemandMapping mapping with (nolock) on demand.Id = mapping.InventoryDemandId
                 join IM_InventoryTransportPackage package with (nolock) on package.Id = mapping.TransportPackageId
                 left join IM_InventoryDemandInventoryMapping inventorymapping with (nolock)
                           on inventorymapping.InventoryDemandId = demand.Id
                 left join IM_Inventory inventory with (nolock) on inventory.Id = inventorymapping.InventoryId
                 left join MD_Client client with (nolock) on client.TigerId = demand.ClientTigerId and client.Firm=demand.Firm
                 left join MD_Item item with (nolock) on item.TigerId = demand.ItemTigerId and item.Firm = demand.Firm
                 left join MD_Warehouse warehouse with (nolock)
                           on warehouse.Nr = demand.Warehouse and warehouse.Firm = demand.Firm
        where mapping.TransportPackageId = @transportPackageId)