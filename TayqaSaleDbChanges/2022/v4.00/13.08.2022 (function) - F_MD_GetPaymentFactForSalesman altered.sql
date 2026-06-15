ALTER Function [dbo].[F_MD_GetPaymentFactForSalesman](@firm smallint,
    @period smallint,
    @beginDate datetime,
    @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT SalesmanId  as SalesmanId,
                       Date        as Date,
                       162         as CurrencyType,
                       SUM(Amount) as Amount

                FROM ERP_FinanceOperation financeOperation WITH (NOLOCK)
                WHERE financeOperation.Firm = @firm
                  AND financeOperation.Period = @period
                  AND financeOperation.Date >= @beginDate
                  AND financeOperation.Date <= @endDate
                  AND financeOperation.IsCancelled = 0
                  AND financeOperation.Type IN (5, 51) -- CASH IN, BANK PAYMENT

                GROUP BY financeOperation.SalesmanId,
                         financeOperation.Date

            )