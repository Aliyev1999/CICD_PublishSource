CREATE OR ALTER function [dbo].[F_MGM_GetCommentInfo](@photoId INT, @sourceType TINYINT)
    RETURNS TABLE
        AS
        RETURN
        SELECT CONCAT(au.Name, ' ', au.Surname) AS UserFullName,
               up.SecureUrl                     AS UserProfileImage,
               mpc.CreationTime                 AS Date,
               msr.Name                         AS Reason,
               mpc.Comment                      AS Note
        FROM MD_PhotoComment mpc
                 JOIN AbpUsers au on au.Id = mpc.CreatorUserId
                 LEFT JOIN AbpUserProfilePhoto up ON au.Id = up.UserId
                 JOIN MD_StopReason msr ON msr.Id = mpc.ReasonId and msr.IsActive = 1 and msr.IsDeleted = 0
        WHERE mpc.ReferenceId = @photoId
          AND mpc.SourceType = @sourceType
