ALTER proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint,
    @latitude FLOAT,
    @longitude FLOAT, 
    @referenceId int = null
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

        end

    DECLARE @tarix DATE=cast(getdate() as date)
    IF @userActionType = 5 and ISNULL(
                                       (SELECT sum(-1 * t1.nov * t1.mebleg) -
                                               sum(case when t1.nov = -1 and t1.tarix BETWEEN DATEADD(dd, -vade, @tarix) AND @tarix then t1.mebleg end) mebleg
                                        FROM LOGIXERP04DB..sm_kontr_qal t1,
                                             LOGIXERP04DB..sm_kontra t2
                                                 LEFT JOIN LOGIXERP04DB..sm_kontra_qrup t3 on t2.qrup = t3.idn
                                        WHERE t1.kontra = cast(t2.idn as nvarchar(50))
                                          and t2.idn = @clientId), 1) > 0 and @clientId in (select idn from LOGIXERP04DB..sm_kontra where vade < 200) and
       @clientId in (Select kontra FROM LOGIXERP04DB..sm_kontr_qal GROUP BY kontra HAVING COUNT(idn) > 0 and SUM(-1 * nov * mebleg) > 0)
        BEGIN

            select 'RiskLimit'                                            as [Key],
                   N'Təyin edilmiş Vadə Müddəti ərzində ödəniş gəlməyib!' as Value,
                   null                                                   as LinkType,
                   null                                                   as Link
            return

        END
    IF @userActionType = 5 and ISNULL((SELECT sum(-1 * t1.nov * t1.mebleg) mebleg
                                       FROM LOGIXERP04DB..sm_kontr_qal t1,
                                            LOGIXERP04DB..sm_kontra t2
                                                LEFT JOIN LOGIXERP04DB..sm_kontra_qrup t3 on t2.qrup = t3.idn
                                       WHERE t1.kontra = CAST(t2.idn AS nvarchar(50))
                                         and t2.idn = @clientId), 0) > (select meb from LOGIXERP04DB..sm_kontra where idn = @clientId)
        BEGIN

            select 'RiskLimit'                            as [Key],
                   N'Müştəri təyin edilmiş limiti aşıb !' as Value,
                   null                                   as LinkType,
                   null                                   as Link
            return

        END
end

