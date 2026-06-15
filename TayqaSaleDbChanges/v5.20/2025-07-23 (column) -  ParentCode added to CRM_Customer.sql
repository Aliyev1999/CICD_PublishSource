IF NOT EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'CRM_Customer' 
      AND COLUMN_NAME = 'ParentCode'
)
BEGIN
    ALTER TABLE CRM_Customer
    ADD ParentCode nvarchar(100);
END
