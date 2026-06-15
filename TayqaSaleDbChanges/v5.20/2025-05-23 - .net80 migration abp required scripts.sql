ALTER TABLE AbpTenants
    ADD
        LightLogoMinimalFileType NVARCHAR(64),
        LightLogoMinimalId UNIQUEIDENTIFIER,
        LightLogoFileType NVARCHAR(64),
        LightLogoId UNIQUEIDENTIFIER,
        DarkLogoFileType NVARCHAR(64),
        DarkLogoId UNIQUEIDENTIFIER,
        DarkLogoMinimalFileType NVARCHAR(64),
        DarkLogoMinimalId UNIQUEIDENTIFIER;

GO

ALTER TABLE AbpUsers
    ADD
        RecoveryCode NVARCHAR(1000);

GO

ALTER TABLE AbpNotificationSubscriptions
    ADD
        TargetNotifiers NVARCHAR(1024);

GO

ALTER TABLE AbpUserNotifications
    ADD
        TargetNotifiers NVARCHAR(3000);

GO

ALTER TABLE AbpNotifications
    ADD
        TargetNotifiers NVARCHAR(3000);

GO

ALTER TABLE AbpUserLoginAttempts
    ADD
        FailReason NVARCHAR(1024);

GO

ALTER TABLE AppBinaryObjects
    ADD
        Description NVARCHAR(1024);

GO