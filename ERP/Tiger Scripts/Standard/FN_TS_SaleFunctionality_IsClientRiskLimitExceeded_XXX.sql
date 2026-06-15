CREATE Function [dbo].[FN_TS_SaleFunctionality_IsClientRiskLimitExceeded_XXX](@clientId int, @total float, @docType tinyint)
RETURNS TINYINT
AS 
BEGIN
declare @notBilledOrders float=0;
declare @currentDebt float=0;
declare @riskLimit float = 0;

select  @riskLimit = ACCRISKLIMIT FROM LG_XXX_YY_CLRNUMS  WHERE CLCARDREF=@clientId

if (@docType=0) -- if order operation
begin
select  @notBilledOrders = ISNULL(SUM (PRICE * (AMOUNT - SHIPPEDAMOUNT)),0) 
from LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
WHERE ORFLINE.CLIENTREF=@clientId AND ORFLINE.STATUS IN (4) and DATE_>=cast(Getdate() as date)
and ORFLINE.LINETYPE IN (0,1,6)
HAVING SUM (AMOUNT-SHIPPEDAMOUNT)>0


SELECT @currentDebt=ISNULL(SUM (DEBIT-CREDIT),0) FROM LV_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
WHERE GNTOTCL.TOTTYP=1 AND GNTOTCL.CARDREF=@clientId

IF  @notBilledOrders+ @currentDebt + @total> @riskLimit RETURN 1
ELSE RETURN 0;
end
RETURN 0;
END

GO
