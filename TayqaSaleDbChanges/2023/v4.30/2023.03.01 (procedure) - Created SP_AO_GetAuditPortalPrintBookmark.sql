CREATE PROCEDURE [dbo].[SP_AO_GetAuditPortalPrintBookmark]
	@debtCheckId INT
AS
BEGIN
-- Author: created by Tofig Amraslanov
-- Description: The query returns the audit portal print bookmarks

		SELECT 'YaradanIstifadeci' as Name, CONCAT(u.Name, ' ', u.Surname) as Value
		from AO_AuditOperation ao
		join AbpUsers u on u.Id=ao.CreatedUserId
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'YaradilmaTarixi' as Name, CAST(FORMAT(ao.CreatedDate, 'yyyy-MM-dd HH:mm:ss') as nvarchar(50)) as Value
		from AO_AuditOperation ao
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'AktTarixi' as Name, CAST(FORMAT(ao.ActDate, 'yyyy-MM-dd') as nvarchar(50)) as Value
		from AO_AuditOperation ao
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'AktNomresi' as Name, ao.ActNo COLLATE SQL_Latin1_General_CP1_CI_AS as Value 
		from AO_AuditOperation ao 
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'Musteri' as Name, CONCAT(c.Name, ' - ', c.Code) as Value
		from AO_AuditOperation ao
		join MD_Client c on c.TigerId=ao.ClientId
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'CariBorc' as Name, CAST(ao.ClientDebt as nvarchar(50)) as Value
		from AO_AuditOperation ao
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'FaktikiBorc' as Name, CAST(ao.ActualDebt as nvarchar(50)) as Value
		from AO_AuditOperation ao
		where ao.Id=@debtCheckId

	UNION ALL
		SELECT 'IlkinKenarlasmaMeblegi' as Name, CAST(ao.InitialDifference as nvarchar(50)) as Value
		from AO_AuditOperation ao
		where ao.Id=@debtCheckId
		
END