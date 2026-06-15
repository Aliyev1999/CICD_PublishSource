CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetCashOperations](
    
	@UserId bigint,
    @ClientId bigint,
	@OperationType int,
    @OperationId int


)
RETURNS TABLE
AS
RETURN
(

select json_value(erp.ImportResult, '$.ERPDocInfo.FicheNo')                                                                     as FicheNo,
       try_cast(isnull(json_value(erp.ImportResult, '$.ERPDocInfo.Total'), 0.0) as Decimal(20, 2))                              as Amount,
       try_cast(isnull(case
                           when @operationType = 12 and log.DocStatus<>1 then
                                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Debit') as Decimal(18, 2)) -
                                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Credit') as Decimal(18, 2)) +
                                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Total') as Decimal(18, 2))
                           when @operationType = 15 and log.DocStatus<>1 then
                                   try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Debit') as Decimal(18, 2)) -
                                   try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Credit') as Decimal(18, 2)) -
                                   try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Total') as Decimal(18, 2))
						  when log.DocStatus=1 then
                                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Debit') as Decimal(18, 2)) -
                                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Credit') as Decimal(18, 2))
                           end, 0.0) as Decimal(20, 2))                                                                         as DebtBefore,
       try_cast(isnull(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Debit') as Decimal(18, 2)) -
                       try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.Credit') as Decimal(18, 2)), 0.0) as Decimal(20, 2)) as DebtAfter,
       json_value(erp.ImportResult, '$.ERPDocInfo.CurrencyCode')                                                                as Currency
from WPM_TaskTicketAction taskaction
         cross apply openjson(taskaction.ActionParams, '$.reference') with (DocId nvarchar(50) '$') ref
         right join OP_IncomingLog log with (nolock)
                    on ref.DocId collate SQL_Latin1_General_CP1_CI_AS = log.DocId COLLATE SQL_Latin1_General_CP1_CI_AS and DocType in (5, 6)
         left join WPM_TaskAction action with (nolock) on taskaction.ActionId = action.Id
         left join WPM_TaskActionType actiontype with (nolock) on action.ActionType = actiontype.Id
         right join OP_GeneralLog general with (nolock) on general.RequestId = log.Id 
         right join OP_ERPIntegrationtResultLog erp with (nolock) on erp.GeneralId = general.Id

where coalesce(ActionType.Id,
               case
                   when log.Doctype = 5 then 12
                   when log.Doctype = 6 then 15
                   else log.Doctype end) = @operationType
  and coalesce( log.Id,taskaction.Id) = @OperationId
  and log.UserId = @userId
  and log.ClientId = @ClientId
  and general.ImportResult=0);