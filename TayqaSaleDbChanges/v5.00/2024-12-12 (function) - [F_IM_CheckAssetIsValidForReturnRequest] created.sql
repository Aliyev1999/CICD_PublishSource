CREATE OR ALTER FUNCTION [dbo].[F_IM_CheckAssetIsValidForReturnRequest]
(
    @FirmNr SMALLINT,
    @AssetId INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Message NVARCHAR(100)

    IF EXISTS (
        SELECT 1
        FROM IM_Asset WITH (NOLOCK)
        WHERE Id = @AssetId
          AND Status = 5 
          AND Firm = @FirmNr
    )
    BEGIN
        SET @Message = 'ActiveRequestExists'
    END

    ELSE IF EXISTS (
        SELECT 1
        FROM IM_Asset asset WITH (NOLOCK)
        WHERE Id = @AssetId
		  AND Status=4
          AND Firm = @FirmNr
    )
    BEGIN
        SET @Message = 'AssetDestroyed'
    END

    RETURN @Message
END
