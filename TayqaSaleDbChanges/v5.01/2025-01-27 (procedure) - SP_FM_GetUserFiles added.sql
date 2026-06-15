CREATE PROCEDURE [dbo].[SP_FM_GetUserFiles] @Firm SMALLINT,
                                            @UserIds NVARCHAR(MAX),
                                            @FileName NVARCHAR(200),
                                            @Specode1 NVARCHAR(100),
                                            @Specode2 NVARCHAR(100),
                                            @Specode3 NVARCHAR(100),
                                            @sorting NVARCHAR(MAX),
                                            @skipCount INT = 0,
                                            @maxResultCount INT = 10,
                                            @totalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @query NVARCHAR(MAX);
    DECLARE @Result TABLE
                    (
                        Id           INT,
                        Firm         NVARCHAR(100),
                        FileName     NVARCHAR(200),
                        SubFolder    NVARCHAR(200),
                        ParentFolder NVARCHAR(200),
                        [File]       NVARCHAR(500),
                        Specode1     NVARCHAR(100),
                        Specode2     NVARCHAR(100),
                        Specode3     NVARCHAR(100),
                        UsersCount   INT
                    );

    -- Build the dynamic query
    SET @query = '
        WITH UserGroupCounts AS (
            SELECT GroupId, COUNT(*) AS UserCount
            FROM MD_UserGroupMapping WITH (NOLOCK)
            GROUP BY GroupId
        ),
        ParsedUserIds AS (
            SELECT CAST(value AS BIGINT) AS UserId
            FROM STRING_SPLIT(@UserIds, '','')
        )
        SELECT
            f.Id AS Id,
            m.Name AS Firm,
            f.Name AS FileName,
            CASE WHEN pf.Id IS NULL THEN '''' ELSE fol.Name END AS SubFolder,
            CASE WHEN pf.Id IS NULL THEN fol.Name ELSE pf.Name END AS ParentFolder,
            f.SecureUrl AS [File],
            f.Specode1,
            f.Specode2,
            f.Specode3,
            SUM(
                CASE
                    WHEN fum.ReferenceType = 1 THEN 1
                    WHEN fum.ReferenceType = 2 AND ugc.UserCount IS NOT NULL THEN ugc.UserCount
                    ELSE 0
                END
            ) AS UsersCount
        FROM FM_Files f WITH (NOLOCK)
        INNER JOIN MD_Firm m WITH (NOLOCK) ON f.Firm = m.Nr
        INNER JOIN FM_Folders fol WITH (NOLOCK) ON f.FolderId = fol.Id
        LEFT JOIN FM_Folders pf WITH (NOLOCK) ON fol.ParentId = pf.Id
        LEFT JOIN FM_FileUserMapping fum WITH (NOLOCK) ON f.Id = fum.FileId
        LEFT JOIN UserGroupCounts ugc ON fum.ReferenceId = CAST(ugc.GroupId AS BIGINT)
        WHERE f.Firm = @Firm AND f.IsDeleted = 0 AND f.Type = 1
    ';

    -- Add filters dynamically
    IF (@FileName IS NOT NULL)
        SET @query = CONCAT(@query, ' AND f.Name LIKE ''%'' + @FileName + ''%''');
    IF (@Specode1 IS NOT NULL)
        SET @query = CONCAT(@query, ' AND f.Specode1 LIKE ''%'' + @Specode1 + ''%''');
    IF (@Specode2 IS NOT NULL)
        SET @query = CONCAT(@query, ' AND f.Specode2 LIKE ''%'' + @Specode2 + ''%''');
    IF (@Specode3 IS NOT NULL)
        SET @query = CONCAT(@query, ' AND f.Specode3 LIKE ''%'' + @Specode3 + ''%''');
    IF (@UserIds IS NOT NULL AND LEN(@UserIds) > 0)
        SET @query = CONCAT(@query, ' AND EXISTS (SELECT 1 FROM ParsedUserIds p WHERE p.UserId = fum.ReferenceId)');

    -- Add GROUP BY clause
    SET @query = CONCAT(@query, '
        GROUP BY
            f.Id,
            m.Name,
            f.Name,
            pf.Id,
            fol.Name,
            pf.Name,
            f.SecureUrl,
            f.Specode1,
            f.Specode2,
            f.Specode3');

    -- Insert results into @Result table
    INSERT INTO @Result
        EXEC sp_executesql @query,
             N'@Firm SMALLINT, @UserIds NVARCHAR(MAX), @FileName NVARCHAR(200), @Specode1 NVARCHAR(100), @Specode2 NVARCHAR(100), @Specode3 NVARCHAR(100)',
             @Firm = @Firm,
             @UserIds = @UserIds,
             @FileName = @FileName,
             @Specode1 = @Specode1,
             @Specode2 = @Specode2,
             @Specode3 = @Specode3;

    -- Calculate total count
    SET @totalCount = (SELECT COUNT(Id) FROM @Result);

    SET @query =
            concat(@query, ' ORDER BY ' + @sorting + '  OFFSET @skipCount ROWS FETCH NEXT @maxResultCount ROWS ONLY')

    EXEC sp_executesql @query,
         N'@Firm SMALLINT, @UserIds NVARCHAR(MAX), @FileName NVARCHAR(200), @Specode1 NVARCHAR(100), @Specode2 NVARCHAR(100), @Specode3 NVARCHAR(100), @sorting NVARCHAR(50),
               @skipCount INT,
               @maxResultCount INT,
               @totalCount INT OUT',
         @Firm = @Firm,
         @UserIds = @UserIds,
         @FileName = @FileName,
         @Specode1 = @Specode1,
         @Specode2 = @Specode2,
         @Specode3 = @Specode3,
         @sorting = @sorting,
         @skipCount = @skipCount,
         @maxResultCount = @maxResultCount,
         @totalCount = @totalCount OUT;
END;
go