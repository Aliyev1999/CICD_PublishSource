create table dbo.EDI_CatalogItem
(
    Id               int identity
        primary key,
    CatalogId        int,
    LineNumber       int,
    LineType         tinyint,
    Ean              nvarchar(20),
    BuyerItemCode    nvarchar(20),
    Description      nvarchar(255),
    EdiUnit          nvarchar(20),
    Price            float,
    MinOrderQuantity float,
    UnitPackSize     float,
    Weight           float,
    RegisteredDate   datetime default getdate()
)
go

create table dbo.EDI_OrderLine
(
    Id            int identity
        constraint PK_EDI_Order
            primary key,
    OrderId       int,
    LineNumber    smallint,
    BuyerItemCode nvarchar(20),
    Ean           nvarchar(20),
    Quantity      float,
    UnitCode      nvarchar(20),
    PackSize      float,
    Price         float
)
go

create table dbo.EDI_ItemMapping
(
    Id                   int identity
        primary key,
    Firm                 smallint,
    BuyerCompanyId       int,
    BuyerItemCode        nvarchar(20),
    EanBarcode           nvarchar(20),
    SellerItemId         int,
    Divider              float,
    CreationTime         datetime default getdate(),
    CreatorUserId        bigint,
    LastModificationTime datetime,
    LastModifierUserId   bigint,
    IsDeleted            bit      default 0,
    DeletionTime         datetime,
    DeleterUserId        bigint
)
go

create table dbo.EDI_Order
(
    Id                   int                    not null
        constraint PK_EDI_Orders
            primary key,
    Firm                 smallint,
    TrackingId           uniqueidentifier,
    DeliveryLocationCode nvarchar(50),
    OrderNumber          nvarchar(25),
    OrderDate            date,
    ExpectedDeliveryDate date,
    CreationTime         datetime
        constraint DF_EDI_Order_Creat default getdate(),
    CreatorUserId        bigint,
    LastModificationTime datetime,
    LastModifierUserId   bigint,
    IsDeleted            bit
        constraint DF_EDI_Order_IsDel default 0,
    DeletionTime         datetime,
    DeleterUserId        bigint,
    Status               tinyint
        constraint DF_EDI_Order__Status default 0,
    BuyerCompanyId       int
        constraint DF_EDI_Order_Buyer default 0 not null,
    SellerCompanyId      int
        constraint DF_EDI_Order_Selle default 0 not null
)
go

create table dbo.EDI_UnitMapping
(
    Id                   int identity
        primary key,
    Firm                 smallint,
    EdiUnitCode          nvarchar(20),
    TayqaUnitCode        nvarchar(20),
    CreationTime         datetime default getdate(),
    CreatorUserId        bigint,
    LastModificationTime datetime,
    LastModifierUserId   bigint,
    IsDeleted            bit      default 0,
    DeletionTime         datetime,
    DeleterUserId        bigint
)
go

