drop Function [dbo].[FN_TS_Integration_GetSalesmanClientDebt_XXX_YY];
go
CREATE  Function [dbo].[FN_TS_Integration_GetSalesmanClientDebt_XXX_YY](@clientId int, @salesmanId int)
RETURNS @clientDebt TABLE
(    
debit float,
credit float 
)
AS 
begin

declare @combinedClient bit=0;

select @combinedClient=dbo.FN_TS_SpecSaleFunctionality_IsCombinedClient_XXX(@clientId);

if (@combinedClient=0)
-- check client debt for non-combined client
begin
INSERT INTO @clientDebt 
select Debit, Credit from FN_TS_Integration_GetClientDebt_XXX_YY(@clientId)
end

else
-- check client debt for combined client (take into account salesmanId)
begin
INSERT INTO @clientDebt 
Select ISNULL(SUM((CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE 0 END)*CLFLINE.AMOUNT),0) AS Debit,
ISNULL(SUM((CASE WHEN CLFLINE.SIGN=1 THEN 1 ELSE 0 END)*CLFLINE.AMOUNT),0) AS Credit
FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
WHERE CLFLINE.CLIENTREF=@clientId AND CLFLINE.SALESMANREF=@salesmanId 
AND CLFLINE.CANCELLED = 0
end
return
end
