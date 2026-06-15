-- auto-generated definition
create table WMM_TaskRequest
(
    Id                 int identity
        constraint PK__WMM_TaskRequest_Id
            primary key,
    SourceType         tinyint,
    SourceId           int,
    ProjectId          int,
    Status             tinyint,
    ReasonId           int
        constraint FK_WMM_TaskRequest_ReasonId
            references MD_StopReason,
    Note               nvarchar(max),
    CreationTime       datetime2 default getdate() not null,
    CreatorUserId      bigint,
    FeedbackReasonId   int,
    FeedbackNote       nvarchar(255),
    FeedbackTime       datetime,
    FeedbackUserId     bigint,
    CancellationNote   nvarchar(255),
    CancellationTime   datetime,
    CancellationUserId bigint
)
go

-- auto-generated definition
create table WMM_TaskRequestFiles
(
    Id            int identity
        primary key,
    TaskRequestId int                         not null
        constraint FK__WMM_TaskR__TaskR__22F3A8CC
            references WMM_TaskRequest
            on delete cascade,
    Url           nvarchar(500)               not null,
    CreatedDate   datetime2 default getdate() not null,
    SecureUrl     as (concat('NewImage-WMM-TaskRequestFiles', '-', [Id],
                             reverse(left(reverse([Url]), charindex('\', reverse([Url])))))) collate SQL_Latin1_General_CP1_CI_AS
)
go

create table WMM_Task
(
    Id                   int identity
        constraint PK_WMM_Task_Id
            primary key,
    ProjectId            int                                        not null,
    TaskTypeId           int                                        not null,
    ClientId             int,
    Number               nvarchar(50),
    Name                 nvarchar(500)                              not null,
    Description          nvarchar(max),
    RelatedClientId      int,
    SourceType           tinyint,
    SourceId             bigint,
    AssignedUserId       bigint,
    Priority             tinyint
        constraint DF_WMM_Task_Priority default 3                   not null,
    DueDate              date,
    BeginDate            date,
    EndDate              date,
    StatusId             int,
    ParentId             int,
    CreatorUserId        bigint                                     not null,
    CreationTime         datetime
        constraint DF_WMM_TaskCreati_039AF904 default getdate() not null,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    DeleterUserId        bigint,
    DeletionTime         datetime,
    IsDeleted            bit
        constraint DF_WMM_TaskIsDele_048F1D3D default 0         not null,
    CompletionTime       datetime
        constraint DF_WMM_TaskComple_05834176 default getdate() not null,
    ReminderDate         datetime
        constraint DF_WMM_TaskRemind_067765AF default getdate() not null,
    IsActive             bit
        constraint DF_WMM_Task_IsActive default 1                   not null,
    TaskRequestId        int
)
go

exec sp_addextendedproperty 'MS_Description', 'NotSet = 0,
Highest = 1,
High = 2,
Medium = 3,
Low = 4,
Lowest = 5', 'SCHEMA', 'dbo', 'TABLE', 'WMM_Task', 'COLUMN', 'Priority'
go

create unique index IX_WMM_Task_Number
    on WMM_Task (Number)
go

-- auto-generated definition
create table WMM_Project
(
    Id                   int identity
        constraint PK_WMM_Project
            primary key,
    Firm                 smallint,
    Prefix               nvarchar(20)                            not null,
    Name                 nvarchar(100)                           not null,
    LeadUserId           bigint                                  not null,
    AccessType           tinyint                                 not null,
    Description          nvarchar(255),
    Modules              int                                     not null,
    CreationTime         datetime
        constraint DF_WMM_Project_CreationTime default getdate() not null,
    CreatorUserId        bigint                                  not null,
    LastModificationTime datetime,
    LastModifierUserId   bigint,
    IsActive             bit
        constraint DF_WMM_Project_IsActive default 1             not null,
    IsDeleted            bit
        constraint DF_WMM_Project_IsDeleted default 0            not null,
    DeleterUserId        bigint,
    DeletionTime         datetime,
    Icon                 nvarchar(250)
        constraint DF_WMM_Project_Icon default N'far fa-circle'  not null
)
go

create unique index UQ_WMM_Project
    on WMM_Project (Prefix)
go

