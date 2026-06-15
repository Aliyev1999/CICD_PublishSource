
/****** Object:  UserDefinedFunction [dbo].[F_DTM_GetAllUserProperties]    Script Date: 12/15/2022 4:35:52 PM ******/

CREATE FUNCTION [dbo].[F_DTM_GetAllUserProperties]() 
Returns Table
AS
RETURN(
SELECT UserId, Specode1, Specode2, Specode3, Specode4, Specode5 FROM UIM_UserProperty
)
