CREATE OR ALTER PROCEDURE [dbo].[SP_TP_InsertDataToImportResult](@requestId INT NULL,
                                                             @partNo TINYINT NULL,
                                                             @importResultId INT NULL,
                                                             @description NVARCHAR(MAX))
AS
BEGIN
    DECLARE @Query NVARCHAR(MAX);
    
    BEGIN TRY
        IF @requestId IS NULL OR @partNo IS NULL OR @importResultId IS NULL
            RAISERROR('NULL Value is passed', 1, 1)
        
        ELSE IF @importResultId = 0
            RAISERROR('Invalid Input For @importResultId', 1, 1)

        ELSE
            SET @Query = 'INSERT INTO OP_ThirdPartyImportResult (RequestId, PartNo, ImportResultId, ImportResultDesc) VALUES (@requestId, @partNo, @importResultId, @description)'

    END TRY
    BEGIN CATCH
		PRINT('Error Occurred')
	END CATCH

-- PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@requestId INT,
         @partNo TINYINT,
         @importResultId INT,
         @description NVARCHAR(MAX)',
         @requestId = @requestId,
         @partNo = @partNo,
         @importResultId = @importResultId,
         @description = @description

END
GO
