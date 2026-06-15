create table AO_AuditOperation
(
    Id                                   int identity
        constraint PK_AO_AuditOperation
            primary key,
    Firm                                 smallint        not null,
    OperationStatus                      tinyint         not null,
    ClientId                             int             not null,
    ActNo                                nvarchar(100),
    ActDate                              datetime        not null,
    ClientDebt                           float           not null,
    ActualDebt                           float           not null,
    ControlDate                          datetime        not null,
    IsConfirmed                          bit             not null,
    ReasonId                             int             not null,
    SavedDate                            datetime        not null,
    CreatedDate                          datetime,
    CreatedUserId                        bigint,
    RegisteredDate                       datetime,
    LastModifierUserId                   bigint,
    LastModificationTime                 datetime,
    IsDeleted                            bit,
    InitialDifference                    float default 0 not null,
    UId                                  uniqueidentifier,
    TerminationOrCancelReasonId          int,
    TerminationOrCancelReasonDescription nvarchar(500)
)
go