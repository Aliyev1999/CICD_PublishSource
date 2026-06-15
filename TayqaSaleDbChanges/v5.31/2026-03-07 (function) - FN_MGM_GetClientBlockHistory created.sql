
CREATE FUNCTION dbo.FN_MGM_GetClientBlockHistory(
    @Firm SMALLINT,
    @ClientId INT,
    @SkipCount BIGINT,
    @TakeCount BIGINT
)
    RETURNS TABLE
        AS
        RETURN(SELECT bl.NewStatus                                             AS Status,
                      ISNULL(LTRIM(RTRIM(CONCAT(u.Name, ' ', u.Surname))), '') AS UserFullName,
                      bl.Note                                                  AS BlockReason,
                      bl.CreatedDate                                           AS [Date]
               FROM dbo.MD_BannedClientLog bl
                        LEFT JOIN dbo.AbpUsers u
                                  ON u.Id = bl.CreatedUserId
               WHERE bl.Firm = @Firm
                 AND bl.ClientId = @ClientId
               ORDER BY bl.CreatedDate DESC
               OFFSET ISNULL(@SkipCount, 0) ROWS FETCH NEXT ISNULL(@TakeCount, 0) ROWS ONLY)
go
