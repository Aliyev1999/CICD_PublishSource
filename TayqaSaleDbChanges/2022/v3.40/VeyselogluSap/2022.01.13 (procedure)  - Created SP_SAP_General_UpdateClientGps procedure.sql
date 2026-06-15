CREATE OR ALTER  procedure [dbo].[SP_SAP_General_UpdateClientGps] @firm smallint,
													 	 @clientTigerId int, 
													     @latitude float, 
														 @longitude float,
														 @result bit output
as

UPDATE MD_Client SET 
Latitude = @latitude, 
Longitude = @longitude,
RegisteredDate = GETDATE(),

@result = 1

WHERE 
Firm = @firm AND 
TigerId = @clientTigerId