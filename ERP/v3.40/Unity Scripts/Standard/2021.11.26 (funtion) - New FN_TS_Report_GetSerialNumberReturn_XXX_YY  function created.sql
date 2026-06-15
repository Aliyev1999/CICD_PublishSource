CREATE FUNCTION [dbo].[FN_TS_Report_GetSerialNumberReturn_XXX_YY] (@FirmID tinyint, @ClientID int,@ItemID int)  
RETURNS @serialNumberForReturn TABLE   
(  
    SerialNumber nvarchar(50) NOT NULL,  
    FacturaNo nvarchar(50) NOT NULL,  
    Date datetime NOT NULL,  
    Price float NOT NULL  
)  
AS  
BEGIN  
  
  insert into @serialNumberForReturn 

  select 
  	sr.CODE 'SerialNumber',
	f.FICHENO 'FacturaNo',
	f.DATE_ 'Date',
	sl.PRICE 'Price'
  from LG_XXX_YY_SERILOTN sr
       inner join LG_XXX_YY_SLTRANS st on st.SLREF=sr.LOGICALREF 
	  inner join LG_XXX_YY_STLINE sl on sl.LOGICALREF=st.STTRANSREF
	  inner join LG_XXX_YY_INVOICE f on f.LOGICALREF=sl.INVOICEREF
where 
	sr.ITEMREF=@ItemID and 
	sl.CLIENTREF=@ClientID and 
	sr.LOGICALREF not in (select SLREF from LG_XXX_YY_SLTRANS where REMAMOUNT=1)
	return;
END;  