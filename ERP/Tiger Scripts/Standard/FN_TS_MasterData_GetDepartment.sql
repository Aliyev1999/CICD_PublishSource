create Function [dbo].[FN_TS_MasterData_GetDepartment]()
RETURNS TABLE
AS RETURN
(
SELECT FIRMNR AS Firm, NR AS Nr, PASSIVE AS Status, NAME AS Name FROM L_CAPIDEPT WITH (NOLOCK)
);

GO
