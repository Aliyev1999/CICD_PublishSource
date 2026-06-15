INSERT INTO DF_ClientGroupType ([Type], [Name]) VALUES (7, 'SurveyNormativeGroup')

INSERT INTO SYS_GlobalConfigParameter ([Name], [Value], [Description], [Status], CreatedDate)
VALUES ('ClientGroupTypeForNormatives', '7', 'Required Restart RequestProcessor and ServicePortal', 1, GETDATE())
