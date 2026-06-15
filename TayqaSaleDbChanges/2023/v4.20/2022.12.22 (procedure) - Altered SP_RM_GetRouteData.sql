ALTER procedure [dbo].[SP_RM_GetRouteData] @userId int,
                                           @firm smallint,
                                           @beginDate datetime,
                                           @endDate datetime,
                                           @viewMode tinyint=1
as
begin

-- Last modified by Kanan Mammadov to enable hierarchy of hybrid user

    with Routes as (select Routes.UserId, TigerClientId as ClientId, Date as Date
                    from MD_Route Routes with (nolock)
                             left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Routes.UserId
                    where (((@viewMode is null or @viewMode = 1) and Routes.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                      and Firm = @firm
                      and Status = 0
                      and Date between cast(@beginDate as date) and cast(@endDate as date)),

         Actions as (select distinct ILog.UserId, ClientId as ClientId, ProcessDate as Date
                     from OP_IncomingLog ILog with (nolock)
                              join OP_GeneralLog GLog with (nolock) on GLog.RequestId = ILog.Id and GLog.ImportResult = 0
                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = ILog.UserId
                     where (((@viewMode is null or @viewMode = 1) and ILog.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                       and Firm = @firm
                       and ILog.DocType < 20
                       and ProcessDate between cast(@beginDate as date) and cast(@endDate as date)

                     union

                     select distinct Visits.CreatedUserId as UserId, ClientId, cast(CreatedDate as date) as Date
                     from OP_ClientVisitLog Visits with (nolock)
                              left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Visits.CreatedUserId
                     where (((@viewMode is null or @viewMode = 1) and Visits.CreatedUserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                       and Firm = @firm
                       and cast(CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date))

    select count(Routes.ClientId)                                                       as Routes,
           sum(iif(Routes.ClientId is not null and Actions.ClientId is not null, 1, 0)) as InRoute,
           sum(iif(Routes.ClientId is null and Actions.ClientId is not null, 1, 0))     as OutRoute
    from Routes
             full join Actions on Routes.Date = Actions.Date and Routes.ClientId = Actions.ClientId and Routes.UserId = Actions.UserId

end