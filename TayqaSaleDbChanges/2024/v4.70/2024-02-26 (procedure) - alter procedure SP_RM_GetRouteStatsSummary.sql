
ALTER procedure [dbo].[SP_RM_GetRouteStatsSummary](@beginDate datetime, @endDate datetime, @userId int)
AS
BEGIN

    -- Description: Query is written by TayqaTech for TayqaSale on 25.05.2022 (Shahri Yahyayeva)
    -- Return: Route statistics for tree users of the logged in user
    -- Ticket: TSC-3592

    -- Last modified by Kanan Mammadov to fix count issues

    with Routes as (select UserId, Date, TigerClientId as ClientId, Firm
                    from MD_Route with (nolock)
                    where Date between @beginDate and @endDate),

         Sales as (select distinct Firm, ILog.UserId, ClientId as ClientId, ProcessDate as Date
                   from OP_IncomingLog ILog with (nolock)
                            join OP_GeneralLog GLog with (nolock) on GLog.RequestId = ILog.Id and GLog.ImportResult = 0
                   where ILog.DocType < 20
                     and ProcessDate between cast(@beginDate as date) and cast(@endDate as date)

                   union

                   select distinct Firm, Visits.CreatedUserId as UserId, ClientId, cast(CreatedDate as date) as Date
                   from OP_ClientVisitLog Visits with (nolock)
                   where cast(CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                   union

                   select distinct Firm, UserId, ClientId, cast(CreatedDate as date) as Date
                   from WPM_TaskTicket with (nolock)
                     where cast(CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)),


         OnlySales as (--select distinct Ilog.Firm,  Ilog.UserId,  Ilog.ClientId, Ilog.ProcessDate as Date
             --                  from OP_IncomingLog ILog with (nolock)
             --                           join OP_GeneralLog GLog with (nolock)
             --                                on ILog.Id = GLog.RequestId and GLog.ImportResult = 0
             --                  where ILog.ProcessDate between @beginDate and @endDate
             --                    and ILog.DocType in (0, 3, 4)

             --			union all

             select distinct Tickets.Firm, Tickets.UserId, Tickets.ClientId, Cast(Files.CreatedDate as Date) as Date
             from WPM_Attachment Files

                      join WPM_TaskTicketAction Reference on Files.ReferenceId = reference.Id
                      join WPM_TaskTicket Tickets on Tickets.Id = Reference.TaskTicketId

             where cast(Files.CreatedDate as date) between @beginDate and @endDate
               and Files.Type = 3

             union

             select distinct Response.Firm, Response.UserId, Response.ClientId, Cast(Response.CreatedDate as date) as Date
             from CHL_Attachment Files with (nolock)
                      join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                      join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
             where Files.Type = 3
               and cast(Files.CreatedDate as date) between @beginDate and @endDate


             union
             select distinct UploadFiles.Firm, UploadFiles.UploadedUserId, Client.TigerId, CAST(UploadFiles.FileCreatedDate as Date) as Date

             from OP_FileUploadLog UploadFiles with (nolock)
                      join MD_Client Client with (nolock) on Client.TigerId = UploadFiles.ClientId and Client.Firm = UploadFiles.Firm
             where ContentType in (1, 2)
               and cast(UploadFiles.FileCreatedDate as date) between @beginDate and @endDate),

         Results as (select coalesce(Routes.UserId, Sales.UserId, OnlySales.UserId)                          as UserID,
                            sum(iif(Routes.ClientId is not null, 1, 0))                                      as RouteClientCount,
                            sum(iif(Routes.ClientId is not null and (Sales.ClientId is not null), 1, 0))     as VisitedRouteClientCount,
                            sum(iif(Routes.ClientId is null and Sales.ClientId is not null, 1, 0))           as VisitedNonRouteClientCount,
                            sum(iif(Routes.ClientId is not null and (OnlySales.ClientId is not null), 1, 0)) as SalesRouteClientCount,
                            sum(iif(Routes.ClientId is null and (OnlySales.ClientId is not null), 1, 0))     as SalesNonRouteClientCount
                     from Routes
                              full outer join Sales on Routes.ClientId = Sales.ClientId and Routes.Date = Sales.Date and
                                                       Routes.Firm = Sales.Firm and Routes.UserId = Sales.UserId
                              full outer join OnlySales
                                              on Routes.ClientId = OnlySales.ClientId and Routes.Date = OnlySales.Date and
                                                 Routes.Firm = OnlySales.Firm and Routes.UserId = OnlySales.UserId

                     group by coalesce(Routes.UserId, Sales.UserId, OnlySales.UserId))
    select Results.UserID             as UserID,
           RouteClientCount           as RouteClientCount,
           VisitedRouteClientCount    as VisitedRouteClientCount,
           VisitedNonRouteClientCount as VisitedNonRouteClientCount,
           SalesRouteClientCount      as SalesRouteClientCount,
           SalesNonRouteClientCount   as SalesNonRouteClientCount
    from Results
             join F_UIM_GetOrganizationTreeUsers(@userId) on Results.UserID = F_UIM_GetOrganizationTreeUsers.UserId
END