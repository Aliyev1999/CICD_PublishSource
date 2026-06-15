ALTER Procedure [dbo].[SP_RM_GetTotalSale](@userId int,
                                            @firm smallint,
                                            @beginDate datetime,
                                            @endDate datetime,
                                            @viewMode tinyint = 1)
AS
BEGIN


-- Last modified by Kanan Mammadov to enable hierarchy of hybrid user

    with OperationData as (select round(sum(iif(DocType = 0, (SalesLines.Amount * SalesLines.Price) - isnull(SalesLines.DiscountAmount, 0), 0)), 2)       as OrderAmount,
                                  round(sum(iif(DocType in (1, 2), (SalesLines.Amount * SalesLines.Price) - isnull(SalesLines.DiscountAmount, 0), 0)), 2) as ReturnAmount,
                                  round(sum(iif(DocType = 5, CashLines.Amount, 0)), 2)                                                                    as CashInAmount
                           from OP_IncomingLog ILog with (nolock)
                                    join OP_GeneralLog GLog with (nolock) on GLog.RequestId = ILog.Id
                                    left join OP_IncomingLogCommonLineExtension SalesLines with (nolock) on SalesLines.Id = ILog.Id
                                    left join OP_IncomingLogCashExtension CashLines with (nolock) on CashLines.Id = ILog.Id
                                    left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Ilog.UserId = TreeUsers.UserId
                           where ILog.ProcessDate between cast(@beginDate as date) and cast(@endDate as date)
                             and ILog.DocType in (0, 1, 2, 5)
                             and (((@viewMode is null or @viewMode = 1) and Ilog.UserId = @userId)
                               or (@viewMode = 2 and TreeUsers.UserId is not null))
                             and GLog.ImportResult = 0
                             and ILog.Firm = @firm),

         InvoiceData as (select round(sum(iif(Invoice.[Type] = 4, (Lines.Quantity * Lines.Price) - Lines.DiscountAmount, 0)) -
                                      sum(iif(Invoice.[Type] = 2, (Lines.Quantity * Lines.Price) - Lines.DiscountAmount, 0)),
                                      2) as NetSaleAmount
                         from ERP_Invoice Invoice with (nolock)
                                  join ERP_InvoiceLine Lines with (nolock) on Invoice.ERPId = Lines.InvoiceId
                                  left join OP_GeneralLog Glog with (nolock) on Glog.TigerId = Invoice.ERPId and Glog.ImportResult = 0
                                  left Join OP_IncomingLog lo with (nolock) on lo.Id = Glog.RequestId
                                  left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on lo.UserId = TreeUsers.UserId
                         where (((@viewMode is null or @viewMode = 1) and lo.UserId = @userId)
                             or (@viewMode = 2 and TreeUsers.UserId is not null))
                           and Invoice.Date between cast(@beginDate as date) and cast(@endDate as date)
                           and lo.ProcessDate between cast(@beginDate as date) and cast(@endDate as date)
                           and lo.Firm = @firm
                           and Lines.LineType <> 1
                           and Invoice.IsDeleted = 0
                           and Invoice.IsCancelled = 0)

    select isnull(OrderAmount, 0)   as OrderAmount,
           isnull(CashInAmount, 0)  as CashInAmount,
           isnull(ReturnAmount, 0)  as ReturnAmount,
           isnull(NetSaleAmount, 0) as NetSaleAmount,
           'AZN'                    as CurrencyCode

    from OperationData,
         InvoiceData

END;