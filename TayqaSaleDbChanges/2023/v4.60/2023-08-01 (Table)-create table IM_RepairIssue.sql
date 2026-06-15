

CREATE TABLE [dbo].[IM_RepairIssue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DemandId] [int] NOT NULL,
	[IssueId] [int] NOT NULL,
	[IsResolved] [bit] NOT NULL,
 CONSTRAINT [PK_IM_REPAIRISSUE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

ALTER TABLE [dbo].[IM_RepairIssue] ADD  DEFAULT ((0)) FOR [IsResolved]
GO


