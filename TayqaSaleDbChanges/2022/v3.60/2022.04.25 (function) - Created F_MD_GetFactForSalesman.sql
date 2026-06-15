CREATE Function [dbo].[F_MD_GetFactForSalesman](@firm smallint, 
										   	   @period smallint, 
											   @beginDate datetime, 
											   @endDate datetime)
RETURNS TABLE
AS RETURN
(

SELECT 
invoice.SalesmanId, 
invoiceLine.ItemId,
itemUnitLineNr.TigerId AS ItemUnitId,
invoice.Date,
162 As CurrencyType,
ROUND(SUM(itemUnit.Convfact2 / IIF(itemUnitLineNr.Convfact2 = 0 OR itemUnitLineNr.Convfact2 IS NULL, 1,itemUnitLineNr.Convfact2) * 
      IIF(invoice.Type = 4, invoiceLine.Quantity, -invoiceLine.Quantity)), 2) AS Quantity,
ROUND(SUM(IIF(invoice.Type = 4, invoiceLine.Quantity * invoiceLine.Price  - invoiceLine.DiscountAmount, -(invoiceLine.Quantity * invoiceLine.Price  - invoiceLine.DiscountAmount))), 2) AS Amount 
FROM ERP_Invoice invoice WITH(NOLOCK)
JOIN ERP_InvoiceLine invoiceLine WITH(NOLOCK) ON invoice.ErpId = invoiceLine.InvoiceId 

JOIN MD_ItemUnit itemUnit WITH(NOLOCK) ON itemUnit.Firm = invoice.Firm AND 
										  itemUnit.TigerItemId = invoiceLine.ItemId AND 
										  itemUnit.Code = invoiceLine.ItemUnitCode AND
										  itemUnit.IsDeleted = 0

JOIN MD_ItemUnit itemUnitLineNr WITH(NOLOCK) ON itemUnitLineNr.Firm = invoice.Firm AND 
								   		        itemUnitLineNr.TigerItemId = invoiceLine.ItemId AND 
											    itemUnitLineNr.IsDeleted = 0 AND
											    itemUnitLineNr.LineNr = 1

WHERE
invoice.Firm = @firm AND
invoice.Period = @period AND
invoice.Date >= @beginDate AND
invoice.Date <= @endDate

GROUP BY 
invoice.SalesmanId, 
invoice.Date,
invoiceLine.ItemId,
itemUnitLineNr.TigerId

);
GO


