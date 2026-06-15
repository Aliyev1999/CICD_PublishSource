Create or ALTER function [dbo].[F_MGM_UserCashCardPermissions]( @firm smallint,@UserId bigint)
RETURNS TABLE
AS
RETURN
SELECT  CashCard FROM [dbo].[F_MGM_GetAllPermittedUsersPermittedCashCard](@UserId )
where Firm=@firm