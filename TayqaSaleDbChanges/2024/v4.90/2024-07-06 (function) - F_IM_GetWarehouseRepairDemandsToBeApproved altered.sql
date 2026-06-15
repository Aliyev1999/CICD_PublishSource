ALTER function [dbo].[F_IM_GetWarehouseRepairDemandsToBeApproved](@firm int, @beginDate datetime null,
                                                                   @endDate datetime null, @userId int)
    RETURNS Table
        AS
        RETURN
            (
                select Demands.Id                                               as Id,
                       task.Id                                                  as TaskId,
                       (Users.Name + ' ' + Users.Surname)                       as CreatorUserFullName,
                       Inventory.RegistrationNr                                 as RegistrationNr,
                       Items.Code                                               as ItemCode,
                       Items.Name                                               as ItemName,
                       Demands.CreationTime                                     as CreatedDate,
                       Demands.Note                                             as CreatedUserNote,
                       cast(task.Status as tinyint)                             as Status,
                       cast(Warehouse.Nr as tinyint)                            as WarehouseNr,
                       Warehouse.Name                                           as WarehouseName,
                       coalesce(ConfirmingUser.UserName, RejectedUser.UserName) as FeedbackUserName,
                       Coalesce(task.ConfirmationDate, task.RejectionDate)      as FeedbackDate,
                       task.ReasonId                                            as FeedbackReason,
                       coalesce(task.ConfirmationNote, task.RejectionNote)      as FeedbackNote,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_WarehouseRepairAttachment
                        WHERE ReferenceId = Demands.Id
                          AND Type = 1)                                         as Files,
						(SELECT '[' + STRING_AGG(CONVERT(nvarchar, IssueId), ',') + ']'
						FROM IM_WarehouseRepairIssue
						WHERE DemandId = Demands.Id)							   as Issues,
						(SELECT '[' + STRING_AGG('{"IssueId":' + CONVERT(nvarchar, IssueId) + ',"IsResolved":' + 
								CASE 
									WHEN IsResolved = 1 THEN 'true' 
									ELSE 'false' 
								END + '}', ',') + ']'
						FROM IM_WarehouseRepairIssue
                        WHERE DemandId = Demands.Id)                               as IssuesWithResolved

                from IM_WarehouseRepairDemand Demands with (nolock)

                         JOIN AbpUsers Users WITH (NOLOCK) ON Demands.CreatorUserId = Users.Id
                         join IM_Inventory Inventory with (nolock) on Inventory.Id = Demands.InventoryId
                         join MD_Item Items with (nolock)
                              on Items.TigerId = Inventory.TigerId and Items.Firm = Inventory.Firm
                         join MD_Warehouse Warehouse with (nolock)
                              on Warehouse.Nr = Demands.WarehouseNr and Warehouse.Firm = Demands.Firm
                         join IM_WarehouseRepairTask task with (nolock) on Demands.Id = task.DemandId
                         left join F_UIM_GetOrganizationTreeUsers(@userId) usr on usr.UserId = Demands.CreatorUserId
                         left join AbpUsers ConfirmingUser with (nolock)
                                   on ConfirmingUser.Id = task.ConfirmedUserId and ConfirmingUser.IsDeleted = 0
                         left join AbpUsers RejectedUser with (nolock)
                                   on RejectedUser.Id = task.RejectedUserId and RejectedUser.IsDeleted = 0

                where Demands.Firm = @firm
                  and cast(Demands.CreationTime as date) between cast(@beginDate as date) and cast(@endDate as date)
                  and Demands.CreatorUserId = @userId
                  and Demands.Status in (6, 7, 8, 9, 10, 11, 12, 13)
            )
GO
