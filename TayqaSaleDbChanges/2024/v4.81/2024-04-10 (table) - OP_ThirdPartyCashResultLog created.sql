IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyCashResultLog]') AND type in (N'U'))

BEGIN


CREATE TABLE [dbo].[OP_ThirdPartyCashResultLog](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_OP_ThirdPartyCashResultLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

END