CREATE OR ALTER FUNCTION [dbo].[F_GetAllPermittedInventories]()
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT DISTINCT Usr.Id AS UserId, Item.TigerId AS InventoryTigerId, Item.Firm
                    FROM IM_PermittedCatalog AS PemittedCatalog WITH (NOLOCK)
                             INNER JOIN IM_Catalog AS [Catalog] WITH (NOLOCK) ON PemittedCatalog.CatalogId = [Catalog].Id
                             INNER JOIN AbpUsers AS Usr WITH (NOLOCK) ON PemittedCatalog.UserId = Usr.Id AND Usr.IsDeleted = 0 AND Usr.IsActive = 1
                             INNER JOIN IM_CatalogItemMapping AS CIM WITH (NOLOCK) ON [Catalog].Id = CIM.CatalogId
                             INNER JOIN MD_Item AS Item WITH (NOLOCK) ON [Catalog].Firm = Item.Firm AND CIM.TigerItemId = Item.TigerId
            )