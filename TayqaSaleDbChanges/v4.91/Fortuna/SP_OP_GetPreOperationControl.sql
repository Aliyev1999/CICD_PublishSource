alter proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint,
    @latitude FLOAT = null,
    @longitude FLOAT = null
)
as
begin

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

    if @docType = 0
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


    if @docType in (4)
        begin
            declare @IsFirstSale bit = 1
            if exists(select Id from OP_IncomingLog with (nolock) where ClientId = @clientId and DocType = 4)
                set @IsFirstSale = 0

            declare @IsNewCustomer bit = 0
            if exists(select Id from DigiTayqaNCC..MD_Client where Id = @clientId and cast(CreationTime as date) = cast(getdate() as date))
                set @IsNewCustomer = 1

            if @IsFirstSale = 1 and @IsNewCustomer = 1
                select 'IgnoreGPSRestriction' as [Key],
                       cast(1 as bit)         as Value,
                       null                   as LinkType,
                       null                   as Link
            return
        end

    If @clientId in (select TigerId from MD_Client where code like 'S1%') and @userActionType <> 30 and @firm = 1
        begin
            select N'Əməliyyat icra edilmədi'              as [Key],
                   N'Müştəriyə Yalnız Ziyarət oluna Bilər' as Value,
                   null                                    as LinkType,
                   null                                    as Link
            return
        end;

end


go