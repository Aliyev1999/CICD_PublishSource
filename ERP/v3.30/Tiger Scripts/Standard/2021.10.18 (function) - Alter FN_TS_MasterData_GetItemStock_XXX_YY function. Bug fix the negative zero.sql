ALTER   Function [dbo].[FN_TS_MasterData_GetItemStock_XXX_YY]()
    RETURNS TABLE
        AS RETURN
            (
                SELECT STOCKREF						   AS ItemId,
                       INVENNO						   AS WarehouseNr,
                       (SUM(ONHAND) + 0.0)             AS ActualStock, -- Added 0.0 for fix the negative zero problem
                       (SUM(ONHAND - RESERVED) + 0.0)  AS RealStock,
                       (SUM(ONHAND) + 0.0)             AS SpecialStock
                FROM LV_XXX_YY_GNTOTST
                WHERE INVENNO != -1
                  AND STOCKREF IN (SELECT ItemId FROM FN_TS_MasterData_GetAllItem_XXX())
                GROUP BY STOCKREF, INVENNO
            )

-- See more: https://jira-tayqatech.atlassian.net/browse/TSC-2153