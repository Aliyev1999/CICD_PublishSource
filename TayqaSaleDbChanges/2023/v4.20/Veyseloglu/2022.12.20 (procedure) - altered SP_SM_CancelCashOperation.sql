ALTER PROCEDURE [dbo].[SP_SM_CancelCashOperation] @firm SMALLINT NULL, @period SMALLINT NULL, @erpId BIGINT NULL, @userId int = default
AS
BEGIN
  BEGIN
    BEGIN
        UPDATE OP_IncomingLog SET DocStatus = 99 WHERE Id = @erpId AND Firm = @firm AND Period = @period
        IF @@ROWCOUNT > 0
            SELECT 'CancelledSuccessfully' AS [Message]
        ELSE
            SELECT N'Ləğv edilə bilmədi' AS [Message]
    END
    END
END
