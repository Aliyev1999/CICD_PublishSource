/****** Object:  UserDefinedFunction [dbo].[F_CHL_CalculateUserQuestionPointsAllNew]    Script Date: 10/26/2021 1:53:37 PM ******/

ALTER   FUNCTION [dbo].[F_CHL_CalculateUserQuestionPointsAllNew]() 
Returns Table
AS
RETURN(
SELECT  * FROM F_CHL_CalculateUserQuestionPointsAllNewWithDate(DATEFROMPARTS(YEAR(GETDATE()), 1, 1), GETDATE())
)
GO

