CREATE function [dbo].[F_IM_GetNotifiedUsersForInventoryWarehouseRepair](@WarehouseRepairDemandId int, @ActionType tinyint)
    RETURNS @T TABLE
               (
                   UserId int
               )
    AS
    begin

        declare @creatorUserId int = (select CreatorUserId
                                      from IM_WarehouseRepairDemand with (nolock)
                                      where Id = @WarehouseRepairDemandId)

        if @ActionType = 1
            begin
                insert into @T (UserId)
                select ParentId as UserId
                from F_UIM_GetOrganizationUserParents(@creatorUserId, 0)
            end
        if @ActionType = 2
            begin
                insert into @T(UserId)
                Select top (1) AssignedUserId as ExecutionConfirmationOrRejectionUserId
                from IM_WarehouseRepairTask t with (nolock)
                         join IM_WarehouseRepairDemand d with (nolock) on t.DemandId = d.Id
                where t.DemandId = @WarehouseRepairDemandId
            end 
        if @ActionType = 3
            begin
                insert into @T(UserId)
                SELECT TOP (1) d.CreatorUserId as ConfirmorRejectUserId
                FROM IM_WarehouseRepairTask t with (nolock)
                         JOIN IM_WarehouseRepairDemand d with (nolock) ON t.DemandId = d.Id
                         LEFT JOIN (SELECT TaskId, MAX(CreationTime) AS MaxConsumptionDate
                                    FROM IM_WarehouseRepairConsumption
                                    GROUP BY TaskId) cmax ON t.Id = cmax.TaskId
                         LEFT JOIN IM_WarehouseRepairConsumption c with (nolock) ON t.Id = c.TaskId AND c.CreationTime = cmax.MaxConsumptionDate
                WHERE t.Id = @WarehouseRepairDemandId
                  and ((c.TaskId is null) or (c.FeedbackUserId IS NOT NULL OR c.FeedbackDate IS NOT NULL))
            end
        return
    end

