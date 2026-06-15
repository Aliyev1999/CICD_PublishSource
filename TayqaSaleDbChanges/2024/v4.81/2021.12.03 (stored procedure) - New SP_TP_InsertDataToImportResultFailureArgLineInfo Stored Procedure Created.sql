CREATE OR ALTER PROCEDURE [dbo].[SP_TP_InsertDataToImportResultFailureArgLineInfo](@requestId INT NULL,
                                                             @partNo TINYINT NULL,
                                                             @name NVARCHAR(MAX),
                                                             @code NVARCHAR(MAX),
                                                             @description NVARCHAR(MAX))
AS
BEGIN
    DECLARE @Query NVARCHAR(MAX);
    
    BEGIN TRY
        IF @requestId IS NULL OR @partNo IS NULL
            RAISERROR('NULL Value is passed', 1, 1)
        
        ELSE
            SET @Query = 'INSERT INTO OP_ThirdPartyImportResultFailureArgLineInfo (RequestId, PartNo, Name, Code, Description) VALUES (@requestId, @partNo, @name, @code, @description)'

    END TRY
    BEGIN CATCH
		PRINT('Error Occurred')
	END CATCH

-- PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@requestId INT,
         @partNo TINYINT,
         @name NVARCHAR(MAX),
         @code NVARCHAR(MAX),
         @description NVARCHAR(MAX)',
         @requestId = @requestId,
         @partNo = @partNo,
         @name = @name,
         @code = @code,
         @description = @description

END
GO
