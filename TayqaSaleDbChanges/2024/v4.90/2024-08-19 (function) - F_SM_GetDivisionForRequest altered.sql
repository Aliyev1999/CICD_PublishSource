ALTER FUNCTION [dbo].[F_SM_GetDivisionForRequest](@RequestId INT)
    RETURNS SMALLINT
AS
BEGIN
    DECLARE @SpecialCode5 NVARCHAR(50);
    
    SELECT @SpecialCode5 = Property.Specode5
    FROM OP_IncomingLog ILog with(nolock)
	join AbpUsers Users With(nolock) On Ilog.UserId=Users.Id
	join UIM_UserProperty Property With(nolock) on Users.Id=Property.UserId and ILog.Firm=Property.Firm
	
    WHERE ILog.Id = @RequestId;

    RETURN @SpecialCode5;
END