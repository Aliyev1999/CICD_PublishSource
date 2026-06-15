INSERT INTO SYS_AppConfigParameter (Name, Description, Value, Status, ModifiedUserId, CreatedUserId, ModifiedDate,
                                    CreatedDate)
VALUES ('PendingDocsTimerNoteOnThirdParty', 'Pending docs timer note on third party',
        'Third party-den cavab gozlenilir', 1, null, 2, null, GETDATE())
GO
INSERT INTO SYS_PushMethod (Name, Description, ExtraInfo, Url, DataTypeId, PushTypeId, Status, ModifiedUserId,
                            ModifiedDate, CreatedUserId, CreatedDate, Id)
VALUES ('SendWpmData', 'Send WPM data',
        null, null, null, 1, 1, null, null, 2, GETDATE(), 152)
GO
INSERT INTO SYS_MethodPermission
VALUES (410, 67, 1, 'OperationResultDataByDocIdV2', GETDATE())
