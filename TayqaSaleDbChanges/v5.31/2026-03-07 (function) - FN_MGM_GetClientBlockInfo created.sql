CREATE FUNCTION dbo.FN_MGM_GetClientBlockInfo(
    @Firm SMALLINT,
    @ClientId INT
)
    RETURNS TABLE
        AS
        RETURN(SELECT b.Status                              AS Status,
                      ISNULL(b.ModifiedDate, b.CreatedDate) AS LastActionDate
               FROM dbo.MD_BannedClient b
               WHERE b.Firm = @Firm
                 AND b.ClientId = @ClientId)
go

