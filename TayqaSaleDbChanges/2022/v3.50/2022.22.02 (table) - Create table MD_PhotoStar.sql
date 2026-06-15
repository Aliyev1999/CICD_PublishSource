

CREATE TABLE MD_PhotoStar(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceId] [int] NOT NULL,
	[SourceType] [tinyint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[StarCount] [tinyint] NOT NULL,
 CONSTRAINT [PK_MD_PhotoStar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
),
 CONSTRAINT [UQ_ReferenceId_SourceType] UNIQUE NONCLUSTERED 
(
	[ReferenceId] ASC,
	[SourceType] ASC
))
GO

ALTER TABLE [dbo].[MD_PhotoStar] ADD  DEFAULT ((0)) FOR [StarCount]
GO


