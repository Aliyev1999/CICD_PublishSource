CREATE PROCEDURE dbo.GetAndUpdateImageProcessingQueue
    @getAll BIT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TempQueue TABLE
    (
        Id BIGINT,
        ImageId INT,
        ImageUrl NVARCHAR(255),
        PlanogramId INT,
        AnalysisTypes NVARCHAR(255),
        RequestMethod TINYINT,
        SourceType TINYINT,
        IsProcessing BIT
    );

    IF @getAll = 1
    BEGIN
        INSERT INTO @TempQueue
        SELECT
            Id, ImageId, ImageUrl, PlanogramId, AnalysisTypes, RequestMethod, SourceType, IsProcessing
        FROM IP_Queue
        WHERE IsProcessing = 0;
    END
    ELSE
    BEGIN
        INSERT INTO @TempQueue
        SELECT TOP 1
            Id, ImageId, ImageUrl, PlanogramId, AnalysisTypes, RequestMethod, SourceType, IsProcessing
        FROM IP_Queue
        WHERE IsProcessing = 0;
    END

    IF EXISTS (SELECT 1 FROM @TempQueue)
    BEGIN
        UPDATE IP_Queue
        SET IsProcessing = 1
        WHERE Id IN (SELECT Id FROM @TempQueue);

        SELECT * FROM @TempQueue;
    END
END;