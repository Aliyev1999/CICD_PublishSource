CREATE OR ALTER FUNCTION [dbo].[F_IM_CheckAssetIsValidForBinding]
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
        FROM IM_AssetBinding WITH (NOLOCK)
        WHERE AssetId = @AssetId 
          AND Status = 1
          AND Firm = @FirmNr
    )
    BEGIN
        SET @Message = 'ActiveBindingExists'
    END

    ELSE IF EXISTS (
        SELECT 1
        FROM IM_Asset WITH (NOLOCK)
        WHERE Id = @AssetId
          AND Status = 3
          AND Firm = @FirmNr
    )
    BEGIN
        SET @Message = 'AlreadyInUse'
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

	  ELSE IF EXISTS (
          SELECT 1
        FROM IM_Asset asset WITH (NOLOCK)
        WHERE Id = @AssetId
		  AND Status=5
          AND Firm = @FirmNr

	)
    BEGIN
        SET @Message = 'Other'
    END

    ELSE
    BEGIN
        SET @Message = 'Ok'
    END

    RETURN @Message
END