ALTER FUNCTION [dbo].[F_WPM_GetLowBatteryUsers](@startDate datetime, @endDate datetime, @currentUserId bigint)
    RETURNS TABLE
        AS RETURN
        WITH Data AS (SELECT UserId,
                             COALESCE(FinalizedBatteryPercentage, CreatedBatteryPercentage)                             AS BatteryPercentage,
                             COALESCE(FinalizedDate, CreatedDate)                                                       AS TaskDate,
                             CreatedLatitude,
                             CreatedLongitude,
                             ROW_NUMBER() OVER (PARTITION BY UserId ORDER BY COALESCE(FinalizedDate, CreatedDate) DESC) AS RowNum
                      FROM WPM_TaskTicket WITH (NOLOCK)
                      WHERE (COALESCE(FinalizedBatteryPercentage, CreatedBatteryPercentage) < 30)
                        AND CAST(CreatedDate AS DATE) BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE))
        SELECT TOP 5 Data.UserId,
                     Data.BatteryPercentage           AS CreatedBatteryPercentage,
                     Data.TaskDate                    AS CreatedDate,
                     Data.CreatedLatitude,
                     Data.CreatedLongitude,
                     Users.Name + ' ' + Users.Surname AS UserName
        FROM Data
                 JOIN AbpUsers Users WITH (NOLOCK) ON Data.UserId = Users.Id
                 JOIN F_GetAllPermittedUsers(@currentUserId) PUsers ON PUsers.UserId = Users.Id
        WHERE Data.RowNum = 1
        ORDER BY Data.TaskDate DESC