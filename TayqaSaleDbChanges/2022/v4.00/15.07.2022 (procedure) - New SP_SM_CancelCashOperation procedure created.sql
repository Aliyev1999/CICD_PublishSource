
/****** Object:  StoredProcedure [dbo].[SP_SM_CancelCashOperation]    Script Date: 7/15/2022 11:50:36 AM ******/

CREATE PROCEDURE [dbo].[SP_SM_CancelCashOperation](
    @firm SMALLINT NULL,
    @period SMALLINT NULL,
    @erpId BIGINT NULL)
AS
BEGIN

    BEGIN
        UPDATE ERP_FinanceOperation SET IsCancelled = 1 WHERE ERPId = @erpId AND Firm = @firm AND Period = @period
		
        
        -- in case customer requires to update in ERP, the following scripts might be changed accordingly
        -- UPDATE TestTigerEnt_db..LG_009_06_CLFLINE SET CANCELLED = 1 , STATUS = 1 WHERE SOURCEFREF = @erpId AND MODULENR = 10 AND TRCODE = 1
		-- UPDATE TestTigerEnt_db..LG_009_06_KSLINES SET CANCELLED = 1 , STATUS = 1 WHERE LOGICALREF = @erpId

        IF @@ROWCOUNT > 0
            SELECT 'CancelledSuccessfully' AS [Message]
        ELSE
            SELECT N'Ləğv edilə bilmədi' AS [Message]
    END

END
