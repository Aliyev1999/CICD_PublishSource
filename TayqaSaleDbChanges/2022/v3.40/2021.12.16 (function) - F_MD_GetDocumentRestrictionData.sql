CREATE FUNCTION [dbo].[F_MD_GetDocumentRestrictionData](@referenceId int, @restrictionType tinyint, @operationId tinyint, @firm smallint, @groupType smallint) RETURNS @T TABLE
                                                                                                                                                                         (
                                                                                                                                                                             Description NVARCHAR(MAX),
                                                                                                                                                                             LineField   tinyint,
                                                                                                                                                                             RegEx       NVARCHAR(MAX),
                                                                                                                                                                             IsRequired  bit
                                                                                                                                                                         ) AS BEGIN
    IF (@restrictionType = 1)
        BEGIN
            INSERT INTO @T
            SELECT Description,
                   LineField,
                   RegExFormat AS RegEx,
                   IsRequired
            FROM SYS_DocumentRestriction docRest
                     INNER JOIN SYS_DocumentRestrictionLine docRestLine
                                ON docRestLine.DocumentRestrictionId = docRest.Id
            WHERE RestrictionType = @restrictionType
              AND ReferenceId = @referenceId
              AND IsActive = 1
              AND OperationId = @operationId
              AND Firm = @firm
        END
    IF (@restrictionType = 2)
        BEGIN
            INSERT INTO @T
            SELECT Description,
                   LineField,
                   RegExFormat AS RegEx,
                   IsRequired
            FROM SYS_DocumentRestriction docRest with(nolock)
                     INNER JOIN SYS_DocumentRestrictionLine docRestLine with(nolock)
                                ON docRestLine.DocumentRestrictionId = docRest.Id
            WHERE RestrictionType = @restrictionType
              AND ReferenceId = @referenceId
              AND IsActive = 1
              AND OperationId = @operationId
              AND Firm = @firm
        END
    IF (@restrictionType = 3)
        BEGIN
            INSERT INTO @T
            SELECT Description,
                   LineField,
                   RegExFormat AS RegEx,
                   IsRequired
            FROM SYS_DocumentRestriction docRest with(nolock)
                     INNER JOIN SYS_DocumentRestrictionLine docRestLine with(nolock)
                                ON docRestLine.DocumentRestrictionId = docRest.Id
            WHERE RestrictionType = @restrictionType
              AND ReferenceId in
                  (SELECT Id
                   FROM MD_ClientGroupInfo with(nolock)
                   WHERE GroupId in
                         (SELECT GroupId
                          FROM MD_ClientGroupData with(nolock)
                          WHERE GroupType = @groupType
                            AND ClientId = @referenceId)
                     AND GroupType = @groupType
                     AND IsDeleted = 0)
              AND IsActive = 1
              AND OperationId = @operationId
              AND Firm = @firm
        END
    RETURN;
END