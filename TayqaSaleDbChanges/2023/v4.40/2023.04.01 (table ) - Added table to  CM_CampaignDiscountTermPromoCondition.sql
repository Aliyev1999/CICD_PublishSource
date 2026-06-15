create table CM_CampaignDiscountTermPromoCondition
(
    Id             int identity
        primary key,
    PromoLineId    int not null,
    DiscountTermId int not null
)
go