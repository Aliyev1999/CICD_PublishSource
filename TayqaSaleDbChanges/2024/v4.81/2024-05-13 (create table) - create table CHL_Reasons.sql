CREATE TABLE [dbo].[CHL_Reasons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AnswerId] [int] NOT NULL,
	[MandatoryType] [tinyint] NOT NULL,
	[SelectionType] [tinyint] NULL,
	[ReasonId] [int] NULL,
	[ReasonValue] [nvarchar](max) NULL,
	[ReasonType] [tinyint] NOT NULL,
	[CustomReasonInputType] [tinyint] NULL
)
