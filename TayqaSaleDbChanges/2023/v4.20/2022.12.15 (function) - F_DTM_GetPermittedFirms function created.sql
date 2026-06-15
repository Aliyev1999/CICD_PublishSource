
/****** Object:  UserDefinedFunction [dbo].[F_DTM_GetPermittedFirms]    Script Date: 12/15/2022 4:56:34 PM ******/

CREATE FUNCTION [dbo].[F_DTM_GetPermittedFirms](@currentUserId BIGINT) 
Returns Table
AS
RETURN(
	SELECT Nr, [Name] FROM MD_Firm
)


