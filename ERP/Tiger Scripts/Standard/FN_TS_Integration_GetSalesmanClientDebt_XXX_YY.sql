-- client debt data
CREATE OR ALTER FUNCTION [dbo].[FN_TS_Integration_GetSalesmanClientDebt_XXX_YY](@clientId INT, @salesmanId INT)
    RETURNS TABLE
        AS RETURN
            (
                SELECT ISNULL(SUM(DEBIT), 0) AS Debit, ISNULL(SUM(CREDIT), 0) AS Credit
                FROM LV_XXX_YY_GNTOTCL WITH (NOLOCK)
                WHERE CARDREF = @clientId
                  AND TOTTYP = 1

            );
GO

