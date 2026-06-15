CREATE Function [dbo].[FN_TS_SaleFunctionality_IsDebtLimitExceeded_XXX](@salesmanId int, @total float, @docType tinyint)
RETURNS TINYINT
AS 
BEGIN
declare @notBilledOrders float=0;
declare @currentDebt float=0;
declare @debtLimit float = 100000;
--mister tum'da risk limiti oxunan yer select RISK from LG_SLSMAN WHERE LOGICALREF=@salesmanId

if (@salesmanId!=1914)
begin
if (@docType=0) -- if order operation
begin
select  @notBilledOrders = ISNULL(SUM (PRICE * (AMOUNT - SHIPPEDAMOUNT)),0) 
from LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
INNER JOIN LG_XXX_SLSCLREL SLCREL WITH (NOLOCK) ON (SLCREL.CLIENTREF=ORFLINE.CLIENTREF AND SLCREL.SALESMANREF=@salesmanId)
WHERE ORFLINE.STATUS IN (4) and DATE_>='2020-12-29'
HAVING SUM (AMOUNT-SHIPPEDAMOUNT)>0
end

SELECT @currentDebt=ISNULL(SUM (DEBIT-CREDIT),0) FROM LV_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
INNER JOIN LG_XXX_SLSCLREL SLCREL WITH (NOLOCK) ON (SLCREL.CLIENTREF=GNTOTCL.CARDREF AND SLCREL.SALESMANREF=@salesmanId)
WHERE GNTOTCL.TOTTYP=1

IF  @notBilledOrders+ @currentDebt + @total> @debtLimit RETURN 1
ELSE RETURN 0;
end
RETURN 0;
END

GO
