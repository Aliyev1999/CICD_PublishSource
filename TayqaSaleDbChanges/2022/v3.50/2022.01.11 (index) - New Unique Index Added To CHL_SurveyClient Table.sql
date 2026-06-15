
-- Get backup of CHL_SurveyClient table

SELECT * INTO CHL_SurveyClient_Duplicate_Data_Backup FROM CHL_SurveyClient;

-- Delete duplicate mapping records

WITH DeleteRecords AS (
    SELECT ReferenceId,
        SurveyId,
        [Type],
        ROW_NUMBER() over(PARTITION BY ReferenceId, SurveyId, [Type] ORDER BY Id) AS DeleteNumber
    FROM CHL_SurveyClient
)

DELETE FROM DeleteRecords WHERE DeleteNumber > 1;


-- Create unique index

DECLARE @indexCount INT = (SELECT Count(*) FROM sys.indexes WHERE name='SurveyClient_Unique' AND object_id = OBJECT_ID('dbo.CHL_SurveyClient'))

IF @indexCount = 0
BEGIN
    CREATE UNIQUE INDEX IX_CHL_SurveyClient_SurveyId_ReferenceId_Type
    ON CHL_SurveyClient(SurveyId, ReferenceId, [Type]);
END