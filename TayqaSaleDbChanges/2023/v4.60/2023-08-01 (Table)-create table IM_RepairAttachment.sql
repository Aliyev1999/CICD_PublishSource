

CREATE TABLE [dbo].[IM_RepairAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceId] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[SecureUrl]  AS (concat('NewImage-IM_RepairAttachment','-',[Id],reverse(left(reverse([Path]),charindex('\',reverse([Path])))))),
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK__IM_Repai__3214EC07D8B1FA12] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

ALTER TABLE [dbo].[IM_RepairAttachment] ADD  CONSTRAINT [DF_IM_RepairAttachment_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


