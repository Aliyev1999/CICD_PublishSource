
CREATE TABLE [dbo].[MD_UserGroupPermittedPaymentPlan](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_UserGroupPermittedPaymentPlan] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedPaymentPlan] ADD  CONSTRAINT [DF_MD_UserGroupPermittedPaymentPlan_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO


