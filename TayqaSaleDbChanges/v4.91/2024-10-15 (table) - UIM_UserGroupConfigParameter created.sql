-- auto-generated definition
create table UIM_UserGroupConfigParameter
(
    Id             int identity
        constraint [PK_dbo.UIM_UserGroupConfigParameter]
            primary key,
    GroupId        int                                           not null,
    Firm           smallint                                      not null,
    OperationId    tinyint                                       not null,
    ObjectId       smallint                                      not null,
    Objectvalue    nvarchar(50) collate SQL_Latin1_General_CP1_CI_AS,
    IsDefault      bit,
    ModifiedUserId int,
    CreatedUserId  int                                           not null,
    ModifiedDate   datetime,
    CreatedDate    datetime
        constraint DF__UIM_UserGroupCreateDate default getdate() not null
)
go

create unique index IX_UIM_UserGroupConfigParameter
    on UIM_UserGroupConfigParameter (ObjectId, GroupId, OperationId, Firm, Objectvalue)
go

create index IDX_GroupIdOpId
    on UIM_UserGroupConfigParameter (GroupId, OperationId)
go

