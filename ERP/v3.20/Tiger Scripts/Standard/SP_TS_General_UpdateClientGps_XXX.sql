ALTER PROCEDURE [dbo].[SP_TS_General_UpdateClientGps_XXX] @clientId int,
                                                          @longitude float,
                                                          @latitude float
AS
BEGIN
    UPDATE LG_XXX_CLCARD
    SET LONGITUDE=@longitude,
        LATITUTE=@latitude,
        CAPIBLOCK_MODIFIEDDATE = GETDATE(),
        CAPIBLOCK_MODIFIEDHOUR = DATEPART(HOUR, GETDATE()),
        CAPIBLOCK_MODIFIEDMIN = DATEPART(MINUTE, GETDATE()),
        CAPIBLOCK_MODIFIEDSEC = DATEPART(SECOND, GETDATE())
    WHERE LOGICALREF = @clientId

END;