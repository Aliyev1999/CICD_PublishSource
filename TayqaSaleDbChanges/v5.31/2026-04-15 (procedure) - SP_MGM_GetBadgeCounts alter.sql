Create or ALTER PROCEDURE [dbo].[SP_MGM_GetBadgeCounts] @firm Smallint, @userId INT
AS
BEGIN
    SET NOCOUNT ON;


    declare @TreeUsers table
                       (
                           UserId int
                       );

    insert into @TreeUsers (UserId)
    select distinct UserId
    from F_GetPermittedUsers(@userId);


    select 'RouteDemand'               as [Key],
           (select count(*)
            from OP_RouteRequest routes with (nolock)
                     join @TreeUsers treeusers on treeusers.UserId = routes.CreatedUserId
            where routes.Status = 0
              and routes.Firm = @firm) as [Value]

    union all

    select 'InventoryDemand'           as [Key],
           (select count(*)
            from IM_InventoryDemand demand with (nolock)
                     join @TreeUsers treeusers on treeusers.UserId = demand.CreatorUserId
            where demand.DemandStatus = 0
              and demand.Firm = @firm) as [Value]

    union all

    select 'OperationDemand'          as [Key],
           (select count(*)
            from OP_ThirdPartyRequestQueue queue
                     join @TreeUsers treeusers on treeusers.UserId = queue.UserId
            where step in (5, 8)
              and ProcessDate = cast(getdate() as date)
              and queue.Firm = @firm) as [Value]

    union all

    select 'RiskLimitCount'             as [Key],
           (select count(distinct request.Id)
            from OP_RiskLimitRequest request with (nolock)
                     join OP_RiskLimitClient client with (nolock) on request.Id = client.RequestId
                     join @TreeUsers treeusers on treeusers.UserId = request.CreatedUserId
            where Status = 0
              and request.Firm = @firm) as [Value]

    union all

    select 'InventoryClientChangeRequestCount' AS [Key],
           count(distinct Demands.Id)          as [Value]
    from IM_TransferDemand Demands with (nolock)
             join @TreeUsers PermittedUsers on PermittedUsers.UserId = Demands.CreatorUserId
             join IM_Inventory Inventory with (nolock) on Inventory.Id = Demands.InventoryId
             join MD_Client FromClient with (nolock) on FromClient.TigerId = Demands.FromClientId and Inventory.Firm = FromClient.Firm
             join MD_Client ToClient with (nolock) on ToClient.TigerId = Demands.ToClientId and Inventory.Firm = ToClient.Firm
    where Demands.Status = 0
      and Inventory.Firm = @firm
      and FromClient.IsDeleted = 0
      and ToClient.IsDeleted = 0


end