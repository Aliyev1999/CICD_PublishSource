ALTER TABLE MSG_Notification ADD IsAnswerable BIT NULL
GO
UPDATE MSG_Notification SET IsAnswerable = 0
GO
ALTER TABLE MSG_Notification ALTER COLUMN IsAnswerable BIT NOT NULL
GO
ALTER TABLE MSG_Notification ADD AnswerType TINYINT NULL
GO
ALTER TABLE MSG_Notification
ADD NotificationUserTargetType TINYINT NOT NULL
CONSTRAINT DF_MSG_Notification_NotificationUserTargetType DEFAULT 1;

