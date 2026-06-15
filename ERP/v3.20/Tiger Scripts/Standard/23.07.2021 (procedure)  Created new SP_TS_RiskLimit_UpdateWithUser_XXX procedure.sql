
CREATE   PROCEDURE [dbo].[SP_TS_RiskLimit_UpdateWithUser_XXX] @ClientId INT,
														@Amount Float,
														@UserId int,
														@Result BIT OUTPUT AS
BEGIN
    update LG_XXX_YY_CLRNUMS set ACCRISKLIMIT = @Amount where CLCARDREF = @ClientId
    SET @Result = 1 RETURN;
END;
GO


