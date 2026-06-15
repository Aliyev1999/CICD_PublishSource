-- newer version
ALTER   Function [dbo].[FN_TS_SaleFunctionality_IsClientRiskLimitExceededForSalesman_XXX](@clientId int, @salesmanId int, @total float, @docType tinyint)
RETURNS TINYINT
AS 
BEGIN
declare @notBilledOrders float=0;
declare @currentDebt float=0;
declare @riskLimit float = 0;
declare @shouldCheckRiskLimit bit =0;
declare @result tinyint=0;

select @shouldCheckRiskLimit=dbo.[FN_TS_SpecSaleFunctionality_ShouldCheckRiskLimit_XXX](@clientId);

if(@shouldCheckRiskLimit=1) -- should check risk limit
begin
select  @riskLimit = ROUND(RISKLIMIT,2) FROM VW_TS_Spec_GetSalesmanClientRiskLimit_XXX WITH (NOLOCK)
WHERE CLIENTREF=@clientId AND SALESMANREF=@salesmanId

if (@riskLimit>0)
begin -- checking risk limit
if (@docType=0) 
begin -- if order operation
select  @notBilledOrders = ISNULL(ROUND(SUM (PRICE * (AMOUNT - SHIPPEDAMOUNT)),2),0) 
from LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
WHERE ORFLINE.CLIENTREF=@clientId AND ORFLINE.STATUS IN (4) and DATE_>=cast(DATEADD(DD,-10,CONVERT(date,Getdate()))  as date)
and ORFLINE.LINETYPE IN (0,1,6) AND ORFLINE.SALESMANREF=@salesmanId
HAVING SUM (AMOUNT-SHIPPEDAMOUNT)>0
end -- order opration end

SELECT  @currentDebt= ISNULL(ROUND(SUM((CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE -1 END)*CLFLINE.AMOUNT),2),0)
FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK) 
WHERE CLFLINE.CLIENTREF = @clientId AND CLFLINE.CANCELLED=0 AND CLFLINE.STATUS=0
AND CLFLINE.SALESMANREF=@salesmanId

IF  @notBilledOrders+ @currentDebt + @total> @riskLimit
set @result =1;
ELSE 
set @result =0;
end -- end checking risk limit
end -- end should check risk limit
RETURN @result;
end -- function end


-- checking non-combined client risk limit (standard one)
ALTER   Function [dbo].[FN_TS_SaleFunctionality_IsClientRiskLimitExceeded_XXX](@clientId int, @total float, @docType tinyint)
RETURNS TINYINT
AS 
BEGIN
declare @notBilledOrders float=0;
declare @currentDebt float=0;
declare @riskLimit float = 0;

select  @riskLimit = ROUND(RISKLIMIT,2) FROM VW_TS_Spec_GetSalesmanClientRiskLimit_XXX  WHERE CLIENTREF=@clientId

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

