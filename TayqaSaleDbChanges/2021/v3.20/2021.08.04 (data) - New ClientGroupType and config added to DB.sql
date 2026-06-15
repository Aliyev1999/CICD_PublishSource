ALTER TABLE SYS_GlobalConfigParameter ALTER COLUMN [Name] NVARCHAR (60) NOT NULL;

INSERT INTO DF_ClientGroupType ([Type], Name) VALUES (6, N'ItemQuantityRestrictionGroup')

INSERT INTO SYS_GlobalConfigParameter(Name, [Value], [Description], [Status], CreatedDate)
VALUES('ClientGroupTypeForSpecialItemRestrictionGroupType', '1', 'Required Restart RequestProcessor, ERPInegration and ServicePortal', 1, GETDATE());
