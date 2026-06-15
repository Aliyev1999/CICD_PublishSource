-- salesman debt
ALTER   Function [dbo].[FN_TS_Report_GetClientSalesmanBalance_XXX_YY](@clientId int, @salesmanId int, @date datetime)
RETURNS @Temp TABLE (Balance float)
AS 
begin
declare @combinedClient bit =0;
-- check to see combined client or not 
select @combinedClient=dbo.FN_TS_SpecSaleFunctionality_IsCombinedClient_XXX(@clientId);
if(@combinedClient=1)
begin
-- combined client
insert into @Temp
SELECT  ISNULL(SUM((CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE -1 END)*CLFLINE.AMOUNT),0) As Balance
FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK) 
WHERE CLFLINE.DATE_ < @date AND CLFLINE.CLIENTREF = @clientId AND CLFLINE.CANCELLED=0 AND CLFLINE.STATUS=0
AND CLFLINE.SALESMANREF=@salesmanId
end
else
begin
-- non combined client
insert into @Temp
SELECT Balance FROM [FN_TS_Report_GetClientBalance_XXX_YY](@clientId, @date)
end

return
end