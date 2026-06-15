CREATE PROCEDURE [dbo].[SP_TS_OrderConfirmation_UpdateStatus_XXX_YY] (
	@status tinyint,
	@orderId INT	
) AS
BEGIN
Update LG_XXX_YY_ORFICHE Set STATUS = @status Where LOGICALREF = @orderId;
Update LG_XXX_YY_ORFLINE Set STATUS=@status WHERE ORDFICHEREF=@orderId
END;
GO
