alter table CM_Campaign
    add MainApplicableCount int,
        ApplicableCountForEachSaleChannel int,
        ApplicableCountForEachClientGroup int,
        ApplicableCountForEachClient int

go
alter table CM_CampaignTargetAudianceLine
    add ApplicableCount int

go
alter table CM_CampaignConsumptionCalculatedData
    add AppliedCount int