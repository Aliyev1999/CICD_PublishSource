create Function [dbo].[FN_TS_MasterData_GetWarehouse]()
RETURNS TABLE
AS RETURN
(
SELECT FIRMNR AS Firm, DIVISNR AS DivisionNr, NR AS Nr, NAME AS Name, COSTGRP AS CostGroup FROM L_CAPIWHOUSE WITH (NOLOCK)
);
GO
