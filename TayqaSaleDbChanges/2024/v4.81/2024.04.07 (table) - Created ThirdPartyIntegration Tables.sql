

IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogCashExtension]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogCashExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CashCode] [varchar](50) NOT NULL,
	[TranGroupNo] [varchar](50) NULL,
	[MasterTitle] [varchar](100) NULL,
 CONSTRAINT [PK_OP_ThirdPartyIncomingLogCashExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]

END


GO