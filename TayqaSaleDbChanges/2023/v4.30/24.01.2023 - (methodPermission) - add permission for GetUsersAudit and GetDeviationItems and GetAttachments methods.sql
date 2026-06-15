Begin
If Not Exists (Select * From SYS_MethodPermission Where MethodId = 1039 And PermissionId = 67)
INSERT INTO SYS_MethodPermission (MethodId, PermissionId, PermissionValue, Description, CreatedDate)
VALUES (1039, 67, 1, 'Get Users Audit', GETDATE())
End

INSERT INTO SYS_MethodPermission (MethodId, PermissionId, PermissionValue, Description, CreatedDate)
VALUES (940, 67, 1, 'Get Deviation Items', GETDATE())

INSERT INTO SYS_MethodPermission
VALUES(941, 67, 1, 'Get Attachments', GETDATE())