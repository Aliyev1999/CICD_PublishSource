create Function [dbo].[FN_TS_MasterData_GetDivision]()
RETURNS TABLE
AS RETURN
(
SELECT FIRMNR AS Firm, NR AS Nr, 0 AS Status, NAME AS Name FROM L_CAPIDIV WITH (NOLOCK)
);
GO
