ALTER FUNCTION [dbo].[F_GetUsersByTypeIncludingInactive](@type VARCHAR(30))
    RETURNS TABLE
        AS
        RETURN
            (
                WITH descendants AS
                         (SELECT ParentId AS parent, Id AS descendant, 1 AS level
                         FROM UIM_UserType
                         UNION ALL
                         SELECT d.parent, s.Id, d.level + 1 -- as level
                         FROM descendants AS d
                                  JOIN UIM_UserType s ON d.descendant = s.ParentId)
                SELECT DISTINCT u.Id AS UserId, u.IsActive, ut.Type,
                                ut.Id AS TypeId,
                                utu.LicenseUserType
                FROM UIM_UserTypeUserMapping utu
                         JOIN
                     (SELECT t.Id AS parent, t.Id AS descendant, 1 AS level
                     FROM UIM_UserType t
                     UNION ALL
                     SELECT parent, descendant AS TypeId, level AS Level
                     FROM descendants) d
                     ON utu.UserTypeId = d.descendant
                         JOIN UIM_UserType ut ON d.parent = ut.Id
                         JOIN AbpUsers u ON u.Id = utu.UserId
                WHERE u.IsDeleted = 0
                  AND u.TenantId IS NOT NULL
                  AND parent IS NOT NULL
                  AND Type = @type
            )
