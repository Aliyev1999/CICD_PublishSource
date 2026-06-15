INSERT INTO SYS_MethodPermission
VALUES (234, 67, 1, 'GetOperationReasonAndImage', GETDATE())

GO

INSERT INTO SYS_MethodPermission
VALUES (235, 67, 1, 'GetOnlinePrintRestriction', GETDATE())

GO

INSERT INTO SYS_MethodPermission(MethodId, PermissionId, PermissionValue, [Description], CreatedDate)
VALUES (2000, 67, 1, N'WorkManagement/CreateTaskSource', GETDATE())
GO