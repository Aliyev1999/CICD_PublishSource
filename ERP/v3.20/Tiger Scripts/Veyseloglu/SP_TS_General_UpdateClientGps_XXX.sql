USE [ReportBase]
GO

-- Originally written by TayqaTech, last modified by Mirsamad Suleymanov on 24.06.2021 to update based on EDINO
-- Procedure updates client's GPS date (latitude and longitude) based on LOGICALREF

ALTER PROCEDURE [dbo].[SP_TS_General_UpdateClientGps_152] @clientId int,
                                                          @longitude float,
                                                          @latitude float
AS
BEGIN
    UPDATE LG_152_CLCARD
    SET LONGITUDE=@longitude,
        LATITUTE=@latitude,
        CAPIBLOCK_MODIFIEDDATE = GETDATE(),
        CAPIBLOCK_MODIFIEDHOUR = DATEPART(HOUR, GETDATE()),
        CAPIBLOCK_MODIFIEDMIN = DATEPART(MINUTE, GETDATE()),
        CAPIBLOCK_MODIFIEDSEC = DATEPART(SECOND, GETDATE())
    WHERE EDINO = (select top 1 EDINO FROM LG_152_CLCARD where LOGICALREF = @clientId)
END;