
-- 1. Drop the PK first
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'PK_MD_ItemGroup' AND type = 'PK')
BEGIN
    ALTER TABLE MD_ItemGroup DROP CONSTRAINT PK_MD_ItemGroup;
END

-- 2. Add the temporary column
ALTER TABLE MD_ItemGroup ADD Id_New INT NULL;
GO -- Use GO to ensure the column exists before the next step

-- 3. Copy data
UPDATE MD_ItemGroup SET Id_New = Id;
GO

-- 4. Drop the IDENTITY column
ALTER TABLE MD_ItemGroup DROP COLUMN Id;
GO

-- 5. Rename the new column to 'Id'
EXEC sp_rename 'MD_ItemGroup.Id_New', 'Id', 'COLUMN';
GO

-- 6. Now that it is just a regular INT column, set to NOT NULL
-- (No need to update Id = 0 if you copied values from a PK which were already non-null)
ALTER TABLE MD_ItemGroup ALTER COLUMN Id INT NOT NULL;
GO

-- 7. Re-add the Primary Key
ALTER TABLE MD_ItemGroup ADD CONSTRAINT PK_MD_ItemGroup PRIMARY KEY (Id);
GO
