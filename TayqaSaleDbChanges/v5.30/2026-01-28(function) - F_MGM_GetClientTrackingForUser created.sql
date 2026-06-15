CREATE OR ALTER function [dbo].[F_MGM_GetClientTrackingForUser](@UserId int, @Date date)
    returns table as return
        with Route as (select TigerClientId as ClientId
                       from MD_Route with (nolock)
                       where Date = cast(@Date as date)
                         and UserId = @UserId),

             Actions as (
                 -- Is plani ile olan emeliyyatlar
                 select ClientId, min(CreatedDate) as StartTime, max(FinalizedDate) as EndTime
                 from WPM_TaskTicket with (nolock)
                 where cast(CreatedDate as date) = cast(@Date as date)
                   and UserId = @UserId
                 group by ClientId


                 ),

             Times as (select ClientId, min(StartTime) as StartTime, max(EndTime) as EndTime from Actions group by ClientId),

             Result as (select coalesce(Route.ClientId, Actions.ClientId) as ClientId,
                               case
                                   when Route.ClientId is not null and Actions.ClientId is not null then 1 
                                   when Route.ClientId is null and Actions.ClientId is not null then 2 
                                   when Route.ClientId is not null and Actions.ClientId is null then 3 
                                   end                                    as VisitStatus

                        from Route
                                 full outer join Actions
                                                 on Actions.ClientId = Route.ClientId)

        select Client.TigerId   as ClientId,
               Client.Name      as ClientName,
               Client.Code      as ClientCode,
               Times.StartTime  as StartTime,
               Times.EndTime    as EndTime,
               VisitStatus      as RouteStatus,
               Client.Latitude  as Latitude,
               Client.Longitude as Longitude

        from Result
                 join MD_Client Client with (nolock) on Client.TigerId = Result.ClientId and Client.Firm = 9
                 left join Times on Times.ClientId = Client.TigerId