CREATE FUNCTION [dbo].[FN_WMM_GetAllTables]()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        T.object_id AS Id, 
        T.[name]   AS Name
    FROM sys.tables T
);
GO

