CREATE OR ALTER  FUNCTION [dbo].[F_MGM_GetVisitCount](@userId int, @Date date)
    Returns Table
        AS
        RETURN
            (
with Routes as (select distinct Routes.UserId, Routes.TigerClientId as ClientId, Routes.Date as Date, Routes.Firm as Firm
                from MD_Route Routes with (nolock)
                         
                where UserId =@userId and Routes.Date = @Date 
				and Routes.Status=0),

     Actions as (select distinct Ticket.UserId                    as UserId,
                                 Ticket.ClientId                  as ClientId,
                                 cast(Ticket.CreatedDate as date) as Date,
                                 Ticket.Firm                      as Firm
                 from WPM_TaskTicket Ticket with (nolock)
                          join WPM_Task Task with (nolock) on Task.Id = Ticket.TaskId
                          
                 where  Ticket.UserId =@userId
                   and cast(Ticket.CreatedDate as date)= @Date  
                 union all
                 select distinct Visit.CreatedUserId             as UserId,
                                 Visit.ClientId                  as ClientId,
                                 cast(Visit.CreatedDate as date) as Date,
                                 Visit.Firm                      as Firm
                 from OP_ClientVisitLog Visit with (nolock)
                          
                 where Visit.CreatedUserId=@userId and  cast(Date as date)= @Date 
				 union all
				  select distinct Visit.UserId             as UserId,
                                 Visit.ClientId                  as ClientId,
                                 cast(Visit.DocCreatedTime as date) as Date,
                                 Visit.Firm                      as Firm
                 from OP_IncomingLog Visit with (nolock)
                          
                 where Visit.UserId=@userId and  cast(DocCreatedTime as date) = @Date

				 union all

				 select distinct UserSurveyResponse.UserId             as UserId,
                                 UserSurveyResponse.ClientId                  as ClientId,
                                 cast(UserSurveyResponse.CreatedDate as date) as Date,
                                 UserSurveyResponse.Firm                      as Firm 
			    from CHL_UserSurveyResponse as UserSurveyResponse with (nolock)
				where UserSurveyResponse.UserId=@userId and cast(UserSurveyResponse.CreatedDate as date)=@Date
),

     Result as (select coalesce(Routes.UserId, Actions.UserId)                             as UserId,
					   coalesce(routes.ClientId,Actions.ClientId)                          as ClientId,
                       iif(Routes.UserId is not null, 1, 0)                                as IsRoute,
                       iif(Routes.UserId is not null and Actions.UserId is not null, 1, 0) as IsRouteVisit,
                       iif(Routes.UserId is null and Actions.UserId is not null, 1, 0)     as IsNonRouteVisit,
					   iif(Routes.UserId is not null and Actions.UserId is null, 1, 0)     as IsRouteNoVisit


                from Routes
                         full outer join Actions on Actions.UserId = Routes.UserId  and Routes.ClientId = Actions.ClientId and
                                                    Actions.Firm = Routes.Firm)


SELECT UserId,
	   ClientId,
       SUM(IsRoute)         AS TotalRoutes,
       SUM(IsRouteVisit)    AS TotalRouteVisits,
       SUM(IsNonRouteVisit) AS TotalNonRouteVisits,
       case
           when IsRouteVisit = 1 then 0
           when IsNonRouteVisit = 1 then 1
           when IsRouteNoVisit=1 then 2
           end              AS RouteStatus
FROM Result
GROUP BY UserId,       case
           when IsRouteVisit = 1 then 0
           when IsNonRouteVisit = 1 then 1
           when IsRouteNoVisit=1 then 2
           end  ,ClientId           
            )



