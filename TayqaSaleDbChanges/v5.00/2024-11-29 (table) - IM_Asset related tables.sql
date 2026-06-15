CREATE TABLE dbo.IM_AssetRequest (
  Id int IDENTITY,
  Firm smallint NULL,
  Type tinyint NULL,
  AssetId int NOT NULL,
  ReasonId int NULL,
  Note nvarchar(max) NULL,
  CreationTime datetime NULL DEFAULT (getdate()),
  CreatorUserId int NULL,
  Status tinyint NULL DEFAULT (1),
  PRIMARY KEY CLUSTERED (Id)
)
go
CREATE SEQUENCE [dbo].[AssetIdSequence] 
 AS [int]
 START WITH 39
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO

CREATE TABLE [dbo].[IM_Asset](
	[Id] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[AssetNr] [nvarchar](50) NOT NULL,
	[SerialNr] [nvarchar](50) NULL,
	[PurchaseDate] [date] NOT NULL,
	[InitialCostPrice] [float] NOT NULL,
	[CurrentCostPrice] [float] NULL,
	[AmortizationBeginDate] [date] NOT NULL,
	[AmortizationPercent] [float] NOT NULL,
	[AmortizationTerm] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[DeletionReason] [nvarchar](512) NULL,
	[SpecialCode] [nvarchar](100) NULL,
	[SpecialCode2] [nvarchar](100) NULL,
	[SpecialCode3] [nvarchar](100) NULL,
	[ResponsiblePerson] [int] NULL,
	[ResponsiblePerson2] [int] NULL,
	[Status] [int] NOT NULL,
	[SyncFlag] [bit] NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
	[BindingType] [tinyint] NULL,
	[BindingReference] [nvarchar](500) NULL,
	[WarehouseNr] [int] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
 CONSTRAINT [PK_IM_Asset] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_Id]  DEFAULT (NEXT VALUE FOR [AssetIdSequence]) FOR [Id]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_Status]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_SyncFlag]  DEFAULT ((0)) FOR [SyncFlag]
GO

ALTER TABLE [dbo].[IM_Asset] ADD  CONSTRAINT [DF_IM_Asset_RegistrationDate]  DEFAULT (getdate()) FOR [RegistrationDate]

go

exec sp_addextendedproperty 'MS_Description', ' NotSet = 0,
 Passive = 1,
 AtWarehouse = 2,
 InUse = 3,
 Cancelled = 4', 'SCHEMA', 'dbo', 'TABLE', 'IM_Asset', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', 'NotSet = 0,
User = 1,
Salesman = 2,
Division = 3,
Warehouse = 4,
Department = 5,
Client = 6,
Other = 128,', 'SCHEMA', 'dbo', 'TABLE', 'IM_Asset', 'COLUMN', 'BindingType'
go

create unique index IX_IM_Asset_Firm_AssetNr
    on dbo.IM_Asset (Firm, AssetNr)
go

create table dbo.IM_AssetAttachment
(
    Id           int identity
        primary key,
    ReferenceId  int                        not null,
    Type         tinyint                    not null,
    Path         nvarchar(max)              not null,
    SecureUrl    as concat('NewImage-IM_AssetAttachment', '-', [Id],
                           reverse(left(reverse([Path]), charindex('\', reverse([Path]))))),
    CreationTime datetime default getdate() not null
)
go

create table dbo.IM_AssetBinding
(
    Id                     int identity
        primary key,
    Firm                   smallint      not null,
    AssetId                int,
    BindingType            tinyint       not null,
    BindingReference       nvarchar(255) not null,
    PlannedHandoverDate    datetime,
    PlannedReturnDate      datetime,
    ActNo                  nvarchar(100),
    PlannedReceivingPerson nvarchar(255),
    ActualReceivingPerson  nvarchar(255),
    AssignedUserId         int,
    AuditDayCount          int,
    BindingReasonId        int,
    Note                   nvarchar(500),
    RejectingPerson        nvarchar(255),
    RejectionReasonId      int,
    RejectionNote          nvarchar(500),
    IdentityNo             nvarchar(50),
    CreationTime           datetime,
    CreatorUserId          bigint,
    LastModificationDate   datetime,
    LastModifierUserId     bigint,
    Status                 tinyint default 1,
    CancelledUserId        int,
    CancelledDate          datetime,
    CancelledNote          nvarchar(500),
    CancelReasonId         int
)
go

create table dbo.IM_AssetBindingHistory
(
    Id               int identity
        constraint PK_IM_AssetBindingHistory
            primary key,
    AssetId          int                                                    not null,
    BindingType      tinyint                                                not null,
    BindingReference nvarchar(500),
    CreatorUserId    bigint,
    CreationTime     datetime
        constraint DF_IM_AssetBindingHistory_CreationTime default getdate() not null
)
go

exec sp_addextendedproperty 'MS_Description', 'NotSet = 0,
User = 1,
Salesman = 2,
Division = 3,
Warehouse = 4,
Department = 5,
Client = 6,
Other = 128,', 'SCHEMA', 'dbo', 'TABLE', 'IM_AssetBindingHistory', 'COLUMN', 'BindingType'
go

