CREATE PROCEDURE [dbo].[SP_TS_General_UpdateClientGps_XXX] (
	@clientId int,
	@longitude float,
	@latitude float	
) AS
BEGIN
UPDATE LG_XXX_CLCARD SET LONGITUDE=@longitude, LATITUTE=@latitude
WHERE LOGICALREF=@clientId

END;
GO
