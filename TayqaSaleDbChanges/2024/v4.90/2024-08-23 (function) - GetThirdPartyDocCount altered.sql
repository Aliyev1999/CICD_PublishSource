
ALTER FUNCTION [dbo].[GetThirdPartyDocCount]
(
    @Firm SMALLINT,
    @UserId INT
)
RETURNS INT
AS
BEGIN
    DECLARE @ThirdPartyDocCount INT;

    SELECT @ThirdPartyDocCount = COUNT(*)
    FROM OP_ThirdPartyRequestQueue Queue with (nolock)
	join AbpUsers Users with (nolock) on Users.Id = Queue.UserId
     join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
    WHERE Firm = @Firm
      AND Step in ( 5,8) and ProcessDate=cast(getdate() as date);

    RETURN @ThirdPartyDocCount;
END;

