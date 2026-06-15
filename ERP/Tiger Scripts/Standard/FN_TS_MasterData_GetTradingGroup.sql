create Function [dbo].[FN_TS_MasterData_GetTradingGroup]()
RETURNS TABLE
AS RETURN
(
SELECT LOGICALREF AS TradingGroupId, GCODE AS Code, GDEF AS Name, ACTIVE AS Status FROM L_TRADGRP WITH (NOLOCK)
);

GO
