ALTER FUNCTION [dbo].[F_GetUsersByType](@type VARCHAR(30)) 
Returns Table
AS
RETURN(
select * from F_GetUsersByTypeIncludingInactive(@type) where IsActive=1
)
