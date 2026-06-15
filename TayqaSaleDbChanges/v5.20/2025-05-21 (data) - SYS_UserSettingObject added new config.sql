SET IDENTITY_INSERT SYS_UserSettingObject ON;

insert into SYS_UserSettingObject(Id, Name, Description, Status, CreatedUserId, CreatedDate)
values(25, 'OnlinePrintRestriction', 'Online Print Restriction', 1,2,GETDATE())

SET IDENTITY_INSERT SYS_UserSettingObject OFF;
