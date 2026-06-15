DECLARE @ConstraintName NVARCHAR(128);

-- Get the default constraint name
SELECT @ConstraintName = d.name
FROM sys.default_constraints AS d
JOIN sys.columns AS c
    ON c.column_id = d.parent_column_id
    AND c.object_id = d.parent_object_id
WHERE c.object_id = OBJECT_ID('DTM_CustomAppDashboardUserMapping') 
  AND c.name = 'IsDeleted';

-- Drop the constraint if it exists
IF @ConstraintName IS NOT NULL
BEGIN
    EXEC('ALTER TABLE DTM_CustomAppDashboardUserMapping DROP CONSTRAINT ' + @ConstraintName);
END

GO

ALTER TABLE DTM_CustomAppDashboardUserMapping
DROP COLUMN IsDeleted