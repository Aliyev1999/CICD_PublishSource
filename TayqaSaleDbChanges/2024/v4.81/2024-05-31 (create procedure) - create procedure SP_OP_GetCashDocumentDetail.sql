
create procedure [dbo].[SP_OP_GetCashDocumentDetail](@requestId int)
as
begin
    select concat(Users.Name, ' ', Users.Surname, ' (', Users.UserName, ')') as [User],
           concat(Salesman.Name, ' ', ' (', Salesman.Code, ')')              as Representative,
           concat(Client.Name, ' ', ' (', Client.Code, ')')                  as Client,
           ILog.ProcessDate                                                  as DocumentDate,
           ILog.DocCreatedTime                                               as CreationDate,
           ILog.RegisteredDate                                               as DateToSent,
           concat(CashCard.Name, ' ', ' (', CashCard.Code, ')')              as Cashbox,
           coalesce(RequestQueue.Amount, CashTwo.Amount, 0)                  as PriceAmount,
           ILog.GpsLatitude                                                  as OperationLatitude,
           ILog.GpsLongitude                                                 as OperationLongitude,
           Client.Latitude                                                   as ClientLatitude,
           Client.Longitude                                                  as ClientLongitude
    from OP_ThirdPartyIncomingLog ILog with (nolock)
             join AbpUsers Users with (nolock) on ILog.UserId = Users.Id
             left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = ILog.SalesmanRef
             join MD_Client Client with (nolock) on Client.TigerId = ILog.ClientId
             left join OP_ThirdPartyRequestQueueCashExtension RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
             left join OP_ThirdPartyIncomingLogCashExtension Cash with (nolock) on Cash.Id = ILog.Id
             left join OP_ThirdPartyCashResultLog CashTwo with (nolock) on ILog.Id = CashTwo.Id
             left join MD_CashCard CashCard with (nolock) on CashCard.Code COLLATE SQL_Latin1_General_CP1_CI_AS = Cash.CashCode
    where ILog.DocType in (5, 6)
      and ILog.Id = @requestId
end