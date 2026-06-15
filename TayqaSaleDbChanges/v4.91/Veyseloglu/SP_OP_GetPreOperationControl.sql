ALTER proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint,
    @latitude FLOAT,
    @longitude FLOAT
)
as
begin

    -- Asagidaki hisseni bilerekden comment etmisik -> Kanan
    --declare @MandatoryTaskCount int = (select count(Task.Id)
    --                                   from WPM_Task Task with (nolock)
    --                                            join WPM_UserTask Users with (nolock) on Users.TaskId = Task.Id
    --                                            join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Task.Id
    --                                            join WPM_TaskClient Client with (nolock) on Client.TaskId = Task.Id
    --                                            left join WPM_TaskTicket Tickets with (nolock)
    --                                                      on Tickets.UserId = @userId and Tickets.ClientId = @clientId and Tickets.TaskId = Task.Id and
    --                                                         Tickets.Firm = Task.Firm
    --                                                          and Tickets.FinalizedDate is not null
    --                                   where Task.Priority = 3
    --                                     and Users.UserId = @userId
    --                                     and cast(getdate() as date) between Schedule.StartDate and Schedule.EndDate
    --                                     and Task.IsDeleted = 0
    --                                     and Task.Status = 0
    --                                     and Client.ClientId = @clientId
    --                                     and Task.Firm = @firm
    --                                     and Tickets.Id is null)

    --if @MandatoryTaskCount > 0
    --    begin
    --        select 'MandatoryTaskExists' as [Key], CAST(1 as bit) as Value
    --        return;
    --    end


    -- TSS-7037
    declare @InProgressExists int = 1
    declare @InProgress table
                        (
                            ClientId int
                        )
    insert into @InProgress (ClientId)
    select Ticket.ClientId
    from WPM_TaskTicket Ticket with (nolock)
             join F_GetPermittedClientForUser(@userId) Permitted on Permitted.ClientId = Ticket.ClientId and Permitted.Firm = Ticket.Firm
    where Ticket.UserId = @userId
      and cast(CreatedDate as date) = cast(getdate() as date)
      and FinalizedDate is null
      and Ticket.ClientId <> @clientId

    if exists(select ClientId from @InProgress Progress)
        and @userActionType = 32
        begin
            select N'İcraatda müştəri mövcuddur, icraatdakı müştərini tamamlayıb növbətisinə keçə bilərsiniz' as [Key],
                   N'İcraatda müştəri mövcuddur, icraatdakı müştərini tamamlayıb növbətisinə keçə bilərsiniz' as Value,
                   null                                                                                       as LinkType,
                   null                                                                                       as Link
            return;
        end


    -- if @docType = 0
    --     begin
    --         declare @OperationCount int = (select count(*)
    --                                        from OP_IncomingLog with (nolock)
    --                                        where ClientId = @clientId
    --                                          and UserId = @userId
    --                                          and Firm = @firm
    --                                          and DocType = @docType
    --                                        and ProcessDate = cast(getdate() as date))
    --if @OperationCount>0
    --         select 'IgnoreGPSRestriction' as [Key], cast(1 as bit) as Value
    --         return
    --     end

    -- TSS-6983 -- musterini uzaqdan ziyaret ucun elave etmek
    if @clientId in (select ClientId
                     from Spec_RouteRequests
                     where cast(CreatedDate as date) = cast(getdate() as date)
                       and CreatorUserId = @userActionType
                       and FeedbackStatus = 1
                       and VisitType in (1, 3))
        select 'IgnoreGPSRestriction' as [Key],
               cast(1 as bit)         as Value,
               null                   as LinkType,
               null                   as Link


    ------------------------------------------------

    if
        @userActionType < 10
        begin
            select N'Iş Planı ilə işləyin' as [Key],
                   N'Iş Planı ilə işləyin' as Value,
                   null                    as LinkType,
                   null                    as Link
            return;
        end


    -- TSS-7396
    if @userActionType = 27
        and exists(select Id from CHL_SurveyUser with (nolock) where SurveyId = 13264 and UserId = @UserId)
        and not exists(select Id from CHL_UserSurveyResponse with (nolock) where ClientId = @ClientId and SurveyId = 13264 and UserId = @UserId)
        select N'İnventar anketini yerinə yetirmək tələb olunur' as [Key],
               N'İnventar anketini yerinə yetirmək tələb olunur' as Value,
               null                                              as LinkType,
               null                                              as Link
end


