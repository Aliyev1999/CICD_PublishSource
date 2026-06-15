ALTER proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint,-- See: SYS_UserActionType table  
    @latitude float =null,
    @longitude float= null, 
    @referenceId int = null
)
as
--begin

----select N'Iş Planı ilə işləyin' as [Key], N'Iş Planı ilə işləyin' Value

--    if @userActionType < 30
--        begin
--            select N'Iş Planı ilə işləyin' as [Key], N'Iş Planı ilə işləyin' Value,
--                   null                  as LinkType,
--                   null                  as Link
--            return;
--        end
--    if @userActionType < 30
--        begin
--            declare @OperationCount int = (select count(*)
--                                           from OP_IncomingLog with (nolock)
--                                           where ClientId = @clientId
--                                             and UserId = @userId
--                                             and Firm = @firm
--                                             and DocType = @docType
--                                             and ProcessDate = cast(getdate() as date))
--            if @OperationCount > 0
--                select 'IgnoreGPSRestriction' as [Key], cast(1 as bit) as Value,
--                   null                  as LinkType,
--                   null                  as Link
--            return
--        end
--end