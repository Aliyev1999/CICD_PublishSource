CREATE FUNCTION [dbo].[F_GetItemGroupsForItems](@firm SMALLINT NULL, @itemsList NVARCHAR(MAX) = NULL, @itemGroupType SMALLINT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT IGIM.Firm, IGIM.ItemId, IG.Id AS ItemGroupId, IG.Name AS ItemGroupName, IG.Code AS ItemGroupCode FROM MD_ItemGroupItemMapping IGIM
JOIN MD_ItemGroup IG ON IG.Id = IGIM.GroupId AND IG.[Type] = @itemGroupType
WHERE Firm = @firm AND IGIM.ItemId IN (SELECT [Value] FROM F_SplitList(@itemsList, ', '))
            )
GO