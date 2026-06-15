CREATE OR ALTER PROCEDURE [dbo].[SP_TP_UpdateRequestStep](@requestId INT NULL,
                                                             @partNo TINYINT NULL,
                                                             @step TINYINT NULL)
AS
BEGIN
    DECLARE @Query NVARCHAR(MAX);
    
    BEGIN TRY
        IF @requestId IS NULL OR @partNo IS NULL OR @step IS NULL
            RAISERROR('NULL Value is passed', 1, 1)
        
        ELSE IF @step NOT IN (10, 11)
            RAISERROR('Invalid Step Input', 1, 1)
        
        ELSE IF (SELECT COUNT(*) FROM OP_ThirdPartyRequestQueue RQ WHERE RQ.Id = @requestId AND RQ.PartNo = @partNo AND Step = 5) = 0
            RAISERROR('There Is Not Valid Line In OP_ThirdPartyRequestQueue Table For Update', 1, 1)
        
        ELSE IF @step = 11 AND ((SELECT COUNT(*) FROM OP_ThirdPartyImportResult IR WHERE IR.RequestId = @requestId AND IR.PartNo = @partNo) = 0)
            RAISERROR('There Is Not Line In OP_ThirdPartyImportResult', 1, 1)

        ELSE
            SET @Query = 'UPDATE OP_ThirdPartyRequestQueue SET Step = @step WHERE Id = @requestId AND PartNo = @partNo AND Step = 5'

    END TRY
    BEGIN CATCH
		PRINT('Error Occurred')
	END CATCH

-- PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@requestId INT,
         @partNo TINYINT,
         @step TINYINT',
         @requestId = @requestId,
         @partNo = @partNo,
         @step = @step

END
GO
