IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyCommonLineResultLog]') AND type in (N'U'))

BEGIN


CREATE TABLE [dbo].[OP_ThirdPartyCommonLineResultLog](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[IsPromo] [bit] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_OP_ThirdPartyCommonLineResultLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ItemId] ASC,
	[IsPromo] ASC
))

END

