

go

create procedure SP_TDP_GetTransitionLocations
as
begin

	select a.[Key], a.Value, cast(1 as tinyint) as Type from SYS_AppActivities a				-- Screen
	where Type = 1
	union
	select a.[Key], a.Value, cast(2 as tinyint) as Type from SYS_AppActivities a				-- Report
	where Type = 2
	union
	select cast(screen.Id as nvarchar(10)), screen.Name, cast(3 as tinyint)	as Type				-- Dynamic screen
	from DTM_MobileScreen screen
	where screen.IsDeleted = 0
	group by screen.Id, screen.Name
	union
	select cast(report.Id as nvarchar(10)), report.Name, cast(4 as tinyint)	as Type				-- Dynamic report
	from DTM_MobileReport report
	where report.IsDeleted = 0
	group by report.Id, report.Name

	order by [Key]
end

go