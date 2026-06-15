CREATE TABLE [dbo].[IM_TransferAttachment](
	[Id] [int] IDENTITY(1,1) PRIMARY key,
	[ReferenceId] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[SecureUrl]  AS (concat('NewImage-IM_TransferAttachment','-',[Id],reverse(left(reverse([Path]),charindex('\',reverse([Path])))))),
	[CreationTime] [datetime] NOT NULL DEFAULT (getdate())
)