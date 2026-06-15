CREATE Procedure [dbo].[SP_RM_GetUsersAuditOperations] @currentUserId Int,
                                                      @beginDate DateTime,
                                                      @endDate DateTime,
                                                      @firm SmallInt
As

-- Author: TayqaTech for TayqaSale (Shahri Yahyayeva)
-- Date: 01.03.2022 
-- Query: returns the result of hybrid user's report for audit operations


Begin
    select users.UserName                            as UserName,
           concat(users.Name, ' ', users.Surname)    as UserFullName,
           operation.CreatedUserId                   as UserId,
           count(operation.Id)                       as CheckedClientsCount,
           sum(iif(operation.IsConfirmed = 1, 1, 0)) as ConfirmedCount,
           sum(iif(operation.IsConfirmed = 0, 1, 0)) as UnConfirmedCount
    from AO_AuditOperation operation with (nolock)
             join AbpUsers users with (nolock) on operation.CreatedUserId = users.Id and users.IsActive = 1 and users.IsDeleted = 0
             join F_UIM_GetOrganizationTreeUsers(@currentUserId) treeusers on treeusers.UserId = operation.CreatedUserId
    where operation.IsDeleted = 0
      and operation.Firm = @firm
      and operation.CreatedDate between @beginDate and @endDate
    group by users.UserName, concat(users.Name, ' ', users.Surname), operation.CreatedUserId

end