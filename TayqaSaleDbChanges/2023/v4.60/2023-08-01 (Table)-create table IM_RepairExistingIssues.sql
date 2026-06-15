

CREATE TABLE [dbo].[IM_RepairExistingIssues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[DemandId] [int] NOT NULL,
	[IssueId] [int] NOT NULL,
 CONSTRAINT [PK_IM_REPAIREXISTINGISSUES] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO


