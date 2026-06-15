
ALTER function [dbo].[F_IM_GetNotifiedUsersForInventoryRepair](@repairDemandId int, @ActionType tinyint)
    RETURNS @T TABLE
               (
                   UserId int
               )
    AS
    begin

        declare @creatorUserId int = (select CreatorUserId
                                      from IM_RepairDemand with (nolock)
                                      where Id = @repairDemandId)
        --declare @ConfirmorRejectUserId int =(Select top(1) d.CreatorUserId as ConfirmorRejectUserId
        --                                                      from IM_RepairTask t with (nolock)  
        --										  join IM_RepairDemand d with (nolock) on t.DemandId = d.Id
        --										  left join IM_RepairConsumption c with(nolock) on t.Id=c.TaskId
        --                                                      where t.Id = @repairDemandId )
        --declare @ExecutionConfirmationOrRejectionUserId int =(Select top(1) coalesce(ConfirmedUserId, RejectedUserId) as ExecutionConfirmationOrRejectionUserId
        --                                                      from IM_RepairTask with (nolock)
        --                                                      where DemandId = @repairDemandId)


        if @ActionType = 1
            begin
                insert into @T (UserId)
                select ParentId as UserId
                from F_UIM_GetOrganizationUserParents(@creatorUserId, 0)
            end
        if @ActionType = 2
            begin
                insert into @T(UserId)
                select CreatorUserId
                from IM_RepairDemand
                where @repairDemandId = Id
            end
        if @ActionType = 3
            begin
                insert into @T(UserId)
                Select top (1) AssignedUserId as ExecutionConfirmationOrRejectionUserId
                from IM_RepairTask t with (nolock)
                         join IM_RepairDemand d with (nolock) on t.DemandId = d.Id
                         left join IM_WarehouseRepairConsumption c with (nolock) on t.Id = c.TaskId
                where t.Id = @repairDemandId
            end
        if @ActionType = 4
            begin
                insert into @T(UserId)
                Select top (1) d.CreatorUserId as ConfirmorRejectUserId
                from IM_RepairTask t with (nolock)
                         join IM_RepairDemand d with (nolock) on t.DemandId = d.Id
                         LEFT JOIN (SELECT TaskId, MAX(CreationTime) AS MaxConsumptionDate
                                    FROM IM_RepairConsumption with (nolock)
                                    GROUP BY TaskId) cmax ON t.Id = cmax.TaskId
                         left join IM_RepairConsumption c with (nolock) on t.Id = c.TaskId AND c.CreationTime = cmax.MaxConsumptionDate
                where t.Id = @repairDemandId
                  and ((c.TaskId is null) or (c.FeedbackUserId IS NOT NULL OR c.FeedbackDate IS NOT NULL))
            end
        return
    end