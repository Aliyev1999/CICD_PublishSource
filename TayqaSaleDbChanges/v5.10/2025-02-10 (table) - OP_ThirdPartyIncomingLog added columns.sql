ALTER TABLE OP_ThirdPartyIncomingLog
ADD FeedbackUserId BIGINT NULL

GO

ALTER TABLE OP_ThirdPartyIncomingLog
ADD FeedbackReasonId INT NULL

GO

ALTER TABLE OP_ThirdPartyIncomingLog
ADD FeedbackNote NVARCHAR(MAX) NULL