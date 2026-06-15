create or ALTER procedure [dbo].[SP_SM_CancelOrderOperation] @erpId bigint, @firm smallint, @period smallint, @userId int
as
begin
    return;
    -- declare @status tinyint = (SELECT STATUS FROM TestTigerEnt_db..LG_009_06_ORFICHE WHERE LOGICALREF = @erpId)

    -- if @status = 4
    --     begin
	-- 		Update TestTigerEnt_db..LG_009_06_ORFICHE SET GENEXP2='TESDIQ', DOCODE = 'TESDIQ', STATUS=4, CANCELLED = 0 Where LOGICALREF = @erpId
    --     end

    -- else

    --     begin


    --         --update OP_IncomingLog
    --         --set DocStatus = 99
    --         --from OP_IncomingLog
    --         --         join OP_GeneralLog on OP_IncomingLog.Id = RequestId
    --         --where TigerId = @erpId
    --         --  and Period = @period
    --         --  and Firm = @firm

    --         update OP_OperationCompletionStatus
    --         set Status = 0
    --         where ErpId = @erpId
    --           and Firm = @firm
    --           and DocType = 0

    --         update TestTigerEnt_db..LG_009_06_ORFICHE
    --         set CANCELLED = 1,
    --             STATUS    = 1
    --         where LOGICALREF = @erpId
    --     end
end