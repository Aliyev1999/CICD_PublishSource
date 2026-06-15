ALTER TABLE MSG_AutoGeneratingReport ADD TenantId INT NULL;
GO
UPDATE MSG_AutoGeneratingReport SET TenantId = 1;
ALTER TABLE MSG_AutoGeneratingReport ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE MSG_ReportFilter ADD TenantId INT NULL;
GO
UPDATE MSG_ReportFilter SET TenantId = 1;
ALTER TABLE MSG_ReportFilter ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE MSG_ReportFilterMapping ADD TenantId INT NULL;
GO
UPDATE MSG_ReportFilterMapping SET TenantId = 1;
ALTER TABLE MSG_ReportFilterMapping ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE MSG_ReportForAutoGenerating ADD TenantId INT NULL;
GO
UPDATE MSG_ReportForAutoGenerating SET TenantId = 1;
ALTER TABLE MSG_ReportForAutoGenerating ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE MSG_ReportUrlMapping ADD TenantId INT NULL;
GO
UPDATE MSG_ReportUrlMapping SET TenantId = 1;
ALTER TABLE MSG_ReportUrlMapping ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE MSG_UIElement ADD TenantId INT NULL;
GO
UPDATE MSG_UIElement SET TenantId = 1;
ALTER TABLE MSG_UIElement ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE SYS_MobileReport ADD TenantId INT NULL;
GO
UPDATE SYS_MobileReport SET TenantId = 1;
ALTER TABLE SYS_MobileReport ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE SYS_MobileReportUserMapping ADD TenantId INT NULL;
GO
UPDATE SYS_MobileReportUserMapping SET TenantId = 1;
ALTER TABLE SYS_MobileReportUserMapping ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE SYS_MobileReportUserMapping ADD ToolType TINYINT NULL;

GO

ALTER TABLE SYS_SpecialReport ADD TenantId INT NULL;
GO
UPDATE SYS_SpecialReport SET TenantId = 1;
ALTER TABLE SYS_SpecialReport ALTER COLUMN TenantId INT NOT NULL;

GO

ALTER TABLE SYS_SpecialReport ADD BarChartInitialStateJson NVARCHAR(MAX) NULL;

ALTER TABLE SYS_SpecialReport ADD DoughnutInitialStateJson NVARCHAR(MAX) NULL;

ALTER TABLE SYS_SpecialReport ADD SplineChartInitialStateJson NVARCHAR(MAX) NULL;

ALTER TABLE SYS_SpecialReport ADD MapInitialStateJson NVARCHAR(MAX) NULL;

