create   Function [dbo].[F_MD_GetPaymentFactForSalesman](@firm smallint, 
										   					    @period smallint, 
															    @beginDate datetime, 
															    @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT 
SalesmanId, 
Date, 
162 CurrencyType, 
SUM(Amount) AS Amount

FROM ERP_FinanceOperation financeOperation WITH(NOLOCK)
WHERE
financeOperation.Firm = @firm AND
financeOperation.Period = @period AND
financeOperation.Date >= @beginDate AND
financeOperation.Date <= @endDate AND
financeOperation.Type IN(5, 51) -- CASH IN, BANK PAYMENT

GROUP BY 
financeOperation.SalesmanId, 
financeOperation.Date

);
GO


