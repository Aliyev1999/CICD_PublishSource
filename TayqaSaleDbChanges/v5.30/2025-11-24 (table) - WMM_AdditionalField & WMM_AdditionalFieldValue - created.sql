
create table dbo.WMM_AdditionalField
(
    Id                   int identity
        constraint PK_WMM_AdditionalField
            primary key,
    Name                 nvarchar(100)                        not null,
    InputType            tinyint                              not null,
    ProjectId            int                                  not null
        constraint FK_WMM_AdditionalField_Project
            references dbo.WMM_Project (Id),
    TaskTypeId           int                                  not null
        constraint FK_WMM_AdditionaField_ProjectTaskType
            references dbo.WMM_ProjectTaskType (Id),
    IsActive             bit
        constraint DF_WMM_AdditionalField_IsActive default 1  not null,
    IsDeleted            bit
        constraint DF_WMM_AdditionalField_IsDeleted default 0 not null,
    DeletionTime         datetime,
    DeleterUserId        bigint,
    SelectComponentId    int
        constraint FK_WMM_AdditionalField_SelectComponent
            references dbo.WMM_SelectComponent (Id),
    CreationTime         datetime default getdate()           not null,
    CreatorUserId        bigint
        constraint WMM_AdditionalField_CreatorUserId_fk
            references dbo.AbpUsers,
    LastModifierUserId   bigint
        constraint WMM_AdditionalField_LastModifierUserId_fk
            references dbo.AbpUsers,
    LastModificationTime datetime
)
go

create table dbo.WMM_AdditionalFieldValue
(
    Id                   int identity
        constraint PK_WMM_AdditionalFieldValue
            primary key,
    Value                nvarchar(100),
    CreationTime         datetime default getdate() not null,
    CreatorUserId        bigint
        constraint WMM_AdditionalFieldValue_CreatorUserId_fk
            references dbo.AbpUsers,
    LastModifierUserId   bigint
        constraint WMM_AdditionalFieldValue_LastModifierUserId_fk
            references dbo.AbpUsers,
    LastModificationTime datetime,
    TaskId               int                        not null
        constraint WMM_AdditionalFieldValue_Task_fk
            references dbo.WMM_Task,
    AdditionalFieldId    int                        not null
        constraint WMM_AdditionalFieldValue_AdditionalFieldId_fk
            references dbo.WMM_AdditionalField
)
go
