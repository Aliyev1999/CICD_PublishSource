ALTER TABLE DTM_CustomAppDashboard
ADD IsClickable BIT NOT NULL DEFAULT 0
GO
ALTER TABLE DTM_CustomAppDashboard
ADD ReportType TINYINT
GO
ALTER TABLE DTM_CustomAppDashboard
ADD ReportId INT
