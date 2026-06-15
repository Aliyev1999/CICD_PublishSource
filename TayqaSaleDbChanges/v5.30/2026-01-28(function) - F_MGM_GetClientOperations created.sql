CREATE OR ALTER function [dbo].[F_MGM_GetClientOperations](
    @UserId bigint,
    @ClientId bigint,
    @OperationType int,
    @OperationId int
    )
    returns table
        as
        return
            (
                select COALESCE(TRY_CAST(JSON_VALUE(erp.ImportResult, '$.ERPDocInfo.ERPId') AS bigint),0)                      AS ERPId,
                       coalesce(json_value(erp.ImportResult, '$.ERPDocInfo.FicheNo'), '')                                      as FicheNo,
                       coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.NetAmount') as decimal(18, 2)), 0.00)      as NetAmount,
                       coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.DiscountAmount') as decimal(18, 2)), 0.00) as DiscountAmount,
                       case
                           when json_value(doclines.value, '$.LineType') = '1'
                               then coalesce(try_cast(json_value(doclines.value, '$.NetTotal') as decimal(18, 2)), 0.00)
                           else 0.00
                           end                                                                                                 as PromoAmount,
                       coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.VatTotal') as decimal(18, 2)), 0.00)       as VatTotal,
                       coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.GrossAmount') as decimal(18, 2)), 0.00)    as GrossAmount,
                       coalesce(json_value(erp.ImportResult, '$.ERPDocInfo.CurrencyCode'), '')                                 as CurrencyCode,

                       coalesce(
                               case
                                   when @OperationType = 14
                                       then try_cast(json_value(Queue.Note, '$.ERPDocInfo.Debit') as decimal(18, 2))
                                                - try_cast(json_value(Queue.Note, '$.ERPDocInfo.Credit') as decimal(18, 2))
                                       + coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.NetAmount') as decimal(18, 2)), 0.00)
                                   when @OperationType = 11
                                       then try_cast(json_value(Queue.Note, '$.ERPDocInfo.Debit') as decimal(18, 2))
                                       - try_cast(json_value(Queue.Note, '$.ERPDocInfo.Credit') as decimal(18, 2))
                                       - coalesce(try_cast(json_value(erp.ImportResult, '$.ERPDocInfo.NetAmount') as decimal(18, 2)), 0.00)
                                   else try_cast(json_value(Queue.Note, '$.ERPDocInfo.Debit') as decimal(18, 2))
                                   end, 0.00
                           )                                                                                                   as DebtAtStartOfDoc,

                       coalesce(
                               case
                                   when @OperationType in (14, 11)
                                       then try_cast(json_value(Queue.Note, '$.ERPDocInfo.Debit') as decimal(18, 2))
                                       - try_cast(json_value(Queue.Note, '$.ERPDocInfo.Credit') as decimal(18, 2))
                                   else try_cast(json_value(Queue.Note, '$.ERPDocInfo.Credit') as decimal(18, 2))
                                   end, 0.00
                           )                                                                                                   as DebtAtEndOfDoc,

                       coalesce(json_value(doclines.value, '$.ItemId'), '')                                                    as ItemId,
                       coalesce(item.Name, '')                                                                                 as ItemName,
                       coalesce(item.Code, '')                                                                                 as ItemCode,
                       coalesce(json_value(doclines.value, '$.ItemUnitCode'), '')                                              as ItemUnitCode,
                       coalesce(try_cast(json_value(doclines.value, '$.Quantity') as decimal(18, 2)), 0.00)                    as Quantity,
                       coalesce(try_cast(json_value(doclines.value, '$.Price') as decimal(18, 2)), 0.00)                       as Price,
                       coalesce(try_cast(json_value(doclines.value, '$.NetTotal') as decimal(18, 2)), 0.00)                    as NetTotal,
                       coalesce(try_cast(json_value(doclines.value, '$.DiscountAmount') as decimal(18, 2)), 0.00)              as ItemDiscountAmount,
                       coalesce(json_value(doclines.value, '$.ResultDesc'), '')                                                as Note,
                       coalesce(json_value(doclines.value, '$.LineType'), '')                                                  as LineType,
                       iif(log.DocStatus = 1, 1, 0)                                                                            as IsConfirmed
                from WPM_TaskTicketAction taskaction
                         cross apply openjson(taskaction.ActionParams, '$.reference') with (DocId nvarchar(50) '$') as ref
                         right join OP_IncomingLog log with (nolock)
                                    on ref.DocId collate SQL_Latin1_General_CP1_CI_AS = log.DocId collate SQL_Latin1_General_CP1_CI_AS
                         left join WPM_TaskAction action with (nolock)
                                   on taskaction.ActionId = action.Id
                         left join WPM_TaskActionType actiontype with (nolock)
                                   on action.ActionType = actiontype.Id
                         inner join OP_GeneralLog general with (nolock)
                                    on general.RequestId = log.Id
                         inner join OP_OutQueue Queue with (nolock)
                                    on Queue.GeneralId = general.Id
                         inner join OP_DocStatus DStatus with (nolock)
                                    on (DStatus.DocId = Queue.DocId and DStatus.Status in (1, 2))
                         inner join OP_ERPIntegrationtResultLog erp with (nolock)
                                    on erp.GeneralId = general.Id
                         outer apply openjson(erp.ImportResult, '$.ERPDocInfo.DocLinesInfo') as doclines
                         left join MD_Item item with (nolock)
                                   on item.TigerId = json_value(doclines.value, '$.ItemId')
                where coalesce(
                              actiontype.Id,
                              case log.Doctype
                                  when 0 then 7
                                  when 1 then 13
                                  when 2 then 14
                                  when 3 then 10
                                  when 4 then 11
                                  end
                          ) = @OperationType
                  and coalesce(log.Id, taskaction.Id) = @OperationId
                  and log.UserId = @UserId
                  and log.ClientId = @ClientId
                  and json_value(doclines.value, '$.ItemId') is not null
            )
