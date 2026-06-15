/****** Object:  StoredProcedure [dbo].[SP_MD_GetWarehouses]    Script Date: 7/28/2021 9:51:17 AM ******/
ALTER PROCEDURE [dbo].[SP_MD_GetWarehouses] @userId INT, @firm SMALLINT = 0
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM (
				SELECT Q.Firm, Q.TigerWarehouseNr, Q.DivisionNr, Q.Name, MIN(Q.RegisteredDate) AS RegisteredDate FROM (SELECT DISTINCT Permitted.Firm, Permitted.TigerWarehouseNr, Permitted.DivisionNr, WHouse.Name, WHouse.RegisteredDate
								FROM [MD_PermittedWarehouse] Permitted WITH (NOLOCK)
										 INNER JOIN [MD_Warehouse] WHouse WITH (NOLOCK) ON (Permitted.Firm = WHouse.Firm AND Permitted.TigerWarehouseNr = WHouse.Nr)
								WHERE Permitted.UserId = @userId
								UNION
								SELECT DISTINCT QUERY.Firm, QUERY.WarehouseNr, W.DivisionNr, W.Name, GETDATE() AS RegisteredDate FROM
								(SELECT WI.Firm, WI.EnteranceWarehouseNr AS WarehouseNr, WI.UserId, WI.RegisteredDate from MD_PermittedTransferWarehousesMapping WI
								UNION
								SELECT WO.Firm, WO.ExitWarehouseNr  AS WarehouseNr, WO.UserId, WO.RegisteredDate from MD_PermittedTransferWarehousesMapping WO) QUERY
								JOIN MD_Warehouse W ON W.Nr = QUERY.WarehouseNr AND W.Firm = QUERY.Firm
								WHERE QUERY.UserId = @userId) Q
								GROUP BY Q.Firm, Q.TigerWarehouseNr, Q.DivisionNr, Q.Name) QUERY';
    
    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' WHERE QUERY.Firm=@firm');
        END
    
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT', @userId = @userId, @firm = @firm

END
