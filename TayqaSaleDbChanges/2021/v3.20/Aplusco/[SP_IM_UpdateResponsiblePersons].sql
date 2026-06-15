ALTER PROCEDURE [dbo].[SP_IM_UpdateResponsiblePersons] as

with [Data] as
         (select Inventories.ResponsiblePerson  as ResponsiblePerson,
                 Inventories.ResponsiblePerson2 as ResponsiblePerson2,
                 Demands.CreationTime           as CreationTime,
                 Inventories.RegistrationNr     as RegNr,
                 Creator.TigerId                as Creator,
                 Confirmer.TigerId              as Confirmer
          from IM_Inventory Inventories
                   join IM_InventoryDemandInventoryMapping Mappings on Mappings.InventoryId = Inventories.Id
                   join IM_InventoryDemand Demands on Demands.Id = Mappings.InventoryDemandId and Demands.DemandType = 1
                   left join UIM_UserProperty CreatorProperty on CreatorProperty.UserId = Demands.CreatorUserId
                   left join UIM_UserProperty ConfirmerProperty on ConfirmerProperty.UserId = Demands.ConfirmedUserId
                   left join MD_Salesman Creator
                             on Demands.Firm = Creator.Firm and Creator.Code = CreatorProperty.Specode2
                   left join MD_Salesman Confirmer
                             on Demands.Firm = Confirmer.Firm and Confirmer.Code = ConfirmerProperty.Specode2
          where Inventories.Status = 4
            and Demands.DemandStatus = 4
            and Demands.CompletedDate is not null
            and Demands.CompletedDate >= dateadd(minute, -20, getdate()))
update [Data]
set ResponsiblePerson  = Creator,
    ResponsiblePerson2 = Confirmer
where [Data].CreationTime = (select max(InDemand.CreationTime)
                             from IM_InventoryDemand InDemand
                                      JOIN IM_InventoryDemandInventoryMapping InMap
                                           ON InDemand.Id = InMap.InventoryDemandId
                                      JOIN IM_Inventory InInventory
                                           ON InInventory.Id = InMap.InventoryId AND InInventory.RegistrationNr = RegNr);


update IM_Inventory
set ResponsiblePerson  = null,
    ResponsiblePerson2 = null
where Status in (0, 1, 2, 7)


