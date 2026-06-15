ALTER TABLE OP_AdministrativePushLog
    ADD MessageName varchar(300);
GO
ALTER TABLE OP_PushLog
    ADD MessageName varchar(300);