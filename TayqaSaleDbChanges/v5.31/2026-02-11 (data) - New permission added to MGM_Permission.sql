DELETE FROM MGM_Permission WHERE ObjectName = 'PhotoGallery.PhotoFeedback.CreateTask';

DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.GeneralData.Name2';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.GeneralData.TradingGroupCode';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.GeneralData.AuthCodeAndDesc';

DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.GeneralData';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.ContactData';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.FinanceData';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.RiskData';
DELETE FROM MGM_Permission WHERE ObjectName = 'ClientInfo.MediaData';

DELETE FROM MGM_Permission WHERE ObjectName = 'Client.ClientInfo';

DELETE FROM MGM_Permission WHERE ObjectName = 'Client.Blocking.BlockUnblock';
DELETE FROM MGM_Permission WHERE ObjectName = 'Client.Blocking';

DELETE FROM MGM_Permission WHERE ObjectName = 'Client.ClientReports.ClientExtract';
DELETE FROM MGM_Permission WHERE ObjectName = 'Client.ClientReports.ItemSale';
DELETE FROM MGM_Permission WHERE ObjectName = 'Client.ClientReports.SpecialReports';

DELETE FROM MGM_Permission WHERE ObjectName = 'Client.ClientReports';

DELETE FROM MGM_Permission WHERE ObjectName = 'Client';

DELETE FROM MGM_Permission WHERE ObjectName = 'Report.StandardReports.ClientVisit';

DELETE FROM MGM_Permission WHERE ObjectName = 'MainScreen.Menu.Confirmation.MGMInventoryRepairRequest.ConfirmOrReject';
DELETE FROM MGM_Permission WHERE ObjectName = 'MainScreen.Menu.Confirmation.MGMInventoryClientTransfer.ConfirmOrReject';


GO



DECLARE @parentId INT = (SELECT Id
                         FROM MGM_Permission
                         WHERE ObjectName = 'PhotoGallery.PhotoFeedback');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@parentId, 'PhotoGallery.PhotoFeedback.CreateTask', N'', 2, GETDATE());

GO

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (null, 'Client', N'Müştəri', 2, GETDATE());

GO

DECLARE @clientId INT = (SELECT Id
                         FROM MGM_Permission
                         WHERE ObjectName = 'Client');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@clientId, 'Client.ClientInfo', N'Müştəri məlumatları', 2, GETDATE());

GO

DECLARE @clientInfoId INT = (SELECT Id
                             FROM MGM_Permission
                             WHERE ObjectName = 'Client.ClientInfo');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@clientInfoId, 'ClientInfo.GeneralData', N'Ümumi məlumatlar', 2, GETDATE()),
       (@clientInfoId, 'ClientInfo.ContactData', N'Əlaqə məlumatları', 2, GETDATE()),
       (@clientInfoId, 'ClientInfo.FinanceData', N'Maliyyə məlumatları', 2, GETDATE()),
       (@clientInfoId, 'ClientInfo.RiskData', N'Risk məlumatları', 2, GETDATE()),
       (@clientInfoId, 'ClientInfo.MediaData', N'Media məlumatları', 2, GETDATE());

GO

DECLARE @generalDataId INT = (SELECT Id
                              FROM MGM_Permission
                              WHERE ObjectName = 'ClientInfo.GeneralData');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@generalDataId, 'ClientInfo.GeneralData.Name2', N'Alternativ ad', 2, GETDATE()),
       (@generalDataId, 'ClientInfo.GeneralData.TradingGroupCode', N'Ticarət qrupu kodu', 2, GETDATE()),
       (@generalDataId, 'ClientInfo.GeneralData.AuthCodeAndDesc', N'Avtorizasiya kodu və təsviri', 2, GETDATE());

GO

DECLARE @clientId INT = (SELECT Id
                         FROM MGM_Permission
                         WHERE ObjectName = 'Client');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@clientId, 'Client.Blocking', N'Bloklama ekrani', 2, GETDATE());

GO

DECLARE @blockingId INT = (SELECT Id
                           FROM MGM_Permission
                           WHERE ObjectName = 'Client.Blocking');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@blockingId, 'Client.Blocking.BlockUnblock', N'Bloklama ekrani emeliyyatlari', 2, GETDATE());

GO

DECLARE @clientId INT = (SELECT Id
                         FROM MGM_Permission
                         WHERE ObjectName = 'Client');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@clientId, 'Client.ClientReports', N'Müştəri hesabatları', 2, GETDATE());

GO

DECLARE @clientReportsId INT = (SELECT Id
                                FROM MGM_Permission
                                WHERE ObjectName = 'Client.ClientReports');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@clientReportsId, 'Client.ClientReports.ClientExtract', N'Cari Çıxarışı', 2, GETDATE()),
       (@clientReportsId, 'Client.ClientReports.ItemSale', N'Məhsul Satışı', 2, GETDATE()),
       (@clientReportsId, 'Client.ClientReports.SpecialReports', N'Xüsusi Hesabatlar', 2, GETDATE());

GO

DECLARE @standardReportsId INT = (SELECT Id
                                  FROM MGM_Permission
                                  WHERE ObjectName = 'Report.StandardReports');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@standardReportsId, 'Report.StandardReports.ClientVisit', N'Müştəri ziyarəti', 2, GETDATE());

GO

DECLARE @MGMInventoryRepairRequestId INT = (SELECT Id
                                            FROM MGM_Permission
                                            WHERE ObjectName = 'MainScreen.Menu.Confirmation.MGMInventoryRepairRequest');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@MGMInventoryRepairRequestId, 'MainScreen.Menu.Confirmation.MGMInventoryRepairRequest.ConfirmOrReject',
        N'Təsdiq/İmtina et', 2, GETDATE());

GO

DECLARE @MGMInventoryClientTransferId INT = (SELECT Id
                                            FROM MGM_Permission
                                            WHERE ObjectName = 'MainScreen.Menu.Confirmation.MGMInventoryClientTransfer');

INSERT INTO MGM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate)
VALUES (@MGMInventoryClientTransferId, 'MainScreen.Menu.Confirmation.MGMInventoryClientTransfer.ConfirmOrReject',
        N'Təsdiq/İmtina et', 2, GETDATE());










