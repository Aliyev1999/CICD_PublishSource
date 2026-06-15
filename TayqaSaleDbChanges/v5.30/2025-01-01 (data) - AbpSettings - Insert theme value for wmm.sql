IF NOT EXISTS (SELECT 1 FROM abpsettings WHERE [Name] = 'App.UiManagement.Theme')
BEGIN
    INSERT INTO abpsettings (CreationTime, TenantId, UserId, ProviderName, ProviderKey, [Name], Value)
    VALUES (GETDATE(), 2, NULL, NULL, 'App.UiManagement.Theme', 1, 'theme5');
END