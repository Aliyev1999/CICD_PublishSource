create procedure [dbo].[SP_OP_GetWarehouseDocumentDetail](@requestId int)
as
begin
select concat(Users.Name, ' ', Users.Surname, ' (', Users.UserName, ')') as [User],
       ILog.ProcessDate                                               as DocumentDate,
       ILog.DocCreatedTime                                               as CreationDate,
       ILog.RegisteredDate                                                  as DateToSent,
       ILog.GpsLatitude                                                  as OperationLatitude,
       ILOg.GpsLongitude                                                 as OperationLongitude,
       Client.Latitude                                                   as ClientLatitude,
       Client.Longitude                                                  as ClientLongitude,
       concat(OutDivision.Name, ' ', ' (', OutDivision.Nr, ')')          as SourceDivision,
       concat(OutWarehouse.Name, ' ', ' (', OutWarehouse.Nr, ')')        as SourceWarehouse,
       concat(InDivision.Name, ' ', ' (', InDivision.Nr, ')')            as EntryDivision,
       concat(InWarehouse.Name, ' ', ' (', InWarehouse.Nr, ')')          as EntryWarehouse,
       ILog.Specode                                                      as Specode,
       ILog.Note                                                         as Note,
       ILog.DocNumber                                                    as DocNumber,
       ILog.AuthCode                                                     as AuthorizationCode
from OP_ThirdPartyIncomingLog ILog with (nolock)
         join AbpUsers Users with (nolock) on ILog.UserId = Users.Id
         left join MD_Client Client with (nolock) on Client.TigerId = ILog.ClientId
         left join OP_ThirdPartyIncomingLogWarehouseOperationExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
         left join MD_Warehouse InWarehouse with (nolock) on WarehouseId.WarehouseIn = InWarehouse.Nr
         left join MD_Warehouse OutWarehouse with (nolock) on WarehouseId.WarehouseOut = OutWarehouse.Nr
         left join MD_Division InDivision with (nolock) on WarehouseId.DivisionIn = InDivision.Nr
         left join MD_Division OutDivision with (nolock) on OutDivision.Nr = WarehouseId.DivisionOut
where ILog.DocType in (21, 22, 23, 24)
and @requestId=ILog.Id
end



