
EXEC sp_rename 'SYS_DynamicCustomDashboard', 'DTM_CustomAppDashboard';
GO
CREATE SYNONYM SYS_DynamicCustomDashboard
FOR DTM_CustomAppDashboard;
GO


EXEC sp_rename 'SYS_DynamicCustomDashboardUserMapping', 'DTM_CustomAppDashboardUserMapping';
GO
CREATE SYNONYM SYS_DynamicCustomDashboardUserMapping
FOR DTM_CustomAppDashboardUserMapping;
GO


EXEC sp_rename 'SYS_DynamicCustomDashboardVisual', 'DTM_CustomAppDashboardVisual';
GO
CREATE SYNONYM SYS_DynamicCustomDashboardVisual
FOR DTM_CustomAppDashboardVisual;
GO



EXEC sp_rename 'SYS_FolderStructure', 'DTM_FolderStructure';
GO
CREATE SYNONYM SYS_FolderStructure
FOR DTM_FolderStructure;
GO