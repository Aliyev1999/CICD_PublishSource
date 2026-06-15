
/****** Object:  UserDefinedFunction [dbo].[F_DTM_GetWarehouses]    Script Date: 12/15/2022 5:01:49 PM ******/

CREATE FUNCTION [dbo].[F_DTM_GetWarehouses]() 
Returns Table
AS
RETURN(
	SELECT Nr, [Name], Firm, IsDeleted FROM MD_Warehouse
)
