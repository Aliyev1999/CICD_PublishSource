ALTER TABLE WPM_TaskClient ADD Status Bit NULL
GO
UPDATE WPM_TaskClient SET Status = 0
