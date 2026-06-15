
INSERT INTO SYS_Module (Id, [Name], [Description], ModuleUrl, CreatedDate, HasOwnOrganizationStructure, PermissionName, Icon, [Order], ShowingOnUI, AppModuleName)
VALUES (12, 'DynamicToolsModule', 'Dynamic Tools Module', 'http://localhost:1400', GETDATE(), 0, 'DynamicToolsModule', 'fa fa-line-chart', 12, 1, 'DynamicToolsModule')

UPDATE SYS_Module SET Icon = 'fa fa-cog' WHERE [Name] = 'TDP'
