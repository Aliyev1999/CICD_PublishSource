create Function [dbo].[FN_TS_Integration_GetCheckAndVoucherPayment_XXX_YY](@ficheId int)
RETURNS TABLE
AS RETURN
(
SELECT LOGICALREF AS FicheRef, ROLLNO AS RollNo, TRCODE AS Trcode, TOTAL AS Total
FROM LG_XXX_YY_CSROLL WITH (NOLOCK) 
WHERE TRCODE IN (1,2) AND LOGICALREF=@ficheId
);

GO
