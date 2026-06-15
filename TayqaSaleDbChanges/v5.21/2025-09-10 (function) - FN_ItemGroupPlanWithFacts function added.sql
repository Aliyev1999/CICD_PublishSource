CREATE OR ALTER FUNCTION [dbo].[FN_ItemGroupPlanWithFacts]
(
    @Firm     SMALLINT,
    @Year     INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT distinct
        itemGroupPlan.Id              AS ItemGroupPlanId,
        grp.Id                        AS GroupId,
        grp.Code                      AS GroupCode,
        grp.[Name]                    AS GroupName,
        grp.SpecialCode               AS GroupSpecialCode,
        grp.SpecialCode2              AS GroupSpecialCode2,
        grp.SpecialCode3              AS GroupSpecialCode3,
        igpe.LineNr                   AS LineNr,
        itemGroupPlan.[Month]         AS [Month],
        itemGroupPlan.Quantity        AS PlanQuantity,
        itemGroupPlan.Amount          AS PlanAmount,
        [user].Id                     AS UserId,
        [user].UserName               AS Username,
        firm.Nr                       AS FirmNr,
        firm.[Name]                   AS FirmName,
        factForSalesman.Id            AS FactId,
        factForSalesman.Amount        AS FactAmount,
        factForSalesman.Quantity      AS FactQuantity,
        factForSalesman.[Date]        AS FactDate,
        factForSalesman.ItemId        AS FactItemId,
        factItemUnit.Convfact2        AS FactItemUnitConvfact2,
        itemUnit.Convfact2            AS ItemUnitConvfact2,
        factForSalesman.ItemUnitId    AS FactItemUnitId,
        factForSalesman.SalesmanId    AS FactSalesmanId
    FROM dbo.MD_ItemGroup AS grp
    INNER JOIN dbo.MD_ItemGroupPlanExtension AS igpe with(nolock)
            ON grp.Id = igpe.ItemGroupId
    INNER JOIN dbo.MD_ItemGroupPlanForUser AS itemGroupPlan with(nolock)
            ON grp.Id = itemGroupPlan.ItemGroupId and itemGroupPlan.Firm = @Firm
    INNER JOIN dbo.MD_ItemGroupItemMapping AS itemGroupItemMapping with(nolock)
            ON grp.Id = itemGroupItemMapping.GroupId and itemGroupItemMapping.Firm = @Firm
    INNER JOIN dbo.MD_Item AS item with(nolock)
            ON itemGroupItemMapping.Firm   = item.Firm
           AND itemGroupItemMapping.ItemId = item.TigerId
           AND item.IsDeleted = 0
    INNER JOIN dbo.AbpUsers AS [user] with(nolock)
            ON itemGroupPlan.UserId = [user].Id
    INNER JOIN dbo.UIM_UserEmployeeMapping AS userEmployeeMapping with(nolock)
            ON [user].Id = userEmployeeMapping.UserId and userEmployeeMapping.Firm = @Firm

    LEFT JOIN dbo.OP_FactForSalesman AS factForSalesman with(nolock)
           ON userEmployeeMapping.EmployeeId = factForSalesman.SalesmanId
          AND itemGroupItemMapping.Firm      = factForSalesman.Firm
          AND itemGroupItemMapping.ItemId    = factForSalesman.ItemId

    LEFT JOIN dbo.MD_ItemUnit AS factItemUnit with(nolock)
           ON factForSalesman.Firm       = factItemUnit.Firm
          AND factForSalesman.ItemId     = factItemUnit.TigerItemId
          AND factForSalesman.ItemUnitId = factItemUnit.TigerId

    LEFT JOIN dbo.MD_ItemUnit AS itemUnit with(nolock)
           ON igpe.LineNr                 = itemUnit.LineNr
          AND itemGroupItemMapping.Firm   = itemUnit.Firm
          AND itemGroupItemMapping.ItemId = itemUnit.TigerItemId

    INNER JOIN dbo.MD_Firm  AS firm with(nolock)
            ON itemGroupPlan.Firm = firm.Nr  and firm.Nr = @Firm

    WHERE (@Firm IS NULL OR itemGroupPlan.Firm = @Firm)
      AND (@Year IS NULL OR itemGroupPlan.[Year] = @Year)
);
