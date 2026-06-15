-- Add a new column '[Note]' to table '[MD_BannedClient]' in schema '[dbo]'
ALTER TABLE [dbo].[MD_BannedClient]
    ADD [Note] nvarchar(100)  NULL
GO