IF OBJECT_ID('dbo.F_UIM_OrganizationUserParent', 'IF') IS NOT NULL
DROP FUnction F_UIM_OrganizationUserParent;

GO

CREATE FUNCTION [dbo].[F_UIM_OrganizationUserParent](@isHeadUser BIT)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH organizations AS                                      -- organization tree CTE
                         (SELECT ParentId AS orgParent, Id AS orgChild, 1 AS orgLevel
                         FROM AbpOrganizationUnits
                         WHERE IsDeleted = 0
                         UNION ALL
                         SELECT d.orgParent, s.Id, d.orgLevel + 1
                         FROM organizations AS d
                                  JOIN AbpOrganizationUnits s ON d.orgChild = s.ParentId
                         WHERE s.IsDeleted = 0),

                     usertypes AS                                          -- user type tree CTE
                         (SELECT ParentId AS typeParent, Id AS typeChild, 1 AS typeLevel
                         FROM UIM_UserType
                         UNION ALL
                         SELECT d.typeParent, s.Id, d.typeLevel + 1
                         FROM usertypes AS d
                                  JOIN UIM_UserType s ON d.typeChild = s.ParentId),

                     userOrganizationUnit AS
                         (SELECT DISTINCT uou.UserId ParentUserId, uou1.UserId ChildUserId, ou.orgLevel [Level]
                         FROM organizations ou
                                  JOIN AbpUserOrganizationUnits uou ON ou.orgParent = uou.OrganizationUnitId
                                  JOIN AbpUserOrganizationUnits uou1 ON ou.orgChild = uou1.OrganizationUnitId
                         WHERE uou.IsDeleted = 0
                           AND uou1.IsDeleted = 0)

                -- Query Begins
                SELECT DISTINCT ou.ParentUserId ParentId, ou.ChildUserId UserId, ou.[Level]
                FROM userOrganizationUnit ou
                         JOIN
                     (SELECT tt.Id AS TypeId, tt.Type AS ParentType, ut.UserId
                     FROM UIM_UserTypeUserMapping ut
                              JOIN
                          (SELECT t.Id AS typeParent, t.Id AS typeChild, 1 AS typeLevel
                          FROM UIM_UserType t                              -- selecting item as tree item
                          UNION ALL
                          SELECT typeParent, typeChild, typeLevel
                          FROM usertypes
                          WHERE typeParent IS NOT NULL) d
                          ON ut.UserTypeId = d.typeChild AND ut.IsHeadUser = (IIF(@isHeadUser = 0, ut.IsHeadUser, 1))
                              JOIN UIM_UserType tt ON tt.Id = d.typeParent -- for getting type name
                     WHERE Type IN ('Web', 'Hybrid')) ubt ON ou.ParentUserId = ubt.UserId
            )
GO