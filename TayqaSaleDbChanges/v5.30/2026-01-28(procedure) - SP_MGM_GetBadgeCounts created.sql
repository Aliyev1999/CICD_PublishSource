CREATE OR ALTER PROCEDURE [dbo].[SP_MGM_GetBadgeCounts] @userId INT
AS
BEGIN
    SET NOCOUNT ON;


    declare @TreeUsers table( UserId int);

    insert into @TreeUsers (UserId)
    select UserId
    from F_UIM_GetOrganizationTreeUsers(@userId);


    select 'RouteDemand'             as [Key],
           (select count(*)
            from OP_RouteRequest routes with (nolock)
                     join @TreeUsers treeusers on treeusers.UserId = routes.CreatedUserId
            where routes.Status = 0) as [Value]

    union all

    select 'InventoryDemand'                                           as [Key],
           (select count(*)
            from IM_InventoryDemand demand with (nolock)
                     join @TreeUsers treeusers on treeusers.UserId = demand.CreatorUserId
            where demand.DemandStatus = 0) as [Value]

    union all

    select 'OperationDemand'                             as [Key],
           (select count(*)
            from OP_ThirdPartyRequestQueue queue
                     join @TreeUsers treeusers on treeusers.UserId = queue.UserId
            where step in (5, 8)
              and ProcessDate = cast(getdate() as date)) as [Value]

    union all

    select 'RiskLimitCount'   as [Key],
           (select count(distinct request.Id)
            from OP_RiskLimitRequest request with (nolock)
                     join OP_RiskLimitClient client with (nolock) on request.Id = client.RequestId
                     join @TreeUsers treeusers on treeusers.UserId = request.CreatedUserId
            where Status = 0) as [Value]
end