DROP TABLE IF EXISTS WMM_RolePermission

GO

DROP TABLE IF EXISTS WMM_Permission

GO

CREATE TABLE WMM_Permission
(
    Id            int                                               not null
        constraint PK_WMM_Permission
            primary key,
    ParentId      int
        constraint FK_WMM_Permission_Id_ParentId
            references WMM_Permission,
    Name          nvarchar(100)                                     not null,
    Description   nvarchar(500),
    CreationTime  datetime
        constraint DF_WMM_Permission_CreationTime default getdate() not null,
    CreatorUserId bigint
)
go

CREATE UNIQUE INDEX IX_WMM_Permission_Name
    ON WMM_Permission (Name)

GO

CREATE TABLE WMM_RolePermission
(
    Id            int identity
        constraint PK_WMM_RolePermission
            primary key,
    RoleId        int                                                   not null
        constraint FK_WMM_RolePermission_WMM_Role_Id
            references WMM_Role,
    PermissionId  int                                                   not null
        constraint FK_WMM_RolePermission_WMM_Permission_Id
            references WMM_Permission,
    CreationTime  datetime
        constraint DF_WMM_RolePermission_CreationTime default getdate() not null,
    CreatorUserId bigint
)

GO

INSERT INTO WMM_Permission (Id, ParentId, Name, Description, CreationTime, CreatorUserId)
VALUES (1, NULL, 'SingleProject', 'SingleProject', '2025-08-16 18:23:11.760', 2),
       (2, 1, 'SingleProject.Panel', 'SingleProject.Panel', '2025-08-16 18:23:54.380', 2),
       (3, 1, 'SingleProject.Tasks', 'SingleProject.Tasks', '2025-08-16 18:24:23.177', 2),
       (4, 3, 'SingleProject.Tasks.Create', 'SingleProject.Tasks.Create', '2025-08-16 18:24:47.003', 2),
       (5, 3, 'SingleProject.Tasks.Action', 'SingleProject.Tasks.Action', '2025-08-16 18:24:58.927', 2),
       (6, 5, 'SingleProject.Tasks.Action.MoveStatusForward', 'SingleProject.Tasks.Action.MoveStatusForward',
        '2025-08-16 18:25:23.510', 2),
       (7, 5, 'SingleProject.Tasks.Action.MoveStatusBackward', 'SingleProject.Tasks.Action.MoveStatusBackward',
        '2025-08-16 18:25:34.060', 2),
       (8, 5, 'SingleProject.Tasks.Action.AddActivity', 'SingleProject.Tasks.Action.AddActivity',
        '2025-08-16 18:25:48.263', 2),
       (9, 5, 'SingleProject.Tasks.Action.Watch', 'SingleProject.Tasks.Action.Watch', '2025-08-16 18:26:07.443', 2),
       (10, 5, 'SingleProject.Tasks.Action.AddComment', 'SingleProject.Tasks.Action.AddComment',
        '2025-08-16 18:26:16.973', 2),
       (11, 3, 'SingleProject.Tasks.Info', 'SingleProject.Tasks.Info', '2025-08-16 18:26:41.180', 2),
       (12, 11, 'SingleProject.Tasks.Info.Client', 'SingleProject.Tasks.Info.Client', '2025-08-16 18:27:21.273', 2),
       (13, 11, 'SingleProject.Tasks.Info.Source', 'SingleProject.Tasks.Info.Source', '2025-08-16 18:27:31.220', 2),
       (15, 11, 'SingleProject.Tasks.Info.Comments', 'SingleProject.Tasks.Info.Comments', '2025-08-16 18:27:53.117',
        2),
       (16, 11, 'SingleProject.Tasks.Info.Activities', 'SingleProject.Tasks.Info.Activities', '2025-08-16 18:28:09.230',
        2),
       (17, 11, 'SingleProject.Tasks.Info.Files', 'SingleProject.Tasks.Info.Files', '2025-08-16 18:28:22.080', 2),
       (18, 11, 'SingleProject.Tasks.Info.History', 'SingleProject.Tasks.Info.History', '2025-08-16 18:28:29.000',
        2),
       (19, 3, 'SingleProject.Tasks.Edit', 'SingleProject.Tasks.Edit', '2025-08-16 18:28:52.877', 2),
       (20, 19, 'SingleProject.Tasks.Edit.Name', 'SingleProject.Tasks.Edit.Name', '2025-08-16 18:29:00.880', 2),
       (21, 19, 'SingleProject.Tasks.Edit.Description', 'SingleProject.Tasks.Edit.Description',
        '2025-08-16 18:29:11.587', 2),
       (22, 19, 'SingleProject.Tasks.Edit.ContextValues', 'SingleProject.Tasks.Edit.ContextValues',
        '2025-08-16 18:29:20.220', 2),
       (23, 19, 'SingleProject.Tasks.Edit.Assignee', 'SingleProject.Tasks.Edit.Assignee', '2025-08-16 18:29:28.387',
        2),
       (24, 5, 'SingleProject.Tasks.Action.Delete', 'SingleProject.Tasks.Delete', '2025-08-16 18:29:40.010', 2),
       (25, 1, 'SingleProject.Pending', 'SingleProject.Pending', '2025-08-16 18:29:56.770', 2),
       (26, 25, 'SingleProject.Pending.Details', 'SingleProject.Pending.Details', '2025-08-16 18:30:05.167', 2),
       (27, 25, 'SingleProject.Pending.AcceptReject', 'SingleProject.Pending.AcceptReject', '2025-08-16 18:30:15.330',
        2),
       (28, 5, 'SingleProject.Tasks.Action.UploadFile', 'SingleProject.Tasks.Action.UploadFile',
        '2025-08-16 18:30:43.193', 2),
       (29, 1, 'SingleProject.Files', 'SingleProject.Files', '2025-08-16 18:31:00.287', 2),
       (30, 29, 'SingleProject.Files.Upload', 'SingleProject.Files.Upload', '2025-08-16 18:31:08.233', 2),
       (31, 29, 'SingleProject.Files.Delete', 'SingleProject.Files.Delete', '2025-08-16 18:31:17.830', 2),
       (32, 5, 'SingleProject.Tasks.Action.ForwardToAnotherProject', 'SingleProject.Tasks.Delete',
        '2025-08-16 18:29:40.010', 2),
       (33, 3, 'SingleProject.Tasks.Delete', 'SingleProject.Tasks.Delete', '2025-08-16 18:24:47.003', 2),
       (34, 11, 'SingleProject.Tasks.Info.SubTasks', 'SingleProject.Tasks.Subtasks', '2025-08-24 10:50:35.270', 2),
       (35, 34, 'SingleProject.Tasks.Info.SubTasks.Create', 'SingleProject.Tasks.Subtasks.Create',
        '2025-08-24 10:50:56.570', 2),
       (36, 1, 'SingleProject.Kanban', 'SingleProject.Kanban', '2025-08-31 12:47:14.490', 2),
       (37, 5, 'SingleProject.Tasks.Action.EditComment', 'SingleProject.Tasks.Action.EditComment',
        '2025-09-23 16:51:57.690', 2),
       (38, 5, 'SingleProject.Tasks.Action.DeleteComment', 'SingleProject.Tasks.Action.DeleteComment',
        '2025-09-23 16:52:20.543', 2);