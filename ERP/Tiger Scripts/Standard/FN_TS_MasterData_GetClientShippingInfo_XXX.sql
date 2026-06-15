create Function [dbo].[FN_TS_MasterData_GetClientShippingInfo_XXX]()
RETURNS TABLE
AS RETURN
(
SELECT LOGICALREF AS ShipAddressId, CLIENTREF As ClientId, Code AS Code, NAme AS Name, ACTIVE AS Status, SPECODE AS Specode, CYPHCODE AS Cyphcode
FROM LG_XXX_SHIPINFO WITH (NOLOCK)
);

GO
