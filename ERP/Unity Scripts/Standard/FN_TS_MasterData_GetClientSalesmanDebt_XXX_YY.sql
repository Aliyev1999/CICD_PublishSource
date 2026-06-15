CREATE FUNCTION [dbo].[FN_TS_MasterData_GetClientSalesmanDebt_XXX_YY]()
    RETURNS TABLE
        AS RETURN
            (
                SELECT CARDREF AS ClientId, 1 AS OrderNo, TOTTYP AS CurrencyType, SUM(DEBIT) AS Debit, SUM(CREDIT) AS Credit, CARDREF AS SalesmanId
                FROM LG_XXX_YY_GNTOTCL WITH (NOLOCK)
                WHERE CARDREF IN (SELECT ClientId FROM FN_TS_MasterData_GetAllClient_XXX())
                  AND TOTTYP = 1
                GROUP BY CARDREF, TOTTYP
            );