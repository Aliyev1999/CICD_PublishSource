DECLARE @ipAndPort NVARCHAR(40) = (SELECT TOP 1 SUBSTRING(Url, 0, CHARINDEX('/', Url, 10))
FROM SYS_DataExchangeMethod
WHERE Name = 'SyncClient')

DECLARE @environment NVARCHAR(20) = (SELECT TOP 1 SUBSTRING(Url, CHARINDEX('/', Url, 10) + 1, CHARINDEX('/', Url, CHARINDEX('/', Url, 10) + 1) - CHARINDEX('/', Url, 10) - 1)
FROM SYS_DataExchangeMethod
WHERE Name = 'SyncClient')

DECLARE @firm SMALLINT = (SELECT TOP 1 Nr
FROM MD_Firm
WHERE IsActive = 1);

DECLARE @period SMALLINT = (SELECT TOP 1 Period
FROM SYS_AccountingPeriod
WHERE  FirmNr = @firm
order by Year desc);

DECLARE @maxSyncMethodId SMALLINT = (SELECT max(Id)
FROM SYS_DataExchangeMethod);

DECLARE @maxSyncScheduleId INT =(SELECT max(Id)
FROM OP_DataExchangeSchedule)

--1
INSERT INTO dbo.SYS_DataExchangeMethod (Id, Name, Source, Description, ExtraInfo, Url, DataTypeId, Status, CreatedUserId, CreatedDate)
VALUES (@maxSyncMethodId + 1, N'RefreshClientSalesmanDebt', N'ClientSalesmanDebt', N'Refresh Client Salesman Debt', N'POST',
        @ipAndPort + '/' + @environment + N'/v3.10/DataExchange/RefreshClientSalesmanDebt', 2, 1, 2, getdate());

INSERT INTO dbo.OP_DataExchangeStatus (LastSyncAt, MethodId, Note, RegisteredAt, RegisteredUserId, ResponseStatus, Firm)
VALUES (getdate(), @maxSyncMethodId + 1, N'', getdate(), 2, N'Ok', @firm);

INSERT INTO dbo.OP_DataExchangeSchedule (Id, DataExchangeMethodId, Parameters, Period, Status, Note, NextSyncTime, LastExecutionTime, ExtraNote)
VALUES (@maxSyncScheduleId + 1, @maxSyncMethodId + 1, N'{"Firms":[{"Nr":' + Cast(@firm as nvarchar(20)) + N', "ActivePeriod": ' + Cast(@period as nvarchar(20)) + N'}]}',
 84600, 1, N'OK', getdate(), getdate(), N'');

--2
INSERT INTO dbo.SYS_DataExchangeMethod (Id, Name, Source, Description, ExtraInfo, Url, DataTypeId, Status, CreatedUserId, CreatedDate)
VALUES (@maxSyncMethodId + 2, N'SyncClientSalesmanFinance', N'ClientSalesmanFinance', N'Sync Client Salesman Finance', N'POST',
        @ipAndPort + '/' + @environment + N'/v3.10/DataExchange/SyncClientSalesmanFinance', 2, 1, 2, getdate());

INSERT INTO dbo.OP_DataExchangeStatus (LastSyncAt, MethodId, Note, RegisteredAt, RegisteredUserId, ResponseStatus, Firm)
VALUES (getdate(), @maxSyncMethodId + 2, N'', getdate(), 2, N'Ok', @firm);

INSERT INTO dbo.OP_DataExchangeSchedule (Id, DataExchangeMethodId, Parameters, Period, Status, Note, NextSyncTime, LastExecutionTime, ExtraNote)
VALUES (@maxSyncScheduleId + 2, @maxSyncMethodId + 2, N'{"Firms":[{"Nr":' + Cast(@firm as nvarchar(20)) + N', "ActivePeriod": ' + Cast(@period as nvarchar(20)) + N'}]}',
 300, 1, N'OK', getdate(), getdate(), N'');

--3
INSERT INTO dbo.SYS_DataExchangeMethod (Id, Name, Source, Description, ExtraInfo, Url, DataTypeId, Status, CreatedUserId, CreatedDate)
VALUES (@maxSyncMethodId + 3, N'RefreshClientSalesmanFinance', N'ClientSalesmanFinance', N'Refresh Client Salesman Finance', N'POST',
        @ipAndPort + '/' + @environment + N'/v3.10/DataExchange/RefreshClientSalesmanFinance', 2, 1, 1, getdate());

INSERT INTO dbo.OP_DataExchangeStatus (LastSyncAt, MethodId, Note, RegisteredAt, RegisteredUserId, ResponseStatus, Firm)
VALUES (getdate(), @maxSyncMethodId + 3, N'', getdate(), 2, N'Ok', @firm);

INSERT INTO dbo.OP_DataExchangeSchedule (Id, DataExchangeMethodId, Parameters, Period, Status, Note, NextSyncTime, LastExecutionTime, ExtraNote)
VALUES (@maxSyncScheduleId + 3, @maxSyncMethodId + 3, N'{"Firms":[{"Nr":' + Cast(@firm as nvarchar(20)) + N', "ActivePeriod": ' + Cast(@period as nvarchar(20)) + N'}]}',
 84600, 1, N'OK', getdate(), getdate(), N'');