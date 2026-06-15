create   Function [dbo].[F_MD_GetFactDistributedByUser](@firm smallint, 
										   					   @period smallint, 
															   @beginDate datetime, 
															   @endDate datetime)
RETURNS TABLE
AS RETURN
(

--SELECT Year, Month, SalesmanId, ItemId, ItemUnitId, ClientId, Quantity

SELECT 
YEAR(invoice.Date) Year,
MONTH(invoice.Date) Month,
invoice.SalesmanId,
invoiceLine.ItemId,
itemUnit.TigerId AS ItemUnitId,
ROUND(SUM(IIF(invoice.Type=4, invoiceLine.Quantity, -invoiceLine.Quantity)),2 ) AS Quantity
FROM ERP_Invoice invoice WITH(NOLOCK)
JOIN ERP_InvoiceLine invoiceLine WITH(NOLOCK) ON invoice.ERPId = invoiceLine.InvoiceId
JOIN MD_ItemUnit itemUnit WITH(NOLOCK) ON invoiceLine.Firm = invoice.Firm AND 
									      invoiceLine.ItemId = itemUnit.TigerItemId AND 
										  itemUnit.Code = invoiceLine.ItemUnitCode AND
										  itemUnit.IsDeleted = 0
WHERE
invoice.Firm = @firm AND
invoice.Period = @period AND
invoice.Date >= @beginDate AND
invoice.Date <= @endDate AND
invoice.Type = 4 -- SaleInvoice

GROUP BY 
invoice.SalesmanId,
YEAR(invoice.Date),
MONTH(invoice.Date),
itemUnit.TigerId,
invoiceLine.ItemId

);
GO


