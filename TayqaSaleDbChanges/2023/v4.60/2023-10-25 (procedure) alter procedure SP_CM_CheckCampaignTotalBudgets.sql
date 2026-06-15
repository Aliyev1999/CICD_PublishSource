
ALTER PROCEDURE [dbo].[SP_CM_CheckCampaignTotalBudgets] @budgetData nvarchar(max), @requestId int = null
    with recompile
as
begin

    -- Date: Created by TayqaTech for TayqaSale (Kanan Mammadov)
-- Ticket: TSC-3813
-- Description: The query returns the list of campaigns which do not exceed the budgets


    --- 0
    --------------------------------------- Initial Declarations ---------------------------------------

    declare @clientId int, @firm smallint
    select @clientId = ClientId, @firm = Firm from OP_IncomingLog with (nolock) where Id = @requestId

    declare @clientGroupType tinyint = (select Value from SYS_GlobalConfigParameter where Name = 'ClientGroupTypeForCampaign' and Status = 1)

    ---------------------------------------------------------------------------------------------------


    --- 1
    ------------------------------------------ Client Budgets ------------------------------------------


    declare @BudgetForClient table
                             (
                                 CampaignId                   int,
                                 ConsumedAmount               float,
                                 BudgetForEachClient          float,
                                 AppliedCount                 int,
                                 ApplicableCountForEachClient int
                             )

    insert into @BudgetForClient (CampaignId, ConsumedAmount, BudgetForEachClient, AppliedCount, ApplicableCountForEachClient)
    select CM_Campaign.Id, isnull(Consumed, 0), BudgetForEachClient, isnull(AppliedCount, 0), ApplicableCountForEachClient
    from CM_Campaign with (nolock)

             left join (select CampaignId, round(sum(Consumption), 2) as Consumed, count(distinct RequestId) as AppliedCount
                        from CM_CampaignBudgetConsumption
                        where ReferenceId = @clientId
                          and AudienceType = 9
                        group by CampaignId) ConsumptionByAudience on Id = CampaignId
    where IsActive = 1
      and Status = 2
      and iif(BudgetForEachClient is null, 1, iif(Consumed >= CM_Campaign.BudgetForEachClient, 0, 1)) = 1
      and iif(ApplicableCountForEachClient is null, 1, iif(AppliedCount >= CM_Campaign.ApplicableCountForEachClient, 0, 1)) = 1;

    ---------------------------------------------------------------------------------------------------


    --- 2
    --------------------------------------- Client Group Budgets --------------------------------------


    declare @ClientGroupId int = (select GroupId from MD_ClientGroupData where ClientId = @clientId and GroupType = @clientGroupType and Firm = @firm)

    declare @BudgetForClientGroups table
                                   (
                                       CampaignId                        int,
                                       ConsumedAmount                    float,
                                       BudgetForEachClientGroup          float,
                                       AppliedCount                      int,
                                       ApplicableCountForEachClientGroup int
                                   )

    insert into @BudgetForClientGroups (CampaignId, ConsumedAmount, BudgetForEachClientGroup, AppliedCount, ApplicableCountForEachClientGroup)
    select CM_Campaign.Id, isnull(Consumed, 0), BudgetForEachClientGroup, isnull(AppliedCount, 0), ApplicableCountForEachClientGroup
    from CM_Campaign with (nolock)
             left join (select CampaignId, round(sum(Consumption), 2) as Consumed, count(distinct RequestId) as AppliedCount
                        from CM_CampaignBudgetConsumption
                        where ReferenceId = @ClientGroupId
                          and AudienceType = 10
                        group by CampaignId) ConsumptionByAudience on Id = CampaignId

    where IsActive = 1
      and Status = 2
      and iif(BudgetForEachClientGroup is null, 1, iif(Consumed >= CM_Campaign.BudgetForEachClientGroup, 0, 1)) = 1
      and iif(ApplicableCountForEachClientGroup is null, 1, iif(AppliedCount >= CM_Campaign.ApplicableCountForEachClientGroup, 0, 1)) = 1;

    ---------------------------------------------------------------------------------------------------


    --- 3
    ------------------------------------------ Data Parsing ------------------------------------------
    -- Parsing requested consumption for selected campaigns
    declare @Request table
                     (
                         CampaignId           int,
                         RequestedConsumption float
                     )

    insert into @Request (CampaignId, RequestedConsumption)
    select json_value(Value, '$.CampaignId'), json_value(Value, '$.Consumption')
    from (select Value from F_SplitList(@budgetData, ';')) t

    -- Finding all campaign budgets
    declare @CampaignBudgets table
                             (
                                 CampaignId    int,
                                 GeneralBudget float,
                                 ApplyCount    int
                             )

    insert into @CampaignBudgets (Campaignid, GeneralBudget, ApplyCount)
    select Id, Budget, MainApplicableCount
    from CM_Campaign with (nolock)
    where IsActive = 1
      and Status = 2

    ---------------------------------------------------------------------------------------------------


    --- 4
    ----------------------------------------- Consumption Data ----------------------------------------

    -- Finding total consumption for requested campaigns
    declare @ConsumedData table
                          (
                              CampaignId     int,
                              ConsumedAmount float,
                              AppliedCount   int
                          )

    insert into @ConsumedData (CampaignId, ConsumedAmount, AppliedCount)
    select Request.CampaignId, isnull(Consumption.Consumption, 0) as TotalConsumption, AppliedCount
    from @Request Request
             left join (select Consumption.CampaignId, sum(Consumption.Consumption) as Consumption, count(distinct RequestId) as AppliedCount
                        from CM_CampaignBudgetPromoConsumption Consumption with (nolock)
                        group by Consumption.CampaignId) as Consumption
                       on Request.CampaignId = Consumption.CampaignId;

    ---------------------------------------------------------------------------------------------------


    --- 5
    ------------------------------------------ Final Result -------------------------------------------
    -- Returning campaigns allowed to apply
    with GeneralBudget as (select Request.CampaignId
                           from @CampaignBudgets Budgets
                                    join @ConsumedData Consumed on Budgets.CampaignId = Consumed.CampaignId
                                    join @Request Request on Request.CampaignId = Budgets.CampaignId
                           where (ConsumedAmount + RequestedConsumption <= GeneralBudget or GeneralBudget is null)
                             and (isnull(Consumed.AppliedCount, 0) + 1 <= Budgets.ApplyCount or Budgets.ApplyCount is null)),

         BudgetForClient as (select Request.CampaignId
                             from @BudgetForClient Budgets
                                      join @ConsumedData Consumed on Budgets.CampaignId = Consumed.CampaignId
                                      join @Request Request on Request.CampaignId = Budgets.CampaignId
                             where (Budgets.ConsumedAmount + RequestedConsumption <= BudgetForEachClient or BudgetForEachClient is null)
                               and (isnull(Consumed.AppliedCount, 0) + 1 <= Budgets.ApplicableCountForEachClient or Budgets.ApplicableCountForEachClient is null)),

         BudgetForClientGroups as (select Request.CampaignId
                                   from @BudgetForClientGroups Budgets
                                            join @ConsumedData Consumed on Budgets.CampaignId = Consumed.CampaignId
                                            join @Request Request on Request.CampaignId = Budgets.CampaignId
                                   where (Budgets.ConsumedAmount + RequestedConsumption <= BudgetForEachClientGroup or BudgetForEachClientGroup is null)
                                     and (isnull(Consumed.AppliedCount + 1, 0) <= Budgets.ApplicableCountForEachClientGroup or Budgets.ApplicableCountForEachClientGroup is null))

    select BudgetForClient.CampaignId as CampaignId
    from BudgetForClient
             join BudgetForClientGroups on BudgetForClientGroups.CampaignId = BudgetForClient.CampaignId
             join GeneralBudget on BudgetForClientGroups.CampaignId = GeneralBudget.CampaignId

    ---------------------------------------------------------------------------------------------------
end