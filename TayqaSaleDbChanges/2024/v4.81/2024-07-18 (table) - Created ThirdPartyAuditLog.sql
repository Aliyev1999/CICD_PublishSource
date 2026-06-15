

CREATE TABLE [dbo].[OP_ThirdPartyAuditLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[RejecterUserId] [bigint] NULL,
	[RejectionTime] [datetime] NULL,
	[ConfirmerUserId] [bigint] NULL,
	[ConfirmationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))


