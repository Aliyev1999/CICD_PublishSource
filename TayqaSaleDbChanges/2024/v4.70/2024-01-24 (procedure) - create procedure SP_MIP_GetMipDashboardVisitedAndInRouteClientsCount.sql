CREATE  PROCEDURE [dbo].[SP_MIP_GetMipDashboardVisitedAndInRouteClientsCount](@userId bigint)
AS
BEGIN

 DECLARE @sql nvarchar(max);
 SET @sql ='
with RouteData as (select Route.TigerClientId,
                          Route.Firm,
                          Route.UserId as UserId,
                          Route.Date   as Date
                   from MD_Route Route with (nolock)
                   where Route.Date = cast(getdate() as date)
                     and Status = 0),
     Visits as (select Ticket.Firm,
                       Ticket.ClientId,
                       Ticket.UserId,
                       cast(Ticket.CreatedDate as date) as Date
                from WPM_TaskTicket Ticket with (nolock)
                where Ticket.IsCompleted = 1
                  and cast(Ticket.CreatedDate as date) = cast(GETDATE() as date)

                union

                select Firm,
                       ClientId,
                       CreatedUserId             as UserId,
                       cast(CreatedDate as date) as Date
                from OP_ClientVisitLog
                where cast(Date as date) = cast(getdate() as date)

                union

                select Firm,
                       ClientId,
                       UserId,
                       cast(DocCreatedTime as date) as Date
                from OP_IncomingLog Ilog with (nolock)
                         join OP_GeneralLog Glog with (nolock) on Ilog.Id = Glog.RequestId and Glog.ImportResult = 0
                where ProcessDate = cast(getdate() as date))

select count(distinct Visits.ClientId)           as VisitedClientsCount,
       count(distinct RouteData.TigerClientId)   as InRouteClientsCount
from RouteData
	     join AbpUsers Users with(nolock) on Users.Id=RouteData.UserId
         left join Visits on RouteData.TigerClientId = Visits.ClientId and RouteData.Firm = Visits.Firm'

	 IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON RouteData.UserId = otu.UserId');
        END

    SET @sql = CONCAT(@sql, ' WHERE Users.Name NOT LIKE ''service_user%'' AND  Users.IsDeleted = 0 AND Users.Id != 1')
	print @sql
execute sp_executesql @sql,
            N' @userId bigint',
            @userId=@userId
END