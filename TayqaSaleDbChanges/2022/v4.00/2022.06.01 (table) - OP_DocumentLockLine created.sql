CREATE TABLE [dbo].[OP_DocumentLockLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentLockId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[IsPromo] [bit] NOT NULL,
 CONSTRAINT [PK_OP_DocumentLockLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


