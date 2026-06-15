SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] ON
GO
INSERT INTO [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId],
                                            [CreatedUserId], [ModifiedDate], [CreatedDate])
VALUES (12, N'PendingDocsTimerSecond', N'Pending docs timer second', '30', 1, NULL, 2, NULL,
        GETDATE())
GO
GO
INSERT INTO [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId],
                                            [CreatedUserId], [ModifiedDate], [CreatedDate])
VALUES (13, N'PendingDocsTimerNote', N'Pending docs timer note', 'Pending docs timer note', 1, NULL, 2, NULL,
        GETDATE())
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] OFF
GO