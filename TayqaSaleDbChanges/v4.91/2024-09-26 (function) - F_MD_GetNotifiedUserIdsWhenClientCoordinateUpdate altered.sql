ALTER function [dbo].[F_MD_GetNotifiedUserIdsWhenClientCoordinateUpdate](@firm smallint, @clientIds nvarchar(max), @currentUserId bigint)
    returns table
        as
        return
        select PermittedClients.Firm     as Firm,
               cast(PermittedClients.UserId as int)   as UserId,
               PermittedClients.ClientId as ClientId
        from F_GetAllPermittedClient() PermittedClients
                 join F_SplitList(@clientIds, ',') UpdatedClients on PermittedClients.ClientId = UpdatedClients.Value
        where PermittedClients.Firm = @firm