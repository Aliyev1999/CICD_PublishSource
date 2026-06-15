CREATE FUNCTION [dbo].[F_IM_GetRepairTasks](@firm smallint, @beginDate datetime null, @endDate datetime null, @userId int)
    RETURNS Table
AS
RETURN
(
    SELECT Task.Id                                                                                                        as Id,
           Inventory.RegistrationNr                                                                                       as RegistrationNr,
           Item.Code                                                                                                      as ItemCode,
           Item.Name                                                                                                      as ItemName,
           Task.CreationTime                                                                                              as CreatedDate,
           Demand.Note                                                                                                    as CreatedUserNote,
           Task.AssignedUserId                                                                                            as AssignedUserId,
           CAST(Task.Status as tinyint)                                                                                   as Status,
           Client.Code                                                                                                    as ClientCode,
           Client.Name                                                                                                    as ClientName,
           Client.Edino                                                                                                   as ClientEdino,
		   Client.Longitude                                                                                               as Longitude,
		   Client.Latitude                                                                                                as Latitude,
           CAST(Task.Priority as bit)                                                                                     as ImportantStatus,
           (SELECT '[' + STRING_AGG(CONVERT(nvarchar, IssueId), ',') + ']' FROM IM_RepairIssue RI WHERE RI.DemandId = Demand.Id) as Issues,
           (SELECT json_query('[' + STRING_AGG('"' + REPLACE( SecureUrl,'\','\\') + '"', ',') + ']') FROM IM_RepairAttachment WHERE ReferenceId = Demand.Id AND Type = 1) as Images,
           Task.ReasonId                                                                                                  as OperationResultReasonId,
           Task.Note                                                                                                    as AssignerUserNote,
           coalesce(Task.ConfirmationNote, Task.RejectionNote)                                                            as OperationResultNote,
           (SELECT json_query('[' + STRING_AGG('"' + REPLACE( SecureUrl,'\','\\') + '"', ',') + ']') FROM IM_RepairAttachment WHERE ReferenceId = Demand.Id AND Type = 3) as OperationResultImages,
           CAST(IIF((SELECT COUNT(Id) FROM IM_RepairConsumption WHERE TaskId = Task.Id AND Status = 1) > 0, 1, 0) as bit) as OperationResultPartUsed
    FROM IM_RepairTask Task WITH (NOLOCK)
         JOIN IM_RepairDemand Demand WITH (NOLOCK) ON Task.DemandId = Demand.Id
         JOIN IM_Inventory Inventory WITH (NOLOCK) ON Demand.InventoryId = Inventory.Id
         JOIN Md_Item Item WITH (NOLOCK) ON Item.TigerId = Inventory.TigerId --and Item.CardType=4
         JOIN MD_Client Client WITH (NOLOCK) ON Client.TigerId = Demand.ClientId
    WHERE @Firm = Demand.Firm AND Task.AssignedUserId = @UserId
          AND CAST(Task.CreationTime as date) BETWEEN @beginDate AND @endDate
)