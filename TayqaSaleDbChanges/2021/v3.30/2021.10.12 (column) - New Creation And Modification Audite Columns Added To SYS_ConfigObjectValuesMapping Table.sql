ALTER TABLE SYS_ConfigObjectValuesMapping ADD CreatorUserId BIGINT NULL;

ALTER TABLE SYS_ConfigObjectValuesMapping ADD CreationTime DATETIME NULL;

GO

UPDATE SYS_ConfigObjectValuesMapping SET CreationTime=GETDATE()

ALTER TABLE SYS_ConfigObjectValuesMapping ALTER COLUMN CreationTime DATETIME NOT NULL;

ALTER TABLE SYS_ConfigObjectValuesMapping ADD  DEFAULT (GETDATE()) FOR [CreationTime]

ALTER TABLE SYS_ConfigObjectValuesMapping ADD LastModifierUserId BIGINT NULL;

ALTER TABLE SYS_ConfigObjectValuesMapping ADD LastModificationTime DATETIME NULL;
