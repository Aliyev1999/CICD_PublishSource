create table dbo.IM_WarehouseRepairDemand
(
    Id                       int identity
        constraint PK_IM_WarehouseRepairDemand
        primary key,
    Firm                     smallint      not null,
    InventoryId              int           not null,
    WarehouseNr              int           not null,
    Note                     nvarchar( max),
    Status                   tinyint       not null,
    RejectReasonId           int,
    CancelReasonId           int,
    CreatorUserId            bigint        not null,
    CreationTime             datetime      not null,
    ConfirmingUserId         bigint,
    ConfirmationTime         datetime,
    RejectedUserId           bigint,
    RejectionTime            datetime,
    CancelledUserId          bigint,
    CancelledDate            datetime,
    ActTime                  datetime,
    ConfirmedUserDescription nvarchar( max),
    RejectedUserDescription  nvarchar( max),
    CancelledUserDescription nvarchar( max),
    IsPrinted                bit
        constraint DF_IM_WarehouseRepairDemand_IsPrinted default 0,
    LastModificationTime     datetime,
    LastModifierUserId       bigint,
    DocumentedUserId         bigint,
    DocumentedDate           datetime,
    IsDocumented             bit default 0 not null,
    ActNo                    nvarchar( max),
    DocumentationNote        nvarchar( max)
)
    go
create table dbo.IM_WarehouseRepairTask
(
    Id                   int identity
        constraint PK_IM_WarehouseRepairTask
        primary key,
    DemandId             int      not null,
    CreatorUserId        bigint   not null,
    CreationTime         datetime not null,
    Priority             bit      not null,
    Note                 nvarchar( max),
    Status               tinyint  not null,
    PauseTime            datetime,
    StartTime            datetime,
    EndTime              datetime,
    ReasonId             int,
    RejectedUserId       bigint,
    RejectionDate        datetime,
    ConfirmedUserId      bigint,
    ConfirmationDate     datetime,
    AssignedUserId       bigint,
    AssignerUserId       bigint,
    LastModifierUserId   bigint,
    LastModificationTime datetime,
    ConfirmationNote     nvarchar( max),
    RejectionNote        nvarchar( max),
    RepairedUserNote     nvarchar( max),
    RepairResultDate     datetime,
    RepairedUserReasonId int,
    RepairStatus         tinyint
)
    go
create table dbo.IM_WarehouseRepairConsumption
(
    Id                   int identity
        constraint PK_IM_WAREHOUSEREPAIRCONSUMPTION
        primary key,
    TaskId               int      not null,
    Status               tinyint  not null,
    WarehouseNr          int      not null,
    CreationTime         datetime not null,
    CreatorUserId        bigint,
    FeedbackUserId       bigint,
    FeedbackDate         datetime,
    ReasonId             int,
    Note                 nvarchar( max),
    IsPrinted            bit
        constraint DF__IM_WarehouseRepairConsumption__IsPrinted default 0 not null,
    LastModificationTime datetime,
    LastModifierUserId   bigint
)
    go
create index IM_WarehouseRepairConsumption_CreationTime
    on dbo.IM_WarehouseRepairConsumption (CreationTime)
    go
create table dbo.IM_WarehouseRepairAttachment
(
    Id           int identity
        constraint PK_IM_WarehouseRepairAttachment
        primary key,
    ReferenceId  int     not null,
    Type         tinyint not null,
    Path         nvarchar( max) not null,
    SecureUrl as concat('NewImage-IM_WarehouseRepairAttachment', '-', [Id],
        reverse(left (reverse([Path]), charindex('\', reverse([Path]))))),
    CreationTime datetime
        constraint DF_IM_WarehouseRepairAttachment_CreationTime default getdate() not null
)
    go
create table dbo.IM_WarehouseRepairConsumptionLines
(
    Id            int identity
        constraint PK_IM_WAREHOUSEREPAIRCONSUMPTIONLINES
        primary key,
    ConsumptionId int   not null,
    ItemId        int   not null,
    Quantity      float not null,
    UnitCode      nvarchar(10) default 'AD' not null
)
    go
create table dbo.IM_WarehouseRepairExistingIssues
(
    Id       int identity
        constraint PK_IM_WAREHOUSEREPAIREXISTINGISSUES
        primary key,
    TaskId   int not null,
    DemandId int not null,
    IssueId  int not null
)
    go
create table dbo.IM_WarehouseRepairIssue
(
    Id         int identity
        constraint PK_IM_WarehouseRepairIssue
        primary key,
    DemandId   int           not null,
    IssueId    int           not null,
    IsResolved bit default 0 not null
)
    go