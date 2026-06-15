ALTER Procedure [dbo].[SP_RM_GetTarget](@userId int,
                                        @firm smallint,
                                        @beginDate datetime,
                                        @endDate datetime,
                                        @viewMode tinyint=1)
AS
BEGIN

-- Last modified by Kanan Mammadov to enable hierarchy of hybrid user

    declare @SalePercentage float, @CashInPercentage float, @DistributionPercentage float


    -- Sale plans

    declare @SalePlanAmount float = (select sum(Amount) PlanAmount
                                     from MD_ItemGroupPlanForUser Plans
                                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Plans.UserId
                                     where (((@viewMode is null or @viewMode = 1) and Plans.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                                       and Firm = @firm
                                       and Month = month(@beginDate)
                                       and Year = year(@beginDate))

    declare @SaleFactAmount float = (select round(sum(iif(Invoice.[Type] = 4, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                                                  sum(iif(Invoice.[Type] = 2, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)),
                                                  2) AS FactAmount
                                     from ERP_Invoice Invoice with (nolock)
                                              join ERP_InvoiceLine Line with (nolock) ON Line.InvoiceId = Invoice.ERPId
                                              join MD_ItemGroupItemMapping ItemMapping with (nolock) on ItemMapping.ItemId = Line.ItemId and ItemMapping.Firm = Invoice.Firm
                                              join MD_ItemGroupPlanForUser Plans with (nolock) on Plans.ItemGroupId = ItemMapping.GroupId and Plans.Firm = ItemMapping.Firm
                                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Plans.UserId

                                     where Invoice.IsDeleted = 0
                                       and IsCancelled = 0
                                       and Line.LineType <> 1
                                       and (((@viewMode is null or @viewMode = 1) and Plans.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                                       and month(Invoice.Date) = month(@beginDate)
                                       and year(Invoice.Date) = year(@beginDate)
                                       and Plans.Month = month(@beginDate)
                                       and Plans.Year = year(@beginDate)
                                       and Invoice.SalesmanId in (select EmployeeId
                                                                  from UIM_UserEmployeeMapping Mapping with (nolock)
                                                                           left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Mapping.UserId = TreeUsers.UserId
                                                                  where (((@viewMode is null or @viewMode = 1) and Mapping.UserId = @userId)
                                                                      or (@viewMode = 2 and TreeUsers.UserId is not null))
                                                                    and Firm = @firm
                                                                    and Status = 0))

    set @SalePercentage = iif(@SalePlanAmount is null or @SalePlanAmount = 0 or @SaleFactAmount is null, 0, round((@SaleFactAmount * 100) / @SalePlanAmount, 2))

    ------------------------------------------------------------------------------------------------
    -- Cash plans


    declare @CastFactAmount float = (SELECT SUM(FinOps.Amount) AS FactAmount
                                     FROM ERP_FinanceOperation FinOps WITH (NOLOCK)
                                     WHERE FinOps.[Type] IN (5, 21)
                                       AND FinOps.[Sign] = 1
                                       AND FinOps.IsCancelled = 0
                                       AND month(FinOps.Date) = month(@beginDate)
                                       AND year(FinOps.Date) = year(@beginDate)
                                       AND SalesmanId in (select EmployeeId
                                                          from UIM_UserEmployeeMapping Mapping with (nolock)
                                                                   left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Mapping.UserId = TreeUsers.UserId
                                                          where ((@viewMode is null or @viewMode = 1 and Mapping.UserId = @userId)
                                                              or (@viewMode = 2 and TreeUsers.UserId is not null))
                                                            and Firm = @firm
                                                            and Status = 0))

    declare @CastPlanAmount float = (select sum(Amount)
                                     from MD_CashPlanForUser Plans
                                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Plans.UserId = TreeUsers.UserId
                                     where Month = month(@beginDate)
                                       and Year = year(@beginDate)
                                       and ((@viewMode is null or @viewMode = 1 and Plans.UserId = @userId)
                                         or (@viewMode = 2 and TreeUsers.UserId is not null)))


    set @CashInPercentage = iif(@CastFactAmount is null or @CastPlanAmount is null or @CastPlanAmount = 0, 0, round((@CastFactAmount * 100) / @CastPlanAmount, 2))


    ------------------------------------------------------------------------------------------------

    -- Distribution Plans
    set @DistributionPercentage =
            isnull((select AVG(TargetClientPercent)
                    from (select ClientGroupId, ItemGroupId, TargetClientPercent
                          from MD_DistributionItemGroupPlan
                          where UserId = @userId
                            and Month = month(@beginDate)
                            and Year = year(@beginDate)) Target
                             left join (select ClientGroups.GroupId             as ClientGroupId,
                                               Mapping.GroupId                  as ItemGroupId,
                                               count(distinct Invoice.ClientId) as FactClientCount
                                        from ERP_Invoice Invoice with (nolock)
                                                 join ERP_InvoiceLine Lines with (nolock) on Invoice.ERPId = Lines.InvoiceId
                                                 join MD_ItemGroupItemMapping Mapping with (nolock)
                                                      on Mapping.ItemId = Lines.ItemId and Mapping.Firm = Invoice.Firm and Mapping.GroupType = 3
                                                 join UIM_UserEmployeeMapping Employees with (nolock)
                                                      on Employees.Firm = Invoice.Firm and Employees.EmployeeId = Invoice.SalesmanId and
                                                         Employees.Status = 0
                                                 join MD_ClientGroupData ClientGroups with (nolock)
                                                      on ClientGroups.Firm = Employees.Firm and ClientGroups.GroupType = 10 and
                                                         ClientGroups.ClientId = Invoice.ClientId
                                        where Lines.LineType <> 1
                                          and Invoice.IsDeleted = 0
                                          and Invoice.IsCancelled = 0
                                          and month(Invoice.Date) = month(@beginDate)
                                          and year(Invoice.Date) = year(@beginDate)
                                          and Invoice.Type = 4
                                          and Invoice.SalesmanId in (select EmployeeId
                                                                     from UIM_UserEmployeeMapping Mapping with (nolock)
                                                                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Mapping.UserId = TreeUsers.UserId
                                                                     where ((@viewMode is null or @viewMode = 1 and Mapping.UserId = @userId)
                                                                         or (@viewMode = 2 and TreeUsers.UserId is not null))
                                                                       and Firm = @firm)
                                          and ClientGroups.Firm = @firm
                                        group by ClientGroups.GroupId, Mapping.GroupId) Facts
                                       on Target.ItemGroupId = Facts.ItemGroupId and Target.ClientGroupId = Facts.ClientGroupId),
                   0)


    select isnull(@SalePercentage, 0)         as SalePercentage,
           isnull(@CashInPercentage, 0)       as CashInPercentage,
           isnull(@DistributionPercentage, 0) as DistributionPercentage

END;