CREATE TABLE [dbo].[OP_DocumentLock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[SalesmanId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[NetTotal] [float] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Note] [nvarchar](100) NULL,
	[CreationTime] [datetime] NULL,
	[CreatorUserId] [int] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [int] NULL,
 CONSTRAINT [PK_OP_DocumentLock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_DocId_DocumentLock] UNIQUE NONCLUSTERED 
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


