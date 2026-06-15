ALTER PROCEDURE [dbo].[SP_CM_GetCampaignBudgets] @RequestId int, @CampaignsList nvarchar(MAX)
AS
BEGIN

    -- Initial declarations
    declare @CampaignsBudgets table
                              (
                                  CampaignId        int,
                                  Priority          nvarchar(100),
                                  AudienceType      tinyint,
                                  ReferenceId       bigint,
                                  ReferenceValue    nvarchar(500),
                                  IsBudgetSpecified bit,
                                  BudgetAmount      float,
								  ApplicableCount   int
                              );

    declare @BudgetConsumption table
                               (
                                   CampaignId        int,
                                   AudienceType      tinyint,
                                   ReferenceId       bigint,
                                   ReferenceValue    nvarchar(500),
                                   ConsumptionAmount float,
								   AppliedCount      int
                               );


    declare @Date date = (select ProcessDate
                          from OP_IncomingLog with (nolock)
                          where Id = @RequestId);

    declare @Firm smallint = (select Firm
                              from OP_IncomingLog with (nolock)
                              where Id = @RequestId);


---------------------- Get budgets for each campaign, audience type and reference ----------------------

    insert into @CampaignsBudgets (CampaignId, Priority, AudienceType, ReferenceId, ReferenceValue, IsBudgetSpecified, BudgetAmount,ApplicableCount)
    select Campaigns.Id                                                                                                                          as CampaignId,
           Priority                                                                                                                              as Priority,
           AudianceType                                                                                                                          as AudianceType,
           ReferanceId                                                                                                                           as ReferenceId,
           Value                                                                                                                                 as ReferenceValue,
           iif(Lines.Budget is not null, 1, 0)                                                                                                   as IsBudgetSpecified,
           iif(Lines.Budget is null, Campaigns.Budget - sum(Lines.Budget) over (partition by Campaigns.Id, Audience.AudianceType), Lines.Budget) as BudgetAmount,
		   ApplicableCount                                                                                                                       as ApplicableCount
    from CM_Campaign Campaigns with (nolock)
             join CM_CampaignTargetAudiance Audience with (nolock)
                  on Audience.CampaignId = Campaigns.Id
             join CM_CampaignTargetAudianceLine Lines with (nolock) on Audience.Id = Lines.TargetAudianceId
    where SelectionType = 1
      and Campaigns.Id in (select Value from F_SplitList(@CampaignsList, ','))
      and Campaigns.StartDate <= @Date
      and Campaigns.EndDate >= @Date
      and Campaigns.IsActive = 1
      and Campaigns.Firm = @Firm;


---------------------- Get budget consumption for each campaign, audience type and reference ----------------------

    with CalculatedData as (SELECT CampaignId, AudienceType, ReferenceId, Value as ReferenceValue, Consumption, LastUpdateTime,AppliedCount
                            FROM CM_CampaignConsumptionCalculatedData with (nolock)
                            where CampaignId in (select Value from F_SplitList(@CampaignsList, ','))),


         Consumption as (select coalesce(CalculatedData.CampaignId, AllConsumption.CampaignId)     as CampaignId,
                                coalesce(CalculatedData.AudienceType, AllConsumption.AudienceType) as AudienceType,
                                coalesce(CalculatedData.ReferenceId, AllConsumption.ReferenceId)   as ReferenceId,
                                coalesce(CalculatedData.ReferenceValue, AllConsumption.Value)      as ReferenceValue,
                                isnull(CalculatedData.Consumption, 0)                              as CalculatedConsumption,
                                sum(AllConsumption.Consumption)                                    as CurrentConsumption,
								isnull(CalculatedData.AppliedCount,0)                              as CalculatedAppliedCount,
								count(AllConsumption.CampaignId)                                   as CurrentAppliedCount
                         from CalculatedData
                                  full outer join (select CreationTime,
                                                          CampaignId,
                                                          AudienceType,
                                                          ReferenceId,
                                                          Value,
                                                          Consumption
                                                   from CM_CampaignBudgetConsumption AllConsumption with (nolock)) AllConsumption on
                                     AllConsumption.CampaignId = CalculatedData.CampaignId and
                                     AllConsumption.AudienceType = CalculatedData.AudienceType and
                                     (AllConsumption.ReferenceId = CalculatedData.ReferenceId or
                                      AllConsumption.Value = CalculatedData.ReferenceValue collate Azeri_Latin_100_CI_AS)

                         where (AllConsumption.CreationTime > CalculatedData.LastUpdateTime or CalculatedData.CampaignId is null)
                           and AllConsumption.CampaignId in (select Value from F_SplitList(@CampaignsList, ','))
                         group by coalesce(CalculatedData.CampaignId, AllConsumption.CampaignId),
                                  coalesce(CalculatedData.AudienceType, AllConsumption.AudienceType),
                                  coalesce(CalculatedData.ReferenceId, AllConsumption.ReferenceId),
                                  coalesce(CalculatedData.ReferenceValue, AllConsumption.Value),
                                  isnull(CalculatedData.Consumption, 0),
								   isnull(CalculatedData.AppliedCount,0) )

    insert
    into @BudgetConsumption (CampaignId, AudienceType, ReferenceId, ReferenceValue, ConsumptionAmount,AppliedCount)
    select CampaignId,
           AudienceType,
           ReferenceId,
           ReferenceValue,
           sum(CalculatedConsumption + CurrentConsumption),
		   sum(CalculatedAppliedCount+CurrentAppliedCount)
    from Consumption
    group by CampaignId, AudienceType, ReferenceId, ReferenceValue


    -- Final Calculation Results
    select Budgets.CampaignId,
           Budgets.AudienceType,
           Budgets.ReferenceId,
           Budgets.ReferenceValue,
           --isnull(Consumption.ConsumptionAmount, 0)                        as ConsumptionAmount,
           round(Budgets.BudgetAmount - isnull(Consumption.ConsumptionAmount, 0), 2) as AvailableBudget,
		   Budgets.ApplicableCount- isnull(AppliedCount,0)  as AvailableCount
    from @CampaignsBudgets Budgets
             left join @BudgetConsumption Consumption
                       on Budgets.CampaignId = Consumption.CampaignId and Budgets.AudienceType = Consumption.AudienceType and
                          (Budgets.ReferenceId = Consumption.ReferenceId or Budgets.ReferenceValue = Consumption.ReferenceValue)
    order by Budgets.Priority asc

END