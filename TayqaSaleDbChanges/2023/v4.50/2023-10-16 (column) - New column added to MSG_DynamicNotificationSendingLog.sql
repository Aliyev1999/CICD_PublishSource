ALTER TABLE MSG_DynamicNotificationSendingLog
ADD SendingScheduleTime DATETIME NOT NULL DEFAULT GETDATE()
