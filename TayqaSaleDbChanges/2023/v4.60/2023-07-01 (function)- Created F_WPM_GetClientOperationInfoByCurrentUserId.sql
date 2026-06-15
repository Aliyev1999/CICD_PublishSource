CREATE FUNCTION [dbo].F_WPM_GetClientOperationInfoByCurrentUserId(@givenDate DATE, @userId INT, @firm SMALLINT, @clientId INT, @currentUserId int)
    RETURNS TABLE AS RETURN
            (
               SELECT * FROM F_WPM_GetClientOperationInfo(@givenDate,@userId,@firm,@clientId)
            )