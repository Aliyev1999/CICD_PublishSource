
CREATE FUNCTION [dbo].[FN_TS_Report_GetWarehouseStockDemand_XXX] (@DemandId int) 
RETURNS @warehouseStockDemand TABLE   
(  
    DocumentNumber nvarchar(50) NOT NULL,  
    ItemCode nvarchar(50) NOT NULL, 
    ItemName nvarchar(50) NOT NULL, 
    ItemUnitCode nvarchar(50) NOT NULL, 
    RejectedQuantity float NOT NULL, 
    RequiredQuantity float NOT NULL, 
    SuppliedQuantity float NOT NULL, 
    Status tinyint NOT NULL, 
    Date datetime NOT NULL
)  
AS  
BEGIN  
  
  insert into @warehouseStockDemand    
	select 
	df.FICHENO 'DocumentNumber',
	p.CODE 'ItemCode',
	p.NAME 'ItemName',
	ull.name'ItemUnitCode',
	d.CANCAMOUNT'RejectedQuantity',
	d.AMOUNT 'RequiredQuantity',
	d.MEETAMNT 'SuppliedQuantity',
	df.STATUS'Status',
	df.DATE_'Date'

	from LG_XXX_YY_DEMANDLINE d
	inner join LG_XXX_ITEMS p on p.LOGICALREF=d.ITEMREF
	inner join LG_XXX_YY_DEMANDFICHE df on df.LOGICALREF=d.DEMANDFICHEREF
	inner join LG_XXX_UNITSETL ull on ull.LOGICALREF=d.UOMREF

	where df.LOGICALREF=@DemandId

  return;
END;  

GO


