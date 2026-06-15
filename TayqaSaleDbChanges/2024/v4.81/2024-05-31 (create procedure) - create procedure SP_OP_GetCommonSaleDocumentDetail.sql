create procedure [dbo].[SP_OP_GetCommonSaleDocumentDetail](@requestId int)
as
begin
    select concat(Users.Name, ' ', Users.Surname, ' (', Users.UserName, ')')                                      as [User],
           concat(Salesman.Name, ' ', ' (', Salesman.Code, ')')                                                   as Representative,
           concat(Client.Name, ' ', ' (', Client.Code, ')')                                                       as Client,
           ILog.ProcessDate                                                                                       as DocumentDate,
           ILog.DocCreatedTime                                                                                    as CreationDate,
           ILog.RegisteredDate                                                                                    as DateToSent,
           ILog.GpsLatitude                                                                                       as OperationLatitude,
           ILog.GpsLongitude                                                                                      as OperationLongitude,
           isnull(sum( isnull(RequestQueue.Amount, Line2.Amount) * 
				isnull(RequestQueue.Price, Line.Price))	,0)														  as GrossAmount,

            isnull(sum(iif(Line2.Amount=0 or RequestQueue.Amount=0,0,Line.DiscountAmount)),0) as DiscountAmount,

            isnull(sum(iif(isnull(RequestQueue.IsPromo, Line2.IsPromo) = 1, isnull(RequestQueue.Amount, Line2.Amount), 0) *
				isnull(RequestQueue.Price, Line.Price)),0)                                                           as PromoAmount,

           isnull(sum(iif(iif(isnull(RequestQueue.IsPromo, Line2.IsPromo) = 0, isnull(RequestQueue.Amount, Line2.Amount), 0) * 
				isnull(RequestQueue.Price, Line.Price) - 
				isnull(Line.DiscountAmount, RequestQueue.DiscountAmount)<0,0,iif(isnull(RequestQueue.IsPromo, Line2.IsPromo) = 0, isnull(RequestQueue.Amount, Line2.Amount), 0) * 
				isnull(RequestQueue.Price, Line.Price) - 
				isnull(Line.DiscountAmount, RequestQueue.DiscountAmount))),0)										              as NetAmount,
           concat(Division.Name, ' ', ' (', Division.Nr, ')')                                                     as Division,
           concat(Warehouse.Name, ' ', ' (', Warehouse.Nr, ')')                                                   as Warehouse,
           ILog.Specode                                                                                           as Specode,
           ILog.Note                                                                                              as Note,
           ILog.DocNumber                                                                                         as DocNumber,
           ILog.AuthCode                                                                                          as AuthorizationCode,
           Client.Latitude                                                                                        as ClientLatitude,
           Client.Longitude                                                                                       as ClientLongitude
    from OP_ThirdPartyIncomingLog ILog with (nolock)
             join AbpUsers Users with (nolock) on ILog.UserId = Users.Id
             left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = ILog.SalesmanRef
             join MD_Client Client with (nolock) on Client.TigerId = ILog.ClientId
            left join OP_ThirdPartyIncomingLogCommonLineExtension Line with (nolock) on Line.Id = ILog.Id 
             left join OP_ThirdPartyRequestQueueCommonLineExtension RequestQueue with (nolock) on RequestQueue.Id = ILog.Id and line.ItemId = RequestQueue.ItemId and Line.IsPromo = RequestQueue.IsPromo 
             left join OP_ThirdPartyCommonLineResultLog Line2 with (nolock) on Line2.Id = ILog.Id and Line.IsPromo = Line2.IsPromo and Line.ItemId = Line2.ItemId
             left join MD_Division Division with (nolock) on Division.Nr = ILog.Division
             left join OP_ThirdPartyIncomingLogCommonExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
             left join MD_Warehouse Warehouse with (nolock) on WarehouseId.WhouseNr = Warehouse.Nr and Warehouse.Firm = ILog.Firm
    where ILog.DocType in (0, 1, 2, 3, 4)
      and ILog.Id = @requestId
    group by concat(Users.Name, ' ', Users.Surname, ' (', Users.UserName, ')'),
             concat(Salesman.Name, ' ', ' (', Salesman.Code, ')'), concat(Client.Name, ' ', ' (', Client.Code, ')'),
             ILog.DocCreatedTime, ILog.RegisteredDate, ILog.ProcessDate, ILog.GpsLatitude, ILog.GpsLongitude,
             concat(Division.Name, ' ', ' (', Division.Nr, ')'),
             concat(Warehouse.Name, ' ', ' (', Warehouse.Nr, ')'), ILog.Specode,
             ILog.Note, ILog.DocNumber, ILog.AuthCode, Client.Latitude, Client.Longitude

end