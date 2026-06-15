 create FUNCTION [dbo].[F_MD_GetItemGroupQuantityOperationRestriction](@firm smallint, @userId INT, @proccessDate DATE, @operationId TINYINT, @itemGroupType TINYINT)
    RETURNS @T TABLE
               (
                    Id                          INT,
                    Firm                        SMALLINT,
                    MaxQuantity			        INT,
                    OperationId                 TINYINT,
                    StartDate                   DATE,
                    EndDate                     DATE,
                    CreationTime                DATETIME,
                    CreatorUserName             NVARCHAR(MAX),
                    ItemGroupName               NVARCHAR(MAX),
                    ItemGroupCode               NVARCHAR(MAX),
                    ItemGroupId                 INT
               )
AS
BEGIN

    INSERT INTO @T
    SELECT  Id,
            Firm,
            MaxQuantity,
            OperationId,
            StartDate,
            EndDate,
            CreationTime,
            CreatorUserName,
            ItemGroupName,
            ItemGroupCode,
            ItemGroupId
    FROM (
            SELECT
                R.Id,
                R.Firm,
                R.MaxQuantity,
                R.OperationId,
                R.StartDate,
                R.EndDate,
                R.CreationTime,
                U.UserName      AS CreatorUserName,
                IG.Name         AS ItemGroupName,
                IG.Code         AS ItemGroupCode,
                IG.Id           AS ItemGroupId
            FROM MD_UserItemGroupQuantityOperationRestriction R
            JOIN MD_ItemGroup IG ON R.ItemGroupId = IG.Id
            LEFT JOIN AbpUsers U ON R.CreatorUserId = U.Id
            WHERE R.Firm = @firm AND R.[Status] = 0
                AND R.UserId = @userId
                AND R.OperationId = @operationId
                AND @proccessDate >= R.StartDate
                AND @proccessDate <= R.EndDate
                AND IG.[Type] = @itemGroupType
         ) result
    RETURN;
END
GO