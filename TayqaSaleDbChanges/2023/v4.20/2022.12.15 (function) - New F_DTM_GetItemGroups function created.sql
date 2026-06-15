
/****** Object:  UserDefinedFunction [dbo].[F_DTM_GetItemGroups]    Script Date: 12/15/2022 4:59:06 PM ******/

CREATE FUNCTION [dbo].[F_DTM_GetItemGroups]() 
Returns Table
AS
RETURN(
	SELECT Id, [Name], Code, [Type] FROM MD_ItemGroup
)
