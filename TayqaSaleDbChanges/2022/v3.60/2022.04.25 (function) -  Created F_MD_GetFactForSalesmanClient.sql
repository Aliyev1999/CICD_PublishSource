create   Function [dbo].[F_MD_GetFactForSalesmanClient](@firm smallint, 
										   					   @period smallint, 
															   @beginDate datetime, 
															   @endDate datetime)
RETURNS TABLE
AS RETURN
(

SELECT 
invoice.SalesmanId, 
invoice.ClientId,
invoiceLine.ItemId,
itemUnit.TigerId AS ItemUnitId,
invoice.Date,
162 As CurrencyType,
ROUND(SUM(IIF(invoice.Type = 4, invoiceLine.Quantity, -invoiceLine.Quantity)), 2) AS Quantity,
ROUND(SUM(IIF(invoice.Type = 4, invoiceLine.Quantity * invoiceLine.Price, -invoiceLine.Quantity * invoiceLine.Price)), 2) AS Amount 
FROM ERP_Invoice invoice WITH(NOLOCK)
JOIN ERP_InvoiceLine invoiceLine WITH(NOLOCK) ON invoice.ErpId = invoiceLine.InvoiceId 
JOIN MD_ItemUnit itemUnit WITH(NOLOCK) ON itemUnit.Firm = invoice.Firm AND 
										  itemUnit.TigerItemId = invoiceLine.ItemId AND 
										  itemUnit.Code = invoiceLine.ItemUnitCode AND
										  itemUnit.IsDeleted = 0

WHERE
invoice.Firm = @firm AND
invoice.Period = @period AND
invoice.Date >= @beginDate AND
invoice.Date <= @endDate

GROUP BY 
invoice.SalesmanId, 
invoice.Date,
invoiceLine.ItemId,
itemUnit.TigerId,
invoice.ClientId

);
GO


