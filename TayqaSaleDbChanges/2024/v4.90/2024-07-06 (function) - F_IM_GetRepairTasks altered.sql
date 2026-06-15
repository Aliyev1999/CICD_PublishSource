ALTER   FUNCTION [dbo].[F_IM_GetRepairTasks](@firm smallint, @beginDate datetime null, @endDate datetime null, @userId int)
    RETURNS Table
        AS
        RETURN
            (
                SELECT Task.Id                                                                                                               as Id,
					   Demand.Id																										     as DemandId,
					   Inventory.RegistrationNr                                                                                              as RegistrationNr,
                       Item.Code                                                                                                             as ItemCode,
                       Item.Name                                                                                                             as ItemName,
                       Task.CreationTime                                                                                                     as CreatedDate,
                       Demand.Note                                                                                                           as CreatedUserNote,
                       Task.AssignedUserId                                                                                                   as AssignedUserId,
                       CAST(Task.Status as tinyint)                                                                                          as Status,
                       Client.Code                                                                                                           as ClientCode,
                       Client.Name                                                                                                           as ClientName,
                       Client.Edino                                                                                                          as ClientEdino,
                       Client.Longitude                                                                                                      as Longitude,
                       Client.Latitude                                                                                                       as Latitude,
                       CAST(Task.Priority as bit)                                                                                            as ImportantStatus,
                       (SELECT '[' + STRING_AGG(CONVERT(nvarchar, IssueId), ',') + ']' FROM IM_RepairIssue RI WHERE RI.DemandId = Demand.Id) as Issues,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_RepairAttachment
                        WHERE ReferenceId = Demand.Id AND Type = 1)                                                                          as Images,
                       Task.ReasonId                                                                                                         as OperationResultReasonId,
                       Task.Note                                                                                                             as AssignerUserNote,
                       coalesce(Task.ConfirmationNote, Task.RejectionNote)                                                                   as OperationResultNote,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_RepairAttachment
                        WHERE ReferenceId = Demand.Id
                          AND Type = 3)                                                                                                      as OperationResultImages,
					   CASE
						  WHEN Demand.Status IN (5, 12) THEN
							   (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
								FROM IM_RepairAttachment
								WHERE ReferenceId = Demand.Id AND Type = 1)
						  ELSE NULL
					   END																													 as ConsumptionImages,
                       CAST(IIF((SELECT COUNT(Id) FROM IM_RepairConsumption WHERE TaskId = Task.Id AND Status = 1) > 0, 1, 0) as bit)        as OperationResultPartUsed,
						CreatorUser.UserName																						         as CreatorUsername,
						CreatorUser.Name + ' ' + CreatorUser.Surname																		 as CreatorUserFullName,
						CreatorUser.PhoneNumber																						         as CreatorUserPhoneNumber,
						CASE 
							WHEN Demand.Status IN (5, 12) THEN RepairerUser.Name + ' ' + RepairerUser.Surname 
							ELSE NULL 
						END                                                                                                                  as UserFullName,
						CASE
							WHEN Demand.Status IN (5, 12) THEN task.RepairResultDate
							ELSE NULL
						END																													 as Date,
						(select top(1) RejectionNote from (select top(2) * from IM_RepairTask where DemandId = Task.DemandId order by Id desc) as t2 order by Id asc) RejectionNote
				FROM IM_RepairTask Task WITH (NOLOCK)
                         JOIN IM_RepairDemand Demand WITH (NOLOCK) ON Task.DemandId = Demand.Id
                         JOIN IM_Inventory Inventory WITH (NOLOCK) ON Demand.InventoryId = Inventory.Id and Inventory.Firm = Demand.Firm
                         JOIN Md_Item Item WITH (NOLOCK) ON Item.TigerId = Inventory.TigerId and Item.Firm = Demand.Firm
                         JOIN MD_Client Client WITH (NOLOCK) ON Client.TigerId = Demand.ClientId and Client.Firm = Demand.Firm
						 JOIN AbpUsers CreatorUser WITH(NOLOCK) ON CreatorUser.Id = Demand.CreatorUserId
						 join AbpUsers RepairerUser WITH(NOLOCK) ON RepairerUser.Id = Task.AssignedUserId
                WHERE Demand.Firm = @firm
                  AND Task.AssignedUserId = @UserId
                  AND CAST(Task.CreationTime as date) BETWEEN @beginDate AND @endDate
            )
GO
