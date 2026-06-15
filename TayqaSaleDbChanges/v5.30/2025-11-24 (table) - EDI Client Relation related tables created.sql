
create table dbo.EDI_Company
(
    Id                   int identity
        constraint PK_EDI_Company
            primary key,
    Name                 nvarchar(100)              not null,
    Code                 nvarchar(100)              not null,
    CreatorUserId        bigint
        constraint EDI_Company_CreatorUserId_fk
            references dbo.AbpUsers,
    CreationTime         datetime default getdate() not null,
    LastModifierUserId   bigint
        constraint EDI_Company_LastModifierUserId_fk
            references dbo.AbpUsers,
    LastModificationTime bigint,
    DeleterUserId        bigint
        constraint EDI_Company_DeleterUserId_fk
            references dbo.AbpUsers,
    DeletionTime         datetime,
    IsDeleted            bit      default 0         not null
)
go

create table dbo.EDI_ClientRelation
(
    Id                   int identity
        constraint EDI_ClientRelation_pk
            primary key,
    Firm                 smallint                   not null,
    BuyerCompanyId       int                        not null
        constraint EDI_ClientRelation_BuyerCompany_fk
            references dbo.EDI_Company,
    SellerCompanyId      int                        not null
        constraint EDI_ClientRelation_SellerCompany_fk
            references dbo.EDI_Company,
    DeliveryLocationName nvarchar(100)              not null,
    DeliveryLocationCode nvarchar(100)              not null,
    ClientId             int                        not null,
    CreationTime         datetime default getdate() not null,
    CreatorUserId        bigint
        constraint EDI_ClientRelation_CreatorUser_fk
            references dbo.AbpUsers,
    LastModifierUserId   bigint
        constraint EDI_ClientRelation_LastModifierUserId_fk
            references dbo.AbpUsers,
    LastModificationTime datetime,
    DeleterUserId        bigint
        constraint EDI_ClientRelation_DeleterUserId_fk
            references dbo.AbpUsers,
    DeletionTime         datetime,
    IsDeleted            bit      default 0         not null
)
go
