CREATE OR ALTER procedure [dbo].[SP_MD_GetPermittedTransferWarehousesMapping](
    @userId int
)
as
begin
    SELECT PTWM.Firm,
           WI.Nr         AS 'WarehouseIn',
           WO.Nr         AS 'WarehouseOut',
           WI.DivisionNr AS 'DivisionIn',
           WO.DivisionNr AS 'DivisionOut',
           OperationId,
           IsDefault
    FROM MD_PermittedTransferWarehousesMapping PTWM
             JOIN MD_Warehouse WI ON WI.Firm = PTWM.Firm AND WI.Nr = PTWM.EnteranceWarehouseNr
             JOIN MD_Warehouse WO ON WO.Firm = PTWM.Firm AND WO.Nr = PTWM.ExitWarehouseNr
    WHERE (WI.IsDeleted IS NULL OR WI.IsDeleted = 0)
      AND (WO.IsDeleted IS NULL OR WO.IsDeleted = 0)
      AND UserId = @userId
end
go

