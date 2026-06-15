create Function [dbo].[FN_TS_Integration_GetTotalCashPayment_XXX_YY](@clientId int, @date datetime)
RETURNS TABLE
AS RETURN
(
SELECT ISNULL(SUM(AMOUNT),0) AS TotalPayment FROM LG_XXX_YY_CLFLINE WITH (NOLOCK) WHERE CLIENTREF=@clientId AND TRCODE=1 AND DATE_=@date
);

GO
