
/****** Object:  UserDefinedFunction [dbo].[F_DTM_GetSystemModules]    Script Date: 12/15/2022 4:34:30 PM ******/

CREATE FUNCTION [dbo].[F_DTM_GetSystemModules]()
    Returns Table
        AS
        RETURN
            (
                select top 100 CAST(Id AS TINYINT) AS Id, [Name], PermissionName as Permission, ModuleUrl as [Url], Cast('true' as Bit) as AddIconToHeader, Icon, [Order] AS OrderNo from SYS_Module
				where ModuleUrl is not null --and [Name]<>'DynamicToolsModule'

				union

				SELECT CAST(0 AS TINYINT) AS Id, 'Sql' AS [Name], '' as Permission, '' as [Url], 0 as AddIconToHeader, '' AS Icon, 99 AS OrderNo
            )
