
/****** Object:  StoredProcedure [dbo].[SP_MD_GetMobileReports]    Script Date: 12/15/2022 5:06:12 PM ******/

CREATE OR ALTER PROCEDURE [dbo].[SP_MD_GetMobileReports] @users NVARCHAR(MAX), @reportNameOrCode NVARCHAR(MAX), @modules NVARCHAR(MAX)
AS  
BEGIN  
    DECLARE @usersQuery NVARCHAR(MAX) = 'SELECT M.ReportId, COUNT(*) AS UsersCount
										   FROM SYS_MobileReportUserMapping M
										   WHERE 1 = 1';

	IF @users IS NOT NULL
		BEGIN
			SET @usersQuery = CONCAT(@usersQuery, ' AND (M.UserId IN (SELECT * FROM F_SplitList(@users, '','')))')
		END

	SET @usersQuery = CONCAT(@usersQuery, ' GROUP BY M.ReportId')
	-- MR.Id, MR.Name, MR.Code, MR.Description, MR.CreatorUser, MR.CreationTime, MR.LastModifierUser, LastModificationTime
	DECLARE @mainQuery NVARCHAR(MAX) = CONCAT('SELECT MR.Id, MR.Name AS ReportName, MR.Code AS ReportCode, MR.Description AS ReportDescription, MR.CreationTime, MR.LastModificationTime, CU.UserName as CreatorUser, MU.UserName as LastModifierUser, UQ.UsersCount
										FROM SYS_MobileReport MR

										left join AbpUsers CU on CU.Id = MR.CreatorUserId
										left join AbpUsers MU on MU.Id = MR.LastModifierUserId

												 JOIN (', @usersQuery);

	SET @mainQuery = CONCAT(@mainQuery, ') UQ ON UQ.ReportId = MR.Id WHERE 1 = 1')

	IF @reportNameOrCode IS NOT NULL
		BEGIN
			SET @mainQuery = CONCAT(@mainQuery, ' AND (MR.Name LIKE ''%'+@reportNameOrCode+'%'' OR MR.Code LIKE ''%'+@reportNameOrCode+'%'')')
		END

	IF @modules IS NOT NULL
		BEGIN
			SET @mainQuery = CONCAT('declare @count   int = (select count(*) as Count from F_SplitList(@modules, '',''));
									select Q.* from
									(select ReportId, count(*) As COUNT
									from SYS_MobileReportModuleMapping
									where Module in (select value from F_SplitList(@modules, '',''))
									group by ReportId
									having count(*) = @count) MQ join (', @mainQuery);

			SET @mainQuery = CONCAT(@mainQuery, ') Q on MQ.ReportId = Q.Id');

			-- SET @mainQuery = CONCAT(@mainQuery, ' AND MR.Id IN (SELECT ReportId FROM SYS_MobileReportModuleMapping WHERE Module IN (SELECT * FROM F_SplitList(@modules, '','')))')
		END
    
	PRINT @mainQuery;
  
    EXEC sp_executesql @mainQuery, N'@users NVARCHAR(MAX), @reportNameOrCode NVARCHAR(MAX), @modules NVARCHAR(MAX)', @users = @users, @reportNameOrCode = @reportNameOrCode, @modules = @modules;
  
END
