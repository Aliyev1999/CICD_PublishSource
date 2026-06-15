-- checking client risk limit
create Function [dbo].[FN_TS_SaleFunctionality_IsClientRiskLimitExceeded_XXX](@clientId int, @total float, @docType tinyint)
RETURNS TINYINT
AS 
BEGIN
declare @notBilledOrders float=0;
declare @currentDebt float=0;
declare @riskLimit float;
select  @riskLimit = ACCRISKLIMIT FROM LG_XXX_YY_CLRNUMS WHERE CLCARDREF=@clientId

if (@riskLimit>0)
begin
if (@docType=0) -- if order operation
begin
select  @notBilledOrders = ISNULL(SUM (PRICE * (AMOUNT - SHIPPEDAMOUNT)),0) 
from LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
WHERE ORFLINE.CLIENTREF=@clientId AND ORFLINE.STATUS IN (4) and ORFLINE.DATE_>=CONVERT(date, getdate())
HAVING SUM (AMOUNT-SHIPPEDAMOUNT)>0
end

SELECT @currentDebt=ISNULL(SUM (DEBIT-CREDIT),0) 
FROM LG_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
WHERE GNTOTCL.TOTTYP=1 AND GNTOTCL.CARDREF=@clientId

IF  @notBilledOrders+ @currentDebt + @total> @riskLimit RETURN 1
ELSE RETURN 0;
end
RETURN 0;
END