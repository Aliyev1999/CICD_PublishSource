ALTER FUNCTION [dbo].[F_DTM_GetPermittedFirms](@currentUserId BIGINT) 
Returns Table
AS
RETURN(
	SELECT Nr, [Name],IsActive FROM MD_Firm
)