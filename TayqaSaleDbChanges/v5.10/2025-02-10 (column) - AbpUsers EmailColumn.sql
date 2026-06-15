IF EXISTS (SELECT 1
           FROM sys.indexes
           WHERE name = 'IX_AbpUsers_TenantId_NormalizedEmailAddress'
             AND object_id = OBJECT_ID('AbpUsers'))
    BEGIN
        DROP INDEX IX_AbpUsers_TenantId_NormalizedEmailAddress ON AbpUsers;
    END
GO

ALTER TABLE AbpUsers
    ALTER column EmailAddress nvarchar(256) NULL

GO

ALTER TABLE AbpUsers
    ALTER column NormalizedEmailAddress nvarchar(256) null

GO

CREATE INDEX IX_AbpUsers_TenantId_NormalizedEmailAddress
    ON AbpUsers (TenantId, NormalizedEmailAddress)
    WITH (FILLFACTOR = 90)
    ON [PRIMARY]
GO