alter proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint, -- See: SYS_UserActionType table
    @latitude float = null,
    @longitude float = null
)
    WITH RECOMPILE
as
begin

    -- ===========================================================Shamfi kontrolu===========================================================================================
    --declare @TaskId int = 6508
    --if @clientId not in (select ClientId from Spec_ClientDataForWpm w
    --left join WPM_Task t on t. Id = w. TaskId
    --where TaskId=@TaskId)
    --       and @userActionType = 32
    --	and @userId=545
    --       begin
    --           select N'Müştəri rutda yoxdu' as [Key],
    --                  N'Müştəri rutda yoxdu' as Value
    --           return;
    --       end

    -- ===========================================================Shamfi kontrolu===========================================================================================

    --declare @MonthHalf tinyint = 1
    --declare @FirstDayOfMonth date = dateadd(month, datediff(month, 0, getdate()), 0)
    --declare @MiddleOfMonth date = datefromparts(year(getdate()), month(getdate()), 15)

    --if cast(getdate() as date) > @MiddleOfMonth
    --    set @MonthHalf = 2

    declare @MandatoryTaskCount int = (select count(Task.Id)
                                       from WPM_Task Task with (nolock)
                                                join WPM_UserTask Users with (nolock) on Users.TaskId = Task.Id
                                                join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Task.Id
                                                join WPM_TaskClient Client with (nolock) on Client.TaskId = Task.Id
                                                left join WPM_TaskTicket Tickets with (nolock)
                                                          on Tickets.UserId = @userId and Tickets.ClientId = @clientId and Tickets.TaskId = Task.Id and
                                                             Tickets.Firm = Task.Firm
                                                              and Tickets.FinalizedDate is not null
                                       where Task.Priority = 3
                                         and Users.UserId = @userId
                                         and cast(getdate() as date) between Schedule.StartDate and Schedule.EndDate
                                         and Task.IsDeleted = 0
                                         and Task.Status = 0
                                         and Client.ClientId = @clientId
                                         and Task.Firm = @firm
                                         and Tickets.Id is null)

    if @MandatoryTaskCount > 0
        begin
            select 'MandatoryTaskExists' as [Key],
                   CAST(1 as bit)        as Value,
                   null                  as LinkType,
                   null                  as Link
            return;
        end

--------------------------------------------------------------------------------------------------------------------------------------------------------------
    if
        @userActionType <= 32
        declare @MandatoryRouteTaskCount int = (select count(Task.Id)
                                                from WPM_Task Task with (nolock)
                                                         join WPM_UserTask Users with (nolock) on Users.TaskId = Task.Id
                                                         join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Task.Id
                                                         join MD_Route r
                                                              on r.UserId = users.UserId and r.Firm = @firm and r.TigerClientId = @clientId and r.Date = cast(getdate() as date)
                                                         left join WPM_TaskTicket Tickets with (nolock)
                                                                   on Tickets.UserId = @userId and Tickets.ClientId = @clientId and Tickets.TaskId = Task.Id and
                                                                      Tickets.Firm = Task.Firm and month(Tickets.CreatedDate) = month(getdate()) and
                                                                      year(Tickets.CreatedDate) = year(getdate())
                                                                       --and cast(Tickets. CreatedDate as date) = cast(getdate() as date)
                                                                       and Tickets.FinalizedDate is not null
                                                where Task.Priority = 3
                                                  and Users.UserId = @userId
                                                  and cast(getdate() as date) between Schedule.StartDate and Schedule.EndDate
                                                  and Task.IsDeleted = 0
                                                  and Task.Status = 0
                                                  and Task.ClientListType = 4
                                                  and users.Status = 0
                                                  and Task.Firm = @firm
                                                  and r.TigerClientId = @clientId
                                                  and Tickets.Id is null)

    if @MandatoryRouteTaskCount > 0
        begin
            select 'MandatoryTaskExists' as [Key],
                   CAST(1 as bit)        as Value,
                   null                  as LinkType,
                   null                  as Link
            return;
        end


    ---- rival analysis task check-- 817
    --if exists(select Id
    --          from WPM_UserTask with (nolock)
    --          where TaskId in (817)
    --            and UserId = @userId)
    --    and exists(select * from MD_Route where UserId = @userId and TigerClientId = @clientId and Firm = @firm and Date = cast(getdate() as date))
    --    begin
    --        if cast(getdate() as date) > @MiddleOfMonth
    --            set @MonthHalf = 2

    --        if not exists(select Id
    --                      from WPM_TaskTicket with (nolock)
    --                      where UserId = @userId
    --                        and TaskId in (817)
    --                        and ClientId = @clientId
    --                        and cast(FinalizedDate as date) between
    --                          iif(@MonthHalf = 1, cast(@FirstDayOfMonth as date), @MiddleOfMonth)
    --                          and iif(@MonthHalf = 1, cast(dateadd(day, 1, @MiddleOfMonth) as date), cast(eomonth(getdate()) as date)))
    --            begin
    --                select 'MandatoryTaskExists' as [Key], CAST(1 as bit) as Value
    --                return;
    --            end
    --    end

    --------------------------------------------------------------------------------------------------------------------------------------

    ---- rival analysis task check-- 907
    --if exists(select Id
    --          from WPM_UserTask with (nolock)
    --          where TaskId in (907)
    --            and UserId = @userId)
    --    and exists(select * from MD_Route where UserId = @userId and TigerClientId = @clientId and Firm = @firm and Date = cast(getdate() as date))
    --    begin
    --        if cast(getdate() as date) > @MiddleOfMonth
    --            set @MonthHalf = 2

    --        if not exists(select Id
    --                      from WPM_TaskTicket with (nolock)
    --                      where UserId = @userId
    --                        and TaskId in (907)
    --                        and ClientId = @clientId
    --                        and cast(FinalizedDate as date) between
    --                          iif(@MonthHalf = 1, cast(@FirstDayOfMonth as date), @MiddleOfMonth)
    --                          and iif(@MonthHalf = 1, cast(dateadd(day, 1, @MiddleOfMonth) as date), cast(eomonth(getdate()) as date)))
    --            begin
    --                select 'MandatoryTaskExists' as [Key], CAST(1 as bit) as Value
    --                return;
    --            end
    --    end

    ------------------------------------------------istifade olunmur--------------------------------------------------------------------------------------

    --   if exists(select Id
    --            from WPM_UserTask with (nolock)
    --            where 
    --	  --TaskId = 907 and 
    --	  UserId = @userId)
    --and exists(select * from MD_Route where UserId = @userId and TigerClientId = @clientId and Firm = @firm and Date = cast(getdate() as date))

    --      begin
    --          if not exists(select Id
    --                    from WPM_TaskTicket with (nolock)
    --                    where UserId = @userId
    --                      --and TaskId = 907
    --                      and ClientId = @clientId
    --                      and cast(FinalizedDate as date) = cast(getdate() as date))
    --              begin
    --                  select 'MandatoryTaskExists' as [Key], CAST(1 as bit) as Value
    --                  return;
    --              end
    --      end
    --------------------------------------------------------------------------------------------------------------------------------------


    if @userActionType = 1 and @userId in (select UserId from Spec_VoenUserControl)
        begin
            if @clientId not in (select b.TigerId
                                 from Spec_ClientControl a with (nolock)
                                          join MD_Client b with (nolock) on a.ClientCode = b.Code and b.Firm = @firm)
                begin
                    declare @VoenVisitCount int = (select count(*)
                                                   from dbo.OP_ClientVisitLog
                                                   where ReasonId = 292
                                                     and ClientId = @clientId
                                                     and CreatedUserId = @userId
                                                     and isnumeric(Subject) = 1
                                                     and Date >= dateadd(month, datediff(month, 0, getdate()), 0))
                    if @VoenVisitCount = 0
                        select 'NoVoenVisit'                                                             as [Key],
                               N'Ziyarət əməliyyatı ilə müştəri VÖEN nömrəsini yeniləyin və şəkil çəkin' as Value,
                               null                                                                      as LinkType,
                               null                                                                      as Link
                end
        end

    if @userActionType = 1
        begin
            declare @OperationCount int = (select count(*)
                                           from OP_IncomingLog with (nolock)
                                           where ClientId = @clientId
                                             and UserId = @userId
                                             and Firm = @firm
                                             and DocType = @docType
                                             and ProcessDate = cast(getdate() as date))
            if @OperationCount > 0
                select 'IgnoreGPSRestriction' as [Key],
                       cast(1 as bit)         as Value,
                       null                   as LinkType,
                       null                   as Link
            return
        end
--------------------------------------------------------------------------------------------------------------
    if @userActionType in (1, 2)
        begin
            with Route as (select * from MD_Route with (nolock) where Status = 0 and Date = cast(GETDATE() as date) and @userId = UserId),
                 Client as (Select * from F_GetAllPermittedClient() client where UserId = @userId),
                 data as (select Client.ClientId as ClientId
                          from Client with (nolock)
                                   left join Route with (nolock)
                                             on Client.UserId = route.UserId and route.TigerClientId = client.ClientId and route.Firm = client.Firm
                          where route.Date is null

                          union

                          select ClientId
                          from OP_ClientVisitLog visit with (nolock)
                                   join Route with (nolock) on cast(visit.Date as date) = route.Date and visit.ClientId = route.TigerClientId and
                                                               visit.CreatedUserId = route.UserId and route.Status = 0 and route.Firm = visit.Firm)

            select N'Visit First'                                              as [Key],
                   N'Ziyaret olunmamis musteriye sened yazmaga icaze verilmir' as [Value],
                   null                                                        as LinkType,
                   null                                                        as Link
            where @clientId not in (select ClientId from data)
        end

end

go
