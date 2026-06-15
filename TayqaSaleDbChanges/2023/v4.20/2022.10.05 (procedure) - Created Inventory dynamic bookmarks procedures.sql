
CREATE   procedure [dbo].[SP_IM_GetPrintInventoryDemandEquipmentActBookmarks] @inventoryDemandId int
AS
--SELECT TOP 0 'Kanan' AS Name, 'Kanan de ala men' AS Value

select top 0 'CreatorUser' as Name, u.UserName as Value from IM_InventoryDemand d
join AbpUsers u on u.Id=d.CreatorUserId
where d.Id = @inventoryDemandId
GO
 
CREATE   procedure [dbo].[SP_IM_GetPrintInventoryDemandRegistrationActBookmarks] @inventoryDemandId int
AS
--SELECT TOP 0 'Ramil' AS Name, 'Ramilem de ala men' AS Value
select top 0 'CompletedUser' as Name, u.UserName as Value from IM_InventoryDemand d
join AbpUsers u on u.Id=d.CompletedUserId
where d.Id = @inventoryDemandId
GO

CREATE   procedure [dbo].[SP_IM_GetPrintTransferDemandRegistrationActBookmarks] @transferDemandId int
AS
--SELECT TOP 0 'Ceyhun' AS Name, 'Ceyhun de ala men' AS Value
select top 0 'CreatorUser' as Name, u.UserName as Value from IM_TransferDemand d
join AbpUsers u on u.Id=d.CreatorUserId
where d.Id = @transferDemandId 

