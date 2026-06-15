CREATE OR ALTER PROCEDURE [dbo].[SP_TP_DeleteSerialNumber](@requestId INT NULL,
                                                             @partNo TINYINT NULL)
AS
BEGIN
    BEGIN TRY
        IF @requestId IS NULL OR @partNo IS NULL
            RAISERROR('NULL Value is passed', 1, 1)
        ELSE
            DECLARE @Query NVARCHAR(MAX) = 'DELETE FROM OP_ThirdPartyRequestQueueCommonLineSerialNumberExtension WHERE Id = @requestId AND PartNo = @partNo'
    END TRY
    BEGIN CATCH
		PRINT('A Null Value is passed')
	END CATCH

-- PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@requestId INT,
         @partNo TINYINT',
         @requestId=@requestId,
         @partNo=@partNo

END
GO
