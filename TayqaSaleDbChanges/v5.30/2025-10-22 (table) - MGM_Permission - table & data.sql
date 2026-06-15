create table MGM_Permission
(
    Id            smallint identity
        constraint PK__MGM_Perm__3214EC07B992915A
            primary key,
    ParentId      smallint,
    ObjectName    nvarchar(250)                                     not null
        constraint UQ_Mgm_Permission_ObjectName
            unique,
    Description   nvarchar(500),
    CreatedUserId bigint                                            not null,
    CreatedDate   datetime
        constraint DF__MGM_Permi__Creat__0D1A419D default getdate() not null
)
go

SET IDENTITY_INSERT MGM_Permission ON;
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (1, null, N'MainScreen', N'Esas sehife', 2, N'2025-10-15 15:09:43.930');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (2, 1, N'MainScreen.Pending', N'Esas sehifede gozleyen hissesi', 2, N'2025-10-15 15:09:43.950');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (3, 1, N'MainScreen.Notification', N'Esas sehifede bildiris hissesi', 2, N'2025-10-15 15:09:43.950');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (4, 1, N'MainScreen.Menu', N'Kecidler hissesi', 2, N'2025-10-15 15:09:43.950');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (5, 4, N'MainScreen.Menu.Confirmation', N'Tesdiq ekrani', 2, N'2025-10-15 15:09:43.973');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (6, 5, N'MainScreen.Menu.Confirmation.MGMRiskLimitRequest', N'Risk limit ekrani', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (7, 5, N'MainScreen.Menu.Confirmation.OperationApproval', N'Emeliyyat tesdiq', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (8, 5, N'MainScreen.Menu.Confirmation.RouteRequests', N'Rut sorgulari', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (9, 5, N'MainScreen.Menu.Confirmation.MGMInventoryRequest', N'Inventar telebleri', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (10, 5, N'MainScreen.Menu.Confirmation.MGMInventoryRepairRequest', N'Inventar temiri', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (11, 5, N'MainScreen.Menu.Confirmation.MGMInventoryClientTransfer', N'Inventar yerdeyisme', 2, N'2025-10-15 15:09:43.990');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (12, null, N'Tracking', N'Izleme. tek buna yetki vermek yeterli deyil, altdakilardan biri de olmalidir.', 2, N'2025-10-15 15:09:44.000');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (13, 12, N'Tracking.Summary', N'Izlemenin xulase modu', 2, N'2025-10-15 15:09:44.010');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (14, 12, N'Tracking.Map', N'Izlemenin xerite modu', 2, N'2025-10-15 15:09:44.010');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (15, null, N'PhotoGallery', N'Qalereya', 2, N'2025-10-15 15:09:44.020');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (16, 15, N'PhotoGallery.PhotoFeedback', N'Rey funksionalligi', 2, N'2025-10-15 15:09:44.030');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (17, 16, N'PhotoGallery.PhotoFeedback.LikeDislike', N'Like dislike etmek', 2, N'2025-10-15 15:09:44.040');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (18, 16, N'PhotoGallery.PhotoFeedback.Comment', N'Comment yazmaq', 2, N'2025-10-15 15:09:44.040');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (19, 16, N'PhotoGallery.PhotoFeedback.History', N'Tarixce, hem asagidan cekilen, hem de melumat olaraq kecid etdiyimiz', 2, N'2025-10-15 15:09:44.040');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (20, null, N'Report', N'Hesabatlar, tek buna yetki vermek yeterli deyil, standard ve ya specialreport da olmalidir', 2, N'2025-10-15 15:09:44.043');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (21, 20, N'Report.StandardReports', N'Standard hesabatlar, tek buna yetki vermek de yeterli deyil, asagidakilardan biri de olmalidir', 2, N'2025-10-15 15:09:44.057');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (22, 21, N'Report.StandardReports.ClientDebt', N'Musteri borclari', 2, N'2025-10-15 15:09:44.063');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (23, 21, N'Report.StandardReports.MGMCashAccountBalance', N'Kassa qaliqlari', 2, N'2025-10-15 15:09:44.063');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (24, 21, N'Report.StandardReports.RouteStatistics', N'Rut statatistikasi', 2, N'2025-10-15 15:09:44.063');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (25, null, N'SpecialReports', N'Xususi hesabatlar', 2, N'2025-10-15 15:09:44.070');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (28, 9, N'MainScreen.Menu.Confirmation.MGMInventoryRequest.ConfirmOrReject', N'Inventar tələblərini təsdiq və ya imtina etmə', 2, N'2025-11-24 17:00:20.843');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (29, 1, N'MainScreen.Menu.Tasks', N'Tesdiq ekrani', 2, N'2025-10-15 15:09:43.973');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (30, null, N'Tasks', N'Tapşırıqlar ekranı', 2, N'2025-12-03 12:24:59.133');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (31, 30, N'Tasks.ConfirmReject', N'Tapşırıqlar ekranı', 2, N'2025-12-03 12:25:25.927');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (32, 4, N'MainScreen.Menu.SpecialScreens', N'Xususi ekranlarin gorunmesi ucun permission', 2, N'2025-12-11 11:28:40.567');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (33, 30, N'Tasks.Create', N'Tapşırıq yaratmaq', 2, N'2025-12-16 14:47:20.527');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (34, 33, N'Tasks.Create.OnlineUserList', N'', 2, N'2025-12-22 12:36:50.530');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (37, 33, N'Tasks.Create.AdditionalData', N'', 2, N'2025-12-22 12:37:59.100');
INSERT INTO MGM_Permission (Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate) VALUES (39, 4, N'MainScreen.Menu.Clients', N'', 2, N'2025-12-24 11:48:38.220');
SET IDENTITY_INSERT MGM_Permission OFF;