CREATE PROCEDURE [dbo].[SP_MD_GetItemSerialNumbers] @userId INT, @firm SMALLINT = 0, @erpItemId INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'WITH SerialNumbers AS (SELECT 
									  SerialNumber.Firm,
                                      SerialNumber.ItemId,
                                      SerialNumber.RegisteredDate,
									  SerialNumber.SerialNumber,
                                      SerialNumber.WarehouseNr
                                    FROM OP_ItemSerialNumber SerialNumber WITH (NOLOCK)
                                             INNER JOIN MD_CatalogItemMapping ItemMapping WITH (NOLOCK) ON ItemMapping.TigerItemId = SerialNumber.ItemId
                                             INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON Cat.Id = ItemMapping.CatalogId AND Cat.Firm = SerialNumber.Firm
                                             INNER JOIN MD_PermittedCatalog PCatalog WITH (NOLOCK) ON PCatalog.UserId = @userId AND PCatalog.CatalogId = ItemMapping.CatalogId
                                    WHERE 1=1 '
    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND SerialNumber.Firm = @firm')
        END

    IF (@erpItemId > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND SerialNumber.ItemId = @erpItemId')
        END

    SET @sql = CONCAT(@sql, 
                            ') SELECT 
							 ItemId,
                             SerialNumber,
                             WarehouseNr,
							 RegisteredDate
                             FROM SerialNumbers')

							 print @sql;
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT, @erpItemId INT', @userId = @userId, @firm = @firm, @erpItemId = @erpItemId

END