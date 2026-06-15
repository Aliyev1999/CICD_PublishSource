DECLARE @ServiceUserId INT;
SET @ServiceUserId = (SELECT Id
                      FROM AbpUsers
                      WHERE UserName = 'service_user');

INSERT INTO AbpPermissions (CreationTime, CreatorUserId, Discriminator, IsGranted, Name, TenantId, RoleId, UserId)
VALUES (GETDATE(), 2, 'UserPermissionSetting', 1, 'Pages.Wpm', 1, null, 3),
       (GETDATE(), 2, 'UserPermissionSetting', 1, 'Pages.Wpm.Management.Tasks.Create', 1, null, 3)
GO
DECLARE @ServiceUserId INT;
SET @ServiceUserId = (SELECT Id
                      FROM AbpUsers
                      WHERE UserName = 'service_user');

INSERT INTO AbpSettings (CreationTime, CreatorUserId, Name, TenantId, UserId, Value)
Values (GETDATE(), 2, 'Abp.Localization.DefaultLanguageName', 1, 3, 'az')