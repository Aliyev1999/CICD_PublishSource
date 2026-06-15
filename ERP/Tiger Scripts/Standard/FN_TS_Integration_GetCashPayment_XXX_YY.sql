create Function [dbo].[FN_TS_Integration_GetCashPayment_XXX_YY](@ficheId int)
RETURNS TABLE
AS RETURN
(
SELECT LOGICALREF AS FicheRef, FICHENO AS FicheNo, AMOUNT AS Amount, STATUS AS Status, TRANGRPNO As TranGroupNo
FROM LG_XXX_YY_KSLINES WITH (NOLOCK) 
where LOGICALREF=@ficheId
);

GO
