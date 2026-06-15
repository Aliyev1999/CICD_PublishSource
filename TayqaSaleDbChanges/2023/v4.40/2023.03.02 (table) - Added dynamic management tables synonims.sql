EXEC sp_rename 'SYS_DynamicComponent', 'DTM_DynamicComponent';
GO
CREATE SYNONYM SYS_DynamicComponent
FOR DTM_DynamicComponent;
GO



EXEC sp_rename 'SYS_DynamicComponentDisplayColumns', 'DTM_DynamicComponentDisplayColumns';
GO
CREATE SYNONYM SYS_DynamicComponentDisplayColumns
FOR DTM_DynamicComponentDisplayColumns;
GO


EXEC sp_rename 'SYS_DynamicAPI', 'DTM_WebApi';
GO
CREATE SYNONYM SYS_DynamicAPI
FOR DTM_WebApi;
GO


EXEC sp_rename 'SYS_DynamicMobileScreen', 'DTM_MobileScreen';
GO
CREATE SYNONYM SYS_DynamicMobileScreen
FOR DTM_MobileScreen;
GO

EXEC sp_rename 'SYS_DynamicNotification', 'DTM_Notification';
GO
CREATE SYNONYM SYS_DynamicNotification
FOR DTM_Notification;
GO

EXEC sp_rename 'SYS_DynamicNotificationUserMapping', 'DTM_NotificationUserMapping';
GO
CREATE SYNONYM SYS_DynamicNotificationUserMapping
FOR DTM_NotificationUserMapping;
GO

EXEC sp_rename 'SYS_DynamicToolInnerQuery', 'DTM_SubQuery';
GO
CREATE SYNONYM SYS_DynamicToolInnerQuery
FOR DTM_SubQuery;
GO

EXEC sp_rename 'SYS_DynamicWebScreen', 'DTM_WebScreen';
GO
CREATE SYNONYM SYS_DynamicWebScreen
FOR DTM_WebScreen;
GO


EXEC sp_rename 'SYS_DynamicWebToolCustomisedColumn', 'DTM_QueryColumnProperty';
GO
CREATE SYNONYM SYS_DynamicWebToolCustomisedColumn
FOR DTM_QueryColumnProperty;
GO

EXEC sp_rename 'SYS_DynamicWebToolNonHeaderFilter', 'DTM_WebToolFilter';
GO
CREATE SYNONYM SYS_DynamicWebToolNonHeaderFilter
FOR DTM_WebToolFilter;
GO

EXEC sp_rename 'SYS_DynamicWebToolUserMapping', 'DTM_WebToolUserMapping';
GO
CREATE SYNONYM SYS_DynamicWebToolUserMapping
FOR DTM_WebToolUserMapping;
GO

EXEC sp_rename 'SYS_MobileReport', 'DTM_MobileReport';
GO
CREATE SYNONYM SYS_MobileReport
FOR DTM_MobileReport;
GO

EXEC sp_rename 'SYS_MobileReportCardItems', 'DTM_MobileReportCardProperty';
GO
CREATE SYNONYM SYS_MobileReportCardItems
FOR DTM_MobileReportCardProperty;
GO

EXEC sp_rename 'SYS_MobileReportFilterMask', 'DTM_MobileReportFilterMask';
GO
CREATE SYNONYM SYS_MobileReportFilterMask
FOR DTM_MobileReportFilterMask;
GO

EXEC sp_rename 'SYS_MobileScreenCreateEditFields', 'DTM_MobileScreenCreateEditField';
GO
CREATE SYNONYM SYS_MobileScreenCreateEditFields
FOR DTM_MobileScreenCreateEditField;
GO

EXEC sp_rename 'SYS_MobileReportUserMapping', 'DTM_MobileReportUserMapping';
GO
CREATE SYNONYM SYS_MobileReportUserMapping
FOR DTM_MobileReportUserMapping;
GO

EXEC sp_rename 'SYS_MobileScreenCardItems', 'DTM_MobileScreenCardProperty';
GO
CREATE SYNONYM SYS_MobileScreenCardItems
FOR DTM_MobileScreenCardProperty;
GO

EXEC sp_rename 'SYS_MobileScreenIcons', 'DTM_MobileScreenIcon';
GO
CREATE SYNONYM SYS_MobileScreenIcons
FOR DTM_MobileScreenIcon;
GO

EXEC sp_rename 'SYS_NonDataSourceRelatedComponentsData', 'DTM_CustomValueComponent';
GO
CREATE SYNONYM SYS_NonDataSourceRelatedComponentsData
FOR DTM_CustomValueComponent;
GO


EXEC sp_rename 'SYS_NonGridRelatedAction', 'DTM_WebScreenMasterAction';
GO
CREATE SYNONYM SYS_NonGridRelatedAction
FOR DTM_WebScreenMasterAction;
GO

EXEC sp_rename 'SYS_NonGridRelatedActionInput', 'DTM_WebScreenMasterActionInput';
GO
CREATE SYNONYM SYS_NonGridRelatedActionInput
FOR DTM_WebScreenMasterActionInput;
GO


EXEC sp_rename 'SYS_SpecialReport', 'DTM_WebReport';
GO
CREATE SYNONYM SYS_SpecialReport
FOR DTM_WebReport;
GO
