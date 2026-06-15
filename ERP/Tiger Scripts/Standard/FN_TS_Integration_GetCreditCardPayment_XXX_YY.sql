create Function [dbo].[FN_TS_Integration_GetCreditCardPayment_XXX_YY](@ficheId int)
RETURNS TABLE
AS RETURN
(
SELECT SOURCEFREF AS FicheRef, TRANNO AS TranNo, AMOUNT AS Amount, STATUS AS Status
FROM LG_XXX_YY_CLFLINE WITH (NOLOCK) 
WHERE TRCODE = 70 AND SOURCEFREF=@ficheId 
);

GO
