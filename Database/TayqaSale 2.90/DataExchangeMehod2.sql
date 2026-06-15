Declare @name nvarchar(50) = 'Avrora';

USE TayqaMobileApp

Declare @firm smallint, 
		@firmNr nvarchar(10), 
		@activePeriod nvarchar(10);
IF @name = 'Veyseloglu'
	begin
		SET @firm = 150;
		SET @firmNr = '150';
		SET @activePeriod = '1';
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1401/core/v2.91/TigerCore/','http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/V2.10/TigerVeyseloglu/')
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1150/tayqa/tiger/api/core/v2.9.1/uid/','http://VOTAYQAWEB02.veyseloglu.az:1102/tayqa/tiger/api/veyseloglu/v2.91/uid/')
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:11101/core/Integration/','http://VOTAYQAWIN03.veyseloglu.az:11101/veyseloglu/Integration/')
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (44,'RefreshClientGroupDataforItemSuggestedPrice', 'ClientGroupDataforItemSuggestedPrice', 'Refresh Client Group Data for Item Suggested Price', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/RefreshClientGroupDataforItemSuggestedPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (43,'SyncClientGroupDataforItemSuggestedPrice', 'ClientGroupDataforItemSuggestedPrice', 'Sync Client Group Data for Item Suggested Price', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/SyncClientGroupDataforItemSuggestedPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (40,'RefreshClientGroupDataforItemSpecificPrice', 'ClientGroupDataforItemSpecificPrice', 'Refresh Client Group Data for Item Specific Price', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/RefreshClientGroupDataforItemSpecificPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (39,'SyncClientGroupDataforItemSpecificPrice', 'ClientGroupDataforItemSpecificPrice', 'Sync Client Group Data for Item Specific Price', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/SyncClientGroupDataforItemSpecificPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (30,'RefreshItemSpecificPriceforClientGroup', 'ItemSpecificPriceforClientGroup', 'Refresh Item Specific Price for Client Group', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/RefreshItemSpecificPriceforClientGroup', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (48,'SyncItemSpecificPriceforClientGroup', 'ItemSpecificPriceforClientGroup', 'Sync Item Specific Price for Client Group', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/SyncItemSpecificPriceforClientGroup', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (45,'RefreshItemSuggestedPriceforClientGroup', 'ItemSuggestedPriceforClientGroup', 'Refresh Item Suggested Price for Client Group', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/RefreshItemSuggestedPriceforClientGroup', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (29,'RefreshItemSpecificPriceforClient', 'ItemSpecificPriceforClient', 'Refresh Item Specific Price for Client', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/RefreshItemSuggestedPriceforClient', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (47,'SyncItemSpecificPriceforClient', 'ItemSpecificPriceforClient', 'Sync Item Specific Price for Client', 'POST', 'http://VOTAYQAWEB02.veyseloglu.az:1110/veyseloglu/v2.10/TigerVeyseloglu/SyncItemSpecificPriceforClient', 1, 1, NULL, NULL, 1, GETDATE())
	
	
	END
ELSE IF @name = 'Avrora'
	BEGIN
		SET @firm = 2;
		SET @firmNr = '2';
		SET @activePeriod = '1';
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1401/core/v2.91/TigerCore/','http://192.168.10.65:1101/prod/V2.10/TigerAvrora/')
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1150/tayqa/tiger/api/core/v2.9.1/uid/','http://192.168.10.65:400/tayqa/tiger/api/prod/v2.91/uid/')
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:11101/core/Integration/','http://192.168.10.64:11101/avrora/Integration/')
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (37,'RefreshClientGroupDataForWarehouse', 'ClientGroupDataForWarehouse', 'Refresh Client GroupData For Warehouse', 'POST', 'http://192.168.10.65:1101/prod/V2.10/TigerAvrora/RefreshClientGroupDataForWarehouse', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (201,'RefreshClientWarehouseRestriction', 'ClientWarehouseRestriction', 'Refresh Client Warehouse Restriction', 'POST', 'http://192.168.10.65:1101/prod/V2.10/TigerAvrora/RefreshClientWarehouseRestriction', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (202,'RefreshNoVatCalculation', 'NoVatCalculation', 'Refresh No Vat Calculation data', 'POST', 'http://192.168.10.65:1101/prod/V2.10/TigerAvrora/RefreshNoVatCalculation', 1, 1, NULL, NULL, 1, GETDATE())
	END
ELSE IF @name = 'Aquavita'
	BEGIN
		SET @firm = 1;
		SET @firmNr = '1';
		SET @activePeriod = '1';
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1401/core/v2.91/TigerCore/','http://192.168.101.120:1107/aquavita/V2.10/Aquavita/')
		UPDATE SYS_DataExchangeMethod SET Url = REPLACE(Url,'http://10.91.10.24:1150/tayqa/tiger/api/core/v2.9.1/uid/','http://192.168.101.120:1102/tayqa/tiger/api/aquavita/v2.91/uid/')
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (29,'RefreshAllMasterDataForAquavita', 'AllMasterDataForAquavita', 'Refresh All Master Data For Aquavita', 'POST', 'http://192.168.101.120:1107/aquavita/V2.10/Aquavita/RefreshAllMasterDataForAquavita', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (30,'RefreshItemSpecificGroupPrice', 'ItemSpecificGroupPrice', 'Refresh Item Specific Group Price', 'POST', 'http://192.168.101.120:1107/aquavita/V2.10/Aquavita/RefreshItemSpecificGroupPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (69,'RefreshItemSpecificPrice', 'ItemSpecificPrice', 'Refresh Item Specific Price', 'POST', 'http://192.168.101.120:1107/aquavita/V2.10/Aquavita/RefreshItemSpecificPrice', 1, 1, NULL, NULL, 1, GETDATE())
		INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (40,'RefreshClientGroupDataforItemSpecificPrice', 'ClientGroupDataforItemSpecificPrice', 'Refresh Client Group Data for Item Specific Price', 'POST', 'http://192.168.101.120:1107/aquavita/V2.10/Aquavita/RefreshClientGroupDataforItemSpecificPrice', 1, 1, NULL, NULL, 1, GETDATE())

	END
IF @name = 'Veyseloglu'
	BEGIN
--INSERT INTO OP_DataExchangeStatus
		UPDATE OP_DataExchangeStatus SET Firm = @firm
		INSERT INTO OP_DataExchangeStatus (LastSyncAt,MethodId,Note,RegisteredAt,RegisteredUserId,Status,ResponseStatus,Firm)
		SELECT GETDATE(),M.Id,'',GETDATE(),606,1,'',@firm
		FROM SYS_DataExchangeMethod M
		where M.Id not in (select MethodId from OP_DataExchangeStatus)
--INSERT INTO [OP_DataExchangeSchedule]
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms": [9]}','{"Firms": ['+ @firmNr +']}')
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms":[{"Nr":9, "ActivePeriod":5}]}','{"Firms":[{"Nr":'+ @firmNr +', "ActivePeriod":'+ @activePeriod +'}]}')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (37,	36, '{"Firms":[{"Nr":'+ @firmNr +', "ActivePeriod":'+ @activePeriod +'}]}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (38,	40, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (39,	30, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (40,	44, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (41,	45, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (42,	28, '{"Firms":[{"Nr":'+ @firmNr +', "ActivePeriod":'+ @activePeriod +'}]}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (43,	26, '{"Firms": ['+ @firmNr +']}', NULL, 7200, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (44,	27, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (45,	39, '{"Firms": ['+ @firmNr +']}', NULL, 1800, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (46,	43, '{"Firms": ['+ @firmNr +']}', NULL, 1800, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (47,	39, '{"Firms": ['+ @firmNr +']}', NULL, 1800, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (48,	48, '{"Firms": ['+ @firmNr +']}', NULL, 900, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (49,	47, '{"Firms": ['+ @firmNr +']}', NULL, 900, 1, '' , GETDATE(), '', '')
		INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (50,	29, '{"Firms": ['+ @firmNr +']}', NULL, 86400, 1, '' , GETDATE(), '', '')
	END
ELSE IF @name = 'Avrora'
	BEGIN
	--INSERT INTO OP_DataExchangeStatus
		UPDATE OP_DataExchangeStatus SET Firm = @firm
		INSERT INTO OP_DataExchangeStatus (LastSyncAt,MethodId,Note,RegisteredAt,RegisteredUserId,Status,ResponseStatus,Firm)
		SELECT GETDATE(),M.Id,'',GETDATE(),606,1,'',@firm
		FROM SYS_DataExchangeMethod M
		where M.Id not in (select MethodId from OP_DataExchangeStatus)
--INSERT INTO [OP_DataExchangeSchedule]
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms": [9]}','{"Firms": ['+ @firmNr +']}')
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms":[{"Nr":9, "ActivePeriod":5}]}','{"Firms":[{"Nr":'+ @firmNr +', "ActivePeriod":'+ @activePeriod +'}]}')
	END
ELSE IF @name = 'Aquavita'
	BEGIN
	--INSERT INTO OP_DataExchangeStatus
		UPDATE OP_DataExchangeStatus SET Firm = @firm
		INSERT INTO OP_DataExchangeStatus (LastSyncAt,MethodId,Note,RegisteredAt,RegisteredUserId,Status,ResponseStatus,Firm)
		SELECT GETDATE(),M.Id,'',GETDATE(),606,1,'',@firm
		FROM SYS_DataExchangeMethod M
		where M.Id not in (select MethodId from OP_DataExchangeStatus)
--INSERT INTO [OP_DataExchangeSchedule]
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms": [9]}','{"Firms": ['+ @firmNr +']}')
		UPDATE [OP_DataExchangeSchedule] SET Parameters = REPLACE(Parameters,'{"Firms":[{"Nr":9, "ActivePeriod":5}]}','{"Firms":[{"Nr":'+ @firmNr +', "ActivePeriod":'+ @activePeriod +'}]}')
END