
create or ALTER FUNCTION [dbo].[F_MGM_GetCashOperationDetails]( @firm smallint,@requestId bigint)
    RETURNS TABLE
        AS
        RETURN(
		
		select
                   
                   ILog.DocType                                     as OperationType,
                   Division.Name                                    as DivisionName,
                   CashCard.Name                                    as CashName,
                   salesman.Name                                    as Salesman,
                   salesman.Code                                    as SalesmanCode,
                   ILog.Note                                        as Note,
                   coalesce(RequestQueue.Amount, CashTwo.Amount, 0) as Amount,
                   Currency.Code                                    as Currency

               from OP_ThirdPartyIncomingLog ILog with (nolock)

                        join OP_ThirdPartyIncomingLogCashExtension Cash with (nolock) on Cash.Id = ILog.Id
                        join MD_CashCard CashCard with (nolock) on CashCard.Code COLLATE SQL_Latin1_General_CP1_CI_AS = Cash.CashCode and ILog.Firm=CashCard.Firm
                        join MD_Currency Currency with (nolock) on ILog.CurrencyType = Currency.Type and Currency.Firm=ILog.Firm
                        left join MD_Division Division with (nolock) on ILog.Division = Division.Nr AND ILog.Firm = Division.Firm
                        left join OP_ThirdPartyRequestQueueCashExtension RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
                        left join OP_ThirdPartyCashResultLog CashTwo with (nolock) on ILog.Id = CashTwo.Id
                        left join MD_Salesman salesman with (nolock) on ILog.SalesmanRef = salesman.TigerId AND ILog.Firm = salesman.Firm

               where ILog.Id = @requestId and ILog.Firm=@firm
)