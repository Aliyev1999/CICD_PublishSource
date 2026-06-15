ALTER 
 PROCEDURE [dbo].[SP_MIP_DashboardClientDataCounts1](@userId bigint)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @sql nvarchar(max);
    DECLARE @table table
                   (
                       firm    smallint,
                       tigerId int,
                       status  bit
                   );

    SET @sql = 'SELECT DISTINCT c.Firm, c.TigerId, c.Status
		        FROM MD_Client c
		        JOIN MD_Firm f ON c.Firm = f.Nr
		        JOIN F_GetAllPermittedClient() pc ON c.Firm = pc.Firm  AND pc.ClientId = c.TigerId
                JOIN AbpUsers u ON pc.UserId = u.Id';

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' JOIN F_UIM_GetOrganizationTreeUsers(@userId) otu ON u.Id = otu.UserId');
        END

    SET @sql = CONCAT(@sql, ' WHERE u.Name NOT LIKE ''service_user%'' AND  u.IsDeleted = 0 AND u.Id != 1')

    INSERT INTO @table EXEC sp_executesql @sql, N'@userId bigint', @userId

    SELECT (SELECT count(*) FROM @table WHERE status = 0) As ActiveCount,
           (SELECT count(*) FROM @table)                  As TotalCount
END