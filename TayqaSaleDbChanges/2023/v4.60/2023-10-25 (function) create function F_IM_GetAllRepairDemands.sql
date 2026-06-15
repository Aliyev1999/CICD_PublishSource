CREATE function [dbo].[F_IM_GetAllRepairDemands](@firm smallint, @beginDate datetime null, @endDate datetime null, @userId int)
    RETURNS Table
        AS
        RETURN
            (
                select Demands.Id                                                  as Id,
                       Inventory.RegistrationNr                                    as RegistrationNr,
                       Demands.Firm                                                as Firm,
                       Items.Code                                                  as ItemCode,
                       Items.Name                                                  as ItemName,
                       Demands.CreationTime                                        as CreatedDate,
                       (Users.Name + ' ' + Users.Surname)                          as CreatorUserFullName,
                       cast(Demands.Status as tinyint)                             as Status,
                       Clients.TigerId                                             as ClientId,
                       (SELECT '[' + STRING_AGG(CONVERT(nvarchar, IssueId), ',') + ']'
                        FROM IM_RepairIssue
                        WHERE DemandId = Demands.Id)                               as Issues,
                       (SELECT json_query('[' + STRING_AGG('"' + REPLACE(SecureUrl, '\', '\\') + '"', ',') + ']')
                        FROM IM_RepairAttachment
                        WHERE ReferenceId = Demands.Id
                          AND Type = 1)                                            as Files,
                       coalesce(ConfirmingUser.UserName, RejectedUser.UserName)    as FeedbackUserName,
                       Coalesce(Demands.ConfirmationTime, Demands.RejectionTime)   as FeedbackDate,
                       RejectReasonId                                              as FeedbackReason,
                       coalesce(ConfirmedUserDescription, RejectedUserDescription) as FeedbackNote,
                       Demands.Note                                                   as AssignerUserNote
                from IM_RepairDemand Demands with (nolock)

                         JOIN AbpUsers Users WITH (NOLOCK) ON Demands.CreatorUserId = Users.Id
                         join IM_Inventory Inventory with (nolock) on Inventory.Id = Demands.InventoryId
                         join MD_Item Items with (nolock)
                              on Items.TigerId = Inventory.TigerId and Items.Firm = Inventory.Firm
                         join MD_Client Clients with (nolock)
                              on Clients.TigerId = Demands.ClientId and Clients.Firm = Demands.Firm
                         left join F_UIM_GetOrganizationTreeUsers(@userId) usr on usr.UserId = Demands.CreatorUserId
                         left join AbpUsers ConfirmingUser with (nolock)
                                   on ConfirmingUser.Id = Demands.ConfirmingUserId and ConfirmingUser.IsDeleted = 0
                         left join AbpUsers RejectedUser with (nolock)
                                   on RejectedUser.Id = Demands.RejectedUserId and RejectedUser.IsDeleted = 0
                         left join IM_RepairTask task with (nolock) on Demands.Id = task.DemandId
                where Demands.Firm = @Firm
                  and cast(Demands.CreationTime as date) between cast(@beginDate as date) and cast(@endDate as date)
				  and Demands.CreatorUserId	 = @userId
            )