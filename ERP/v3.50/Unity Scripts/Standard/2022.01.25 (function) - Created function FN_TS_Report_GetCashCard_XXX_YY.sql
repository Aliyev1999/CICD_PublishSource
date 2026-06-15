
CREATE FUNCTION [dbo].[FN_TS_Report_GetCashCard_XXX] (@date datetime) 
RETURNS TABLE   
AS
RETURN
  

SELECT   kcard.LOGICALREF as Id,
kcard.CODE 'Code', kcard.NAME 'Name',  
                                   ROUND(SUM((CASE WHEN kline.SIGN=0 THEN 1  ELSE -1  END)*kline.AMOUNT),2)  'Amount',
								   'AZN' as CurrencyCode
                                   FROM LG_XXX_YY_KSLINES kline WITH (NOLOCK)
                                          LEFT JOIN LG_XXX_KSCARD kcard WITH (NOLOCK) on kcard.LOGICALREF=kline.CARDREF
                                   WHERE kline.STATUS=0 AND 
                                       kline.DATE_ <=  @date  AND 
                                   kline.CANCELLED=0 							   
								   GROUP BY  kcard.CODE, kcard.NAME ,kcard.LOGICALREF
GO


