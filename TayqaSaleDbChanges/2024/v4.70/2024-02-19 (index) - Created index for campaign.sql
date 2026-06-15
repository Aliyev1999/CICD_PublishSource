
go
IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('CM_CampaignBudgetConsumption') 
    AND name = 'IX_CM_CampaignBudgetConsumption_AudienceType_ReferenceId'
)
BEGIN
    select 'Index exists on the table.'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX IX_CM_CampaignBudgetConsumption_AudienceType_ReferenceId
ON [dbo].[CM_CampaignBudgetConsumption] ([AudienceType],[ReferenceId])
INCLUDE ([CampaignId],[Consumption],[RequestId])
END
go