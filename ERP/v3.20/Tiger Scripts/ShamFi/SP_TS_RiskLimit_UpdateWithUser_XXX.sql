USE [LOGODB_2021]
GO
ALTER PROCEDURE [dbo].[SP_TS_RiskLimit_UpdateWithUser_992] @ClientId INT,
                                                           @Amount Float,
                                                           @UserId int,
                                                           @Result BIT OUTPUT AS
BEGIN
    UPDATE IDE_992_CLIENTRISKLIMITS
    SET RISKLIMIT = @Amount
    WHERE CLIENTREF = @ClientId
      AND SALESMANREF = (SELECT TOP 1 UserEmployee.EmployeeId
                         FROM TayqaSale..UIM_UserEmployeeMapping UserEmployee where UserEmployee.UserId=@UserId)
    IF @@ROWCOUNT > 0 SET @Result = 1 ELSE SET @Result = 0 RETURN;
END;
