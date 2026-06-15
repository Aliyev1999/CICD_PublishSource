create table OP_ClientSalesmanDebt
(
    Firm           smallint                                     not null,
    TigerClientId  int                                          not null,
    CurrencyType   smallint                                     not null,
    Debit          float                                        not null,
    Credit         float                                        not null,
    SalesmanId     int                                          not null,
    RegisteredDate datetime default getdate(),
    OrderNo        tinyint                                      not null,
    constraint PK_OP_ClientSalesmanDebt
        primary key (Firm, TigerClientId, SalesmanId, CurrencyType, OrderNo)
)

GO

create table MD_ClientSalesmanFinanceData
(
    TigerId                          int           not null,
    Firm                             smallint      not null,
    SalesmanId                       int           not null,
    PaymentPlanId                    int,
    AccumulatedRiskLimit             float         not null,
    SelfCheckVoucherRiskLimit        float         not null,
    ClientCheckVoucherRiskLimit      float         not null,
    CheckVoucherCirculationRiskLimit float         not null,
    DispatchRiskLimit                float         not null,
    DispatchProposalRiskLimit        float         not null,
    OrderRiskLimit                   float         not null,
    OrderProposalRiskLimit           float         not null,
    ClosedRisk                       float,
    TotalRisk                        float,
    RegisteredDate                   datetime      not null,
    IsDeleted                        bit default 0 not null,

    Status                           bit default 0 not null
        constraint PK_MD_ClientSalesmanFinanceData
            primary key (TigerId, Firm, SalesmanId)
)