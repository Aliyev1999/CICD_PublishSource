Create or alter  FUNCTION [dbo].[F_UIM_GetOrganizationTreeAllUsersIncludeInActiveDeleted](
    -- Add the parameters for the function here
    @userId BIGINT
)
    RETURNS TABLE
        AS
        RETURN
            (
                -- Add the SELECT statement with parameter references here
                WITH organizations AS                                                     -- organization tree CTE
                         (SELECT ParentId AS orgParent, Id AS orgChild, 1 AS orgLevel
                          FROM AbpOrganizationUnits WITH (NOLOCK)
                          WHERE IsDeleted = 0
                          UNION ALL
                          SELECT d.orgParent, s.Id, d.orgLevel + 1
                          FROM organizations AS d
                                   JOIN AbpOrganizationUnits s WITH (NOLOCK) ON d.orgChild = s.ParentId
                          WHERE s.IsDeleted = 0),

                     usertypes AS                                                         -- user type tree CTE
                         (SELECT ParentId AS typeParent, Id AS typeChild, 1 AS typeLevel
                          FROM UIM_UserType WITH (NOLOCK)
                          UNION ALL
                          SELECT d.typeParent, s.Id, d.typeLevel + 1
                          FROM usertypes AS d
                                   JOIN UIM_UserType s WITH (NOLOCK) ON d.typeChild = s.ParentId),

                     userOrganizationUnit AS
                         (SELECT DISTINCT uou1.UserId
                          FROM organizations ou
                                   JOIN AbpUserOrganizationUnits uou WITH (NOLOCK) ON ou.orgParent = uou.OrganizationUnitId
                                   JOIN AbpUserOrganizationUnits uou1 WITH (NOLOCK) ON ou.orgChild = uou1.OrganizationUnitId
                          WHERE uou.IsDeleted = 0
                            AND uou1.IsDeleted = 0
                            AND uou.UserId = @userId)

                     -- Query Begins
                SELECT @userId AS UserId, Type AS ParentType, usr.IsActive, usr.IsDeleted
                FROM F_GetRootTypeOfAllUsersIncludingInActive() rt
				JOIN AbpUsers usr WITH(NOLOCK) ON rt.UserId = usr.Id
                WHERE Type = 'Hybrid' and rt.UserId = @userId
                UNION
                SELECT DISTINCT ou.UserId, ubt.ParentType, ubt.IsActive, ubt.IsDeleted
                FROM userOrganizationUnit ou
                         JOIN
                     (SELECT tt.Id AS TypeId, tt.Type AS ParentType, ut.UserId, u.IsActive, u.IsDeleted
                      FROM UIM_UserTypeUserMapping ut WITH (NOLOCK)
                               JOIN AbpUsers u WITH (NOLOCK) ON u.Id = ut.UserId
                               JOIN
                           (SELECT t.Id AS typeParent, t.Id AS typeChild, 1 AS typeLevel
                            FROM UIM_UserType t WITH (NOLOCK)                             -- selecting item as tree item
                            UNION ALL
                            SELECT typeParent, typeChild, typeLevel
                            FROM usertypes
                            WHERE typeParent IS NOT NULL) d
                           ON ut.UserTypeId = d.typeChild
                               JOIN UIM_UserType tt WITH (NOLOCK) ON tt.Id = d.typeParent -- for getting type name
                      WHERE Type IN ('App', 'Hybrid', 'Web')) ubt ON ou.UserId = ubt.UserId
            )
GO


