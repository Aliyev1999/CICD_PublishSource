Create Function [dbo].[FN_TS_MasterData_GetFirm] ()
RETURNS TABLE 
AS RETURN
(
SELECT LOGICALREF AS Id, Name, Nr, LOCALCTYP AS LocalCurrencyType, FIRMREPCURR As ReportCurrencyType FROM L_CAPIFIRM WITH (NOLOCK)
);
GO
