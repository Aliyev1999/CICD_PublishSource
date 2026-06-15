EXEC sp_rename 'dbo.DTM_MobileScreenCreateEditField.ComponentId', 'AdditionalExpression', 'COLUMN';

GO

ALTER TABLE DTM_MobileScreenCreateEditField
ALTER COLUMN AdditionalExpression nvarchar(100);