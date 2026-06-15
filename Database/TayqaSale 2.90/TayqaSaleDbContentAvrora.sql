Declare @firm smallint = 100;
DECLARE @IP NVARCHAR(500) = 'http://192.168.10.25:1401/prod/v2.10/TigerAvrora'

INSERT [dbo].[OP_DataExchangeStatus] ([LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (GetDate(), 201, N'', GetDate(), 2, 1, N'Ok', @firm)
GO
INSERT [dbo].[OP_DataExchangeStatus] ([LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (GetDate(), 202, N'', GetDate(), 2, 1, N'Ok', @firm)
GO
INSERT [dbo].[OP_DataExchangeStatus] ([LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (GetDate(), 37, N'RefreshClientGroupDataForWarehouse', GetDate(), 2, 1, N'OK', @firm)
GO



INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (201, N'RefreshClientWarehouseRestriction', N'ClientWarehouseRestriction', N'Refresh Client Warehouse Restriction', N'POST', @IP+ 'RefreshClientWarehouseRestriction', 1, 1, NULL, NULL, 1, GetDate())
GO
INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (202, N'RefreshNoVatCalculation', N'NoVatCalculation', N'Refresh No Vat Calculation data', N'POST', @IP + 'RefreshNoVatCalculation', 1, 1, NULL, NULL, 1, GetDate())
GO