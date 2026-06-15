ALTER proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint, -- See: SYS_UserActionType table
    @Latitude float = null,
    @Longitude float = null,
    @referenceId int = null
)
as
begin

    -- declare @MandatoryTaskCount int = (select count(Task.Id)
    --                                    from WPM_Task Task with (nolock)
    --                                             join WPM_UserTask Users with (nolock) on Users.TaskId = Task.Id
    --                                             join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Task.Id
    --                                             join WPM_TaskClient Client with (nolock) on Client.TaskId = Task.Id
    --                                             left join WPM_TaskTicket Tickets with (nolock)
    --                                                       on Tickets.UserId = @userId and Tickets.ClientId = @clientId and Tickets.TaskId = Task.Id and
    --                                                          Tickets.Firm = Task.Firm
    --                                                           and Tickets.FinalizedDate is not null
    --                                    where Task.Priority = 3
    --                                      and Users.UserId = @userId
    --                                      and cast(getdate() as date) between Schedule.StartDate and Schedule.EndDate
    --                                      and Task.IsDeleted = 0
    --                                      and Task.Status = 0
    --                                      and Client.ClientId = @clientId
    --                                      and Task.Firm = @firm
    --                                      and Tickets.Id is null)

    -- if @MandatoryTaskCount > 0
    --     begin
    --         select 'MandatoryTaskExists' as [Key], CAST(1 as bit) as Value
    --         return;
    --     end

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

    --  end
--Control 1
    if @docType in (0) and @userActionType = 1
        begin
            With Inv as (Select ClientTigerId as ClientId, Id as InventoryId
                         from IM_Inventory inv with (nolock)
                                  join F_GetAllPermittedClient() client on client.ClientId = inv.ClientTigerId
                         where Status = 4
                           and inv.Firm = @firm
                           and UserId = @userId
                         except
--Hemin gun Veziyyeti yenilenenler
                         select ClientTigerId as ClientId, InventoryId
                         from IM_InventoryStateHistory stateHistory with (nolock)
                                  join F_GetAllPermittedClient() client on client.ClientId = stateHistory.ClientTigerId
                         where cast(stateHistory.CreatedDate as date) = cast(getdate() as date)
                           and UserId = @userId
                           and stateHistory.StateHistoryType = 1
                           and stateHistory.Firm = @firm)
            select N'Inventory First'                                                                           as [Key],
                   N'Inventarı olub vəziyyət tarixçəsi yenilənməmiş müştərilərdə sənəd yazmağa icazə verilmir.' as [Value],
                   null                                                                                         as LinkType,
                   null                                                                                         as Link
            where @clientId in (select distinct ClientId from Inv)
        end
end