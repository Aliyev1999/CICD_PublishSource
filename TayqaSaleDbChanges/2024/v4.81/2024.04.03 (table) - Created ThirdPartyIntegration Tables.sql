

IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogCommonLineSerialNumberExtension]') AND type in (N'U'))

BEGIN

CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogCommonLineSerialNumberExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[IsPromo] [bit] NULL,
	[SerialNumber] [nvarchar](255) NULL
) ON [PRIMARY]


END

GO