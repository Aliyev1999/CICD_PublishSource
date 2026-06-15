CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetReasons](@userId INT)
    RETURNS TABLE
        AS
        RETURN(SELECT sr.Id,
                      sr.Name,
                      sr.Type
               FROM MD_StopReason sr WITH (NOLOCK)
               WHERE sr.IsDeleted = 0
                 AND sr.IsActive = 1
                 AND sr.Type IN (9, 33, 38))