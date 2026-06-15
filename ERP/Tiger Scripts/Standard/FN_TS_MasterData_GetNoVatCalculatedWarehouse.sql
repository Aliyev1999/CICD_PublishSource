create Function FN_TS_MasterData_GetNoVatCalculatedWarehouse()
RETURNS TABLE
AS RETURN
(
SELECT FIRMNR AS Firm, NR AS WarehouseNr  FROM L_CAPIWHOUSE
where SITEID=2
);