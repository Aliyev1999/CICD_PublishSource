
create table dbo.WPM_NonActionReasons
(
    Id                   int identity
        constraint WPM_NonActionReasons_pk
            primary key,
    Code                 nvarchar(100)              not null,
    Name                 nvarchar(100)              not null,
    Description          nvarchar(100),
    ActionTypeId         smallint                   not null
        constraint WPM_NonActionReasons_ActionType_fk
            references dbo.WPM_TaskActionType,
    IsActive             bit      default 1         not null,
    CreationTime         datetime default getdate() not null,
    CreatorUserId        bigint
        constraint WPM_NonActionReasons_CreatorUser_fk
            references dbo.AbpUsers,
    LastModifierUserId   bigint
        constraint WPM_NonActionReasons_LastModifierUserId_fk
            references dbo.AbpUsers,
    LastModificationTime datetime,
    DeleterUserId        bigint
        constraint WPM_NonActionReasons_DeleterUserId_fk
            references dbo.AbpUsers,
    DeletionTime         datetime,
    IsDeleted            bit      default 0         not null
)
go

create table dbo.WPM_NonActionReasonActionMappings
(
    Id                int identity
        constraint WPM_NonActionReasonActionMappings_pk
            primary key,
    NonActionReasonId int     not null
        constraint WPM_NonActionReasonActionMapping_ReasonId_fk
            references dbo.WPM_NonActionReasons,
    CreatorUserId     bigint
        constraint WPM_NonActionReasonActionMapping_CreatorUserId_fk
            references dbo.AbpUsers,
    CreationTime      datetime,
    ReferenceId       int     not null,
    ReferenceType     tinyint not null
)
go

create table dbo.WPM_SelectedNonActionReasons
(
    Id                int identity
        constraint WPM_SelectedNonActionReasons_pk
            primary key,
    ActionId          int                        not null
        constraint WPM_SelectedNonActionReasons_ActionId_fk
            references dbo.WPM_TaskAction,
    NonActionReasonId int                        not null
        constraint WPM_SelectedNonActionReasons_NonActionReasonId_fk
            references dbo.WPM_NonActionReasons,
    Note              nvarchar(200),
    CreationTime      datetime default getdate() not null,
    CreatorUserId     bigint                     not null
        constraint WPM_SelectedNonActionReasons_UserId_fk
            references dbo.AbpUsers,
    TaskTicketId      int
)
go
