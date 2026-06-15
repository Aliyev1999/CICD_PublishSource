create or alter function [dbo].[F_RM_RISK_LIMIT_GET_LIMIT_RECORDS_FOR_USER] (@beginDateTimeStamp datetime,@UserId int)
    returns table
        as
        return
            (
                select Requests.Id                                        as Id,
                       Requests.RequestId                                 as RequestId,
                       Requests.Firm                                      as Firm,
                       Requests.CreatedDate                               as CreatedDate,
                       Requests.CreatedUserId                             as CreatedUserId,
                       CreatedUser.Name + ' ' + CreatedUser.Surname       as CreatedUser,
                       Requests.CreatedNote                               as CreatedNote,
                       Requests.ControlledDate                            as ControlledDate,
                       Requests.ControlledUserId                          as ControlledUserId,
                       ControlledUser.Name + ' ' + ControlledUser.Surname as ControlledUser,
                       Requests.ControlledNote                            as ControlledNote,
                       Requests.Status                                    as Status,
                       Client.TigerId                                     as ClientId,
                       Client.Code                                        as ClientCode,
                       Client.Name                                        as ClientName,
					   Client.Edino										  as ClientEdino,
					   isnull((ClientDebt.Debit-ClientDebt.Credit),0)     as ClientDebt,
					   isnull(Salesman.TigerId, 0)				          as SalesmanId,
					   Salesman.Name									  as SalesmanName,
					   Salesman.Code									  as SalesmanCode,
                       RequestClient.CurrentLimit                         as CurrentLimit,
                       RequestClient.RequestedLimit                       as RequestedLimit
                from OP_RiskLimitRequest Requests  with(nolock)
                         inner join OP_RiskLimitClient RequestClient with(nolock) on Requests.Id = RequestClient.RequestId
                         inner join AbpUsers CreatedUser on CreatedUser.Id = Requests.CreatedUserId
						 left join  OP_ClientDebt  ClientDebt  with(nolock) on ClientDebt.TigerClientId  =RequestClient.ClientId and Requests.Firm=ClientDebt.Firm and ClientDebt.OrderNo=1
						 left join  MD_Salesman Salesman on Salesman.TigerId = Requests.SalesmanId
                         left join AbpUsers ControlledUser on ControlledUser.Id = Requests.ControlledUserId
                         inner join MD_Client Client
                                    on (Client.TigerId = RequestClient.ClientId and Client.Firm = Requests.Firm)
                where Requests.CreatedDate >= @beginDateTimeStamp
                  and Requests.CreatedUserId = @UserId
            )