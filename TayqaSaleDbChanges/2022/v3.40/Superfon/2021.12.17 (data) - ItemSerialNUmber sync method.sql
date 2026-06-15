DECLARE @ipAndPort NVARCHAR(40) = (SELECT TOP 1 SUBSTRING(Url, 0, CHARINDEX('', Url, 10))
FROM SYS_DataExchangeMethod
WHERE Name = 'SyncClient')

DECLARE @environment NVARCHAR(20) = (SELECT TOP 1 SUBSTRING(Url, CHARINDEX('', Url, 10) + 1, CHARINDEX('', Url, CHARINDEX('', Url, 10) + 1) - CHARINDEX('', Url, 10) - 1)
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
insert into SYS_DataExchangeMethod(Id, Name, Source, Description, ExtraInfo, Url, DataTypeId, Status, CreatedUserId, CreatedDate)
values(87,'RefreshItemSerialNumber', 'ItemSerialNumber', 'Refresh Item Serial Number', 'POST', @ipAndPort + '' + @environment + N'v3.40DataExchangeRefreshItemSerialNumber',2,1,1,getdate())

INSERT INTO dbo.OP_DataExchangeStatus (LastSyncAt, MethodId, Note, RegisteredAt, RegisteredUserId, ResponseStatus, Firm)
VALUES (getdate(), 87, N'', getdate(), 2, N'Ok', @firm);

INSERT INTO dbo.OP_DataExchangeSchedule (Id, DataExchangeMethodId, Parameters, Period, Status, Note, NextSyncTime, LastExecutionTime, ExtraNote)
VALUES (@maxSyncScheduleId + 1, 87, N'{Firms[{Nr' + Cast(@firm as nvarchar(20)) + N', ActivePeriod ' + Cast(@period as nvarchar(20)) + N'}]}',
 86400, 1, N'OK', getdate(), getdate(), N'');


