CREATE FUNCTION [dbo].[F_IM_GetWarehouseRepairTasks](@firm smallint, @beginDate datetime, @endDate datetime, @userId int)
    RETURNS Table
        AS
        RETURN
            (
                SELECT Task.Id                                             as Id,
                       Inventory.RegistrationNr                            as RegistrationNr,
                       Item.Code                                           as ItemCode,
                       Item.Name                                           as ItemName,
                       Task.CreationTime                                   as CreatedDate,
                       Demand.Note                                         as CreatedUserNote,
                       Task.AssignedUserId                                 as AssignedUserId,
                       CAST(Task.Status as tinyint)                        as Status,
                       CAST(Task.Priority as bit)                          as ImportantStatus,
                       CAST(Warehouse.Nr as tinyint)                       as WarehouseNr,
                       Warehouse.Name                                      as WarehouseName,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_WarehouseRepairAttachment
                        WHERE ReferenceId = Demand.Id
                          AND Type = 1)                                    as Images,
                       (SELECT '[' + STRING_AGG(CONVERT(nvarchar, IssueId), ',') + ']'
                        FROM IM_WarehouseRepairIssue RI
                        WHERE RI.DemandId = Demand.Id)                     as Issues,
                       Task.ReasonId                                       as OperationResultReasonId,
                       coalesce(Task.ConfirmationNote, Task.RejectionNote) as OperationResultNote,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_WarehouseRepairAttachment
                        WHERE ReferenceId = Demand.Id
                          AND Type = 3)                                    as OperationResultImages,
                       CAST(IIF((SELECT COUNT(Id)
                                 FROM IM_WarehouseRepairConsumption
                                 WHERE TaskId = Task.Id
                                   AND Status = 1) > 0,
                                1, 0) as bit)                              as OperationResultPartUsed,
                       Task.Note                                           as AssignerUserNote
                FROM IM_WarehouseRepairTask Task WITH (NOLOCK)
                         JOIN IM_WarehouseRepairDemand Demand WITH (NOLOCK) ON Task.DemandId = Demand.Id
                         JOIN IM_Inventory Inventory WITH (NOLOCK)
                              ON Demand.InventoryId = Inventory.Id and Inventory.Firm = Demand.Firm
                         JOIN Md_Item Item WITH (NOLOCK) ON Item.TigerId = Inventory.TigerId and Item.Firm = Demand.Firm
                         JOIN MD_Warehouse Warehouse WITH (NOLOCK)
                              ON Warehouse.Nr = Demand.WarehouseNr and Warehouse.Firm = Demand.Firm
                WHERE Demand.Firm = @firm
                  AND Task.AssignedUserId = @UserId
                  AND CAST(Task.CreationTime as date) BETWEEN @beginDate AND @endDate
            )