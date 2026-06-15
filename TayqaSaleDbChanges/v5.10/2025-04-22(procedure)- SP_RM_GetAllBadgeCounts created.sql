CREATE OR ALTER PROCEDURE [dbo].[SP_RM_GetAllBadgeCounts] @userId INT,
                                                @firm SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    WITH tasks AS (SELECT DISTINCT u.TaskId, UserId
                   FROM WPM_UserTask u WITH (NOLOCK)
                            JOIN WPM_TaskSchedule s WITH (NOLOCK)
                                 ON s.TaskId = u.TaskId AND s.Status = 0 AND u.Status = 0
                            JOIN WPM_Task t WITH (NOLOCK)
                                 ON t.Id = s.TaskId AND t.Status = 0 AND t.IsDeleted = 0
                   WHERE UserId = @userId
                     AND CAST(s.StartDate AS DATE) <= CAST(GETDATE() AS DATE)
                     AND CAST(s.EndDate AS DATE) >= CAST(GETDATE() AS DATE)
                     AND t.Type = 1)

    SELECT 'NotStartedTaskCount' AS [Key],
           (SELECT COUNT(*)
            FROM tasks
                     LEFT JOIN WPM_TaskTicket t ON t.UserId = tasks.UserId AND t.TaskId = tasks.TaskId
            WHERE t.Id IS NULL)  AS [Value]
    UNION ALL
    SELECT 'RepairTaskCount',
           (SELECT COUNT(*)
            FROM IM_RepairTask task WITH (NOLOCK)
                     JOIN IM_RepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
            WHERE AssignedUserId = @userId
              AND Demand.Firm = @firm
              AND task.Status IN (5, 6, 7, 12)
              AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'RepairExecutionCount',
           (SELECT COUNT(*)
            FROM IM_RepairTask task WITH (NOLOCK)
                     JOIN IM_RepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
            WHERE Demand.CreatorUserId = @userId
              AND Firm = @firm
              AND task.Status IN (9, 10)
              AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'WarehouseNotStartedTaskCount',
           (SELECT COUNT(*)
            FROM IM_WarehouseRepairTask task WITH (NOLOCK)
                     JOIN IM_WarehouseRepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
            WHERE AssignedUserId = @userId
              AND Demand.Firm = @firm
              AND task.Status = 5
              AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'WarehouseRepairTaskCount',
           (SELECT COUNT(*)
            FROM IM_WarehouseRepairTask task WITH (NOLOCK)
                     JOIN IM_WarehouseRepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
            WHERE AssignedUserId = @userId
              AND Demand.Firm = @firm
              AND task.Status IN (5, 6, 7, 12)
              AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'WarehouseRepairExecutionCount',
           (SELECT COUNT(*)
            FROM IM_WarehouseRepairTask task WITH (NOLOCK)
                     JOIN IM_WarehouseRepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
            WHERE Demand.CreatorUserId = @userId
              AND Firm = @firm
              AND task.Status = 9
              AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'PendingInventoryRequestsCount',
           (SELECT COUNT(*)
            FROM IM_InventoryDemand Demand WITH (NOLOCK)
            WHERE Demand.CreatorUserId = @userId
              AND Demand.Firm = @firm
              AND Demand.DemandStatus = 0
              AND Demand.CreationTime >= DATEADD(DAY, -30, GETDATE()))
    UNION ALL
    SELECT 'AssetBindingCount',
           (SELECT COUNT(*)
            FROM IM_AssetBinding
            WHERE AssignedUserId = @userId
              AND Firm = @firm
              AND Status = 1)
    UNION ALL
    SELECT 'ThirdPartyDocCount',
           (SELECT COUNT(*)
            FROM OP_ThirdPartyRequestQueue Queue
                     JOIN AbpUsers Users WITH (NOLOCK) ON Users.Id = Queue.UserId
                     JOIN F_UIM_GetOrganizationTreeUsers(@userId) ou ON ou.UserId = Users.Id
            WHERE Firm = @firm
              AND Step IN (5, 8)
              AND ProcessDate = CAST(GETDATE() AS DATE))
    UNION ALL
    SELECT 'ActiveTransportPackageCount',
           (SELECT COUNT(DISTINCT p.Id)
            FROM IM_InventoryTransportPackage p
                     INNER JOIN IM_TransportPackageTransferDemandMapping tdm ON p.Id = tdm.TransportPackageId
                     INNER JOIN IM_TransferDemand td ON tdm.TransferDemandId = td.Id
            WHERE p.PackageStatus NOT IN (0, 3)
              AND p.PackageDemandType = 2
              AND p.DriverUserId = @userId)
    UNION ALL
    SELECT 'RiskLimitsCount',
           (select count(distinct Request.Id)
		   from OP_RiskLimitRequest request with (nolock)
				join OP_RiskLimitClient client with (nolock ) on request.Id=client.RequestId
			where CreatedUserId in (select UserId from F_UIM_GetOrganizationTreeUsers(@userId) )
				and Status=0 and firm=@firm
);
END
go