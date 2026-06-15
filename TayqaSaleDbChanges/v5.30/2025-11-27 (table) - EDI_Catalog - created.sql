create table EDI_Catalog
(
    Id              int                not null
        primary key,
    TrackingId      uniqueidentifier,
    Number          nvarchar(20),
    Date            datetime,
    RegisteredDate  datetime default getdate(),
    IsDeleted       bit      default 0,
    BuyerCompanyId  int      default 0 not null,
    SellerCompanyId int      default 0 not null,
    Firm            smallint           not null
)