CREATE OR ALTER    function [dbo].[FN_MGM_GetInventoryDemands](
    @userId int,
    @beginDate datetime,
    @endDate datetime,
    @isCompleted bit
    )
    returns table
        as
        return(
		
		       select top 100000 
					  demand.Id                                          as Id,
                      concat(creatoruser.Name, ' ', creatoruser.Surname) as CreatorName,
                      Photo.SecureUrl                                    as CreatorPhoto,
                      demand.DemandType                                  as DemandType,
                      client.Name                                        as ClientName,
                      client.Code                                        as ClientCode,
                      item.Name                                          as ItemName,
                      item.Code                                          as ItemCode,
                      demand.CreationTime                                as Date,
                      content.Name                                       as Reason,
                      demand.Description                                 as Note,
                      demandimage.Id                                     as ImageId,
                      demandimage.SecureUrl                              as ImageUrl,
                      case
                          when @isCompleted = 1 then
                              coalesce(
                                      nullif(concat(cancelleduser.Name, ' ', cancelleduser.Surname), ' '),
                                      nullif(concat(completeduser.Name, ' ', completeduser.Surname), ' '),
                                      nullif(concat(confirmeduser2.Name, ' ', confirmeduser2.Surname), ' '),
                                      nullif(concat(confirmeduser.Name, ' ', confirmeduser.Surname), ' '),
                                      nullif(concat(rejecteduser2.Name, ' ', rejecteduser2.Surname), ' '),
                                      nullif(concat(rejecteduser.Name, ' ', rejecteduser.Surname), ' ')
                              )
                          end                                            as CommentName,
                      case
                          when @isCompleted = 1 then coalesce(demand.CancelledDate,demand.RejectedDate2, demand.RejectedDate, demand.CompletedDate,demand.ConfirmedDate2, demand.ConfirmedDate)
                          else null
                          end                                            as CommentDate,
                      case
                          when demand.DemandStatus = 0 then 0
                          when demand.DemandStatus in (2, 5) then 2
                          else 1
                          end                                            as CommentStatus

               from IM_InventoryDemand demand with (nolock)
                        join AbpUsers creatoruser with (nolock) on demand.CreatorUserId = creatoruser.Id
                        join MD_Client client with (nolock) on client.TigerId = demand.ClientTigerId and client.Firm = demand.Firm
                        join MD_Item item with (nolock) on item.TigerId = demand.ItemTigerId and item.Firm = demand.Firm
                        join F_GetPermittedUsers(@userId) permittedusers on permittedusers.UserId = creatoruser.Id
                        left join IM_StaticContent content with (nolock) on content.Id = demand.InventoryDemandReasonId and Type in(1,2)
                        left join AbpUsers confirmeduser with (nolock) on demand.ConfirmedUserId = confirmeduser.Id
                        left join AbpUsers rejecteduser with (nolock) on demand.RejectedUserId = rejecteduser.Id
                        left join AbpUsers confirmeduser2 with (nolock) on demand.ConfirmedUserId2 = confirmeduser2.Id
                        left join AbpUsers rejecteduser2 with (nolock) on demand.RejectedUserId2 = rejecteduser2.Id
                        left join AbpUsers cancelleduser with (nolock) on demand.CancelledUserId = cancelleduser.Id
                        left join AbpUsers completeduser with (nolock) on demand.CompletedUserId = cancelleduser.Id
                        left join AbpUserProfilePhoto Photo with (nolock) on Photo.UserId = creatoruser.Id
                        left join IM_InventoryDemandImage demandimage with (nolock) on demandimage.InventoryDemandId = demand.Id

               where ((@isCompleted = 0 and DemandStatus = 0)
                   or (@isCompleted = 1 and DemandStatus in (1, 2, 3, 4, 5)))
                   and ((@beginDate is null or  @endDate is null ) or demand.CreationTime between @beginDate and @endDate)
				   order by demand.CreationTime desc
				   )

		