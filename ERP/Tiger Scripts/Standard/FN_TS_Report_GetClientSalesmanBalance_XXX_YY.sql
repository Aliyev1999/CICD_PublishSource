CREATE Function [dbo].[FN_TS_Report_GetClientSalesmanBalance_XXX_YY](@clientId int, @salesmanId int, @date datetime)
RETURNS @Temp TABLE (Balance float)
AS 
begin
insert into @Temp
SELECT  ISNULL(SUM((CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE -1 END)*CLFLINE.AMOUNT),0) As Balance
FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK) 
WHERE CLFLINE.DATE_ < @date AND CLFLINE.CLIENTREF = @clientId AND CLFLINE.CANCELLED=0 AND CLFLINE.STATUS=0
AND CLFLINE.SALESMANREF=@salesmanId
return
end

GO
