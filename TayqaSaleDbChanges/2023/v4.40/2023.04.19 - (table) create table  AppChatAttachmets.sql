CREATE TABLE AppChatAttachmets(
    [Id] [bigint] IDENTITY(1,1),
    [ReferenceId] [bigint] not null,
    [Url] nvarchar(300) not null ,
    [SecureUrl] as concat('NewImage-CHAT-Attachment', '-', [Id],
                           reverse(left(reverse([Url]), charindex('\', reverse([Url]))))) collate SQL_Latin1_General_CP1_CI_AS,
  CreationTime  datetime2(7) not null
  )