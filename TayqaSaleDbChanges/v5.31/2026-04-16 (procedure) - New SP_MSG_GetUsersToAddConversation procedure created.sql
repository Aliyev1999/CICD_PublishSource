
CREATE OR ALTER PROCEDURE [dbo].[SP_MSG_GetUsersToAddConversation]
(
    @currentUserId BIGINT = NULL,
    @firm SMALLINT = NULL,
    @usersExcept NVARCHAR(200) = NULL,
    @searchText NVARCHAR(200) = NULL,
    @sortingText NVARCHAR(50) = NULL,
    @maxResultCount INT,
    @skipCount INT,
    @totalCount INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH FilteredUsers AS
    (
        SELECT
            PU.UserId,
            U.Id,
            U.Name,
            U.Surname,
            U.UserName,
            CONCAT(U.Name, ' ', U.Surname) AS UserFullName,
            CAST(NULL AS NVARCHAR(500)) AS ProfilePhotoUrl
        FROM F_GetaLLPermittedUsers(@currentUserId) PU
        JOIN AbpUsers U ON PU.UserId = U.Id
        WHERE
            (@currentUserId IS NULL OR U.Id <> @currentUserId)
            AND
            (
                ISNULL(@usersExcept, '') = ''
                OR U.Id NOT IN
                (
                    SELECT TRY_CAST(LTRIM(RTRIM(value)) AS BIGINT)
                    FROM STRING_SPLIT(@usersExcept, ',')
                    WHERE TRY_CAST(LTRIM(RTRIM(value)) AS BIGINT) IS NOT NULL
                )
            )
            AND
            (
                ISNULL(@searchText, '') = ''
                OR U.Name LIKE '%' + @searchText + '%'
                OR U.Surname LIKE '%' + @searchText + '%'
                OR U.UserName LIKE '%' + @searchText + '%'
            )
    )
    SELECT @totalCount = COUNT(*)
    FROM FilteredUsers;

    ;WITH FilteredUsers AS
    (
        SELECT
            PU.UserId,
            U.Id,
            U.Name,
            U.Surname,
            U.UserName,
            CONCAT(U.Name, ' ', U.Surname) AS UserFullName,
            CAST(NULL AS NVARCHAR(500)) AS ProfilePhotoUrl
        FROM F_GetaLLPermittedUsers(@currentUserId) PU
        JOIN AbpUsers U ON PU.UserId = U.Id
        WHERE
            (@currentUserId IS NULL OR U.Id <> @currentUserId)
            AND
            (
                ISNULL(@usersExcept, '') = ''
                OR U.Id NOT IN
                (
                    SELECT TRY_CAST(LTRIM(RTRIM(value)) AS BIGINT)
                    FROM STRING_SPLIT(@usersExcept, ',')
                    WHERE TRY_CAST(LTRIM(RTRIM(value)) AS BIGINT) IS NOT NULL
                )
            )
            AND
            (
                ISNULL(@searchText, '') = ''
                OR U.Name LIKE '%' + @searchText + '%'
                OR U.Surname LIKE '%' + @searchText + '%'
                OR U.UserName LIKE '%' + @searchText + '%'
            )
    ),
    UsersCTE AS
    (
        SELECT
            UserId,
            UserName,
            UserFullName,
            ProfilePhotoUrl,
            ROW_NUMBER() OVER
            (
                ORDER BY
                    CASE WHEN @sortingText = 'Name' THEN Name END ASC,
                    CASE WHEN @sortingText = 'Surname' THEN Surname END ASC,
                    CASE WHEN @sortingText = 'UserName' OR @sortingText IS NULL THEN UserName END ASC,
                    Id ASC
            ) AS RowNum
        FROM FilteredUsers
    )
    SELECT
        UserId,
        UserName,
        UserFullName,
        ProfilePhotoUrl
    FROM UsersCTE
    WHERE RowNum > @skipCount
      AND (@maxResultCount IS NULL OR @maxResultCount = 0 OR RowNum <= (@skipCount + @maxResultCount));
END
