ALTER TABLE WPM_Task
    ALTER COLUMN TaskFinishControl bit
go

ALTER TABLE WPM_Task
    ADD CONSTRAINT DF_WPM_Task_HasOnlineActions DEFAULT 0 FOR HasOnlineActions;
go