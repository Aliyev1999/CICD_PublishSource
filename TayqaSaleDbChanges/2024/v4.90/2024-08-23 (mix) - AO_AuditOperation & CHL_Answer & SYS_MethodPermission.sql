ALTER TABLE CHL_Answer
    ADD CreatorUserId bigint
GO
ALTER TABLE AO_AuditOperation
    ADD ReferenceId nvarchar(max)
GO
INSERT INTO SYS_MethodPermission
VALUES (130, 67, 1, 'GetAppTranslations', GETDATE())
GO
INSERT INTO SYS_MethodPermission
VALUES (1650, 67, 1, 'GetClientGroupTotalDebt', GETDATE())