ALTER function [dbo].[FN_TS_SaleFunctionality_IsUnPaidBillExistsForSalesman_XXX](@clientId int, @salesmanId int, @docType tinyint)
    returns bit as
    begin
        declare @clientDebt float=0;
        declare @clientPayments float=0;
        declare @aprelBorc float = 0;
        declare @payPlanDays int =0;
        declare @isExists int=0;
        declare @combinedClient bit =0;

        declare @count int = 0

        select @count = count(*)
        from TayqaSale.dbo.Spec_IgnoredClientsForUnpaidBill
        where ClientId = @clientId
          and SalesmanId = @salesmanId

        if @count > 0
            set @isExists = 0

        else
            begin
                if (@docType = 0 OR @docType = 3 OR @docType = 4)
                    begin
                        -- check to see combined client or not
                        select @combinedClient = dbo.FN_TS_SpecSaleFunctionality_IsCombinedClient_XXX(@clientId);

                        if (@combinedClient = 0)
                            -- checking un paid bill control procedure for non-combined clients
                            begin
                                select @isExists =
                                       dbo.[FN_TS_SaleFunctionality_IsUnPaidBillExists_XXX](@clientId, @docType);
                            end
                        else
                            -- checking un paid bill control procedure for combined clients
                            begin
                                select @payPlanDays = convert(int, right(PAYPLAN.code, len(PAYPLAN.code) - 1))
                                from LG_XXX_CLCARD CLCARD WITH (NOLOCK)
                                         INNER JOIN LG_XXX_PAYPLANS PAYPLAN WITH (NOLOCK)
                                                    ON (PAYPLAN.LOGICALREF = CLCARD.PAYMENTREF)
                                WHERE CLCARD.LOGICALREF = @clientId

                                if (@payPlanDays > 0)
                                    begin
                                        SELECT @clientDebt = ISNULL(SUM((CASE
                                                                             WHEN CLFLINE.DATE_ <=
                                                                                  DATEADD(DAY, -@payPlanDays, CONVERT(date, getdate()))
                                                                                 THEN 1
                                                                             ELSE 0 END) *
                                                                        (CASE WHEN CLFLINE.SIGN = 0 THEN 1 ELSE -1 END) *
                                                                        CLFLINE.AMOUNT), 0),
                                               @clientPayments = ISNULL(SUM((CASE
                                                                                 WHEN CLFLINE.DATE_ >
                                                                                      DATEADD(DAY, -@payPlanDays, CONVERT(date, getdate()))
                                                                                     THEN 1
                                                                                 ELSE 0 END) *
                                                                            (CASE WHEN CLFLINE.SIGN = 1 THEN 1 ELSE 0 END) *
                                                                            CLFLINE.AMOUNT), 0),
                                               @aprelBorc = ISNULL(SUM(APREL.Debt), 0)
                                        FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                                                 LEFT JOIN [TEMSILCI_BORCU_30_APREL] APREL
                                                           ON APREL.CLIENTREF = CLFLINE.CLIENTREF AND
                                                              APREL.SALESMANREF = CLFLINE.SALESMANREF
                                        WHERE CLFLINE.SALESMANREF = @salesmanId
                                          AND CLFLINE.CLIENTREF = @clientId
                                          AND CLFLINE.CANCELLED = 0
                                          AND CLFLINE.STATUS = 0

                                        if (round(@clientDebt - @clientPayments - @aprelBorc, 2) > 0.01)
                                            set @isExists = 1;
                                    end
                            end
                    end
            end
        return @isExists;
    end
GO




--- Non comibined client control (standard one)
ALTER function [dbo].[FN_TS_SaleFunctionality_IsUnPaidBillExists_XXX](@clientId int, @docType tinyint)
returns bit as
begin 
declare @clientDebt float=0;
declare @clientPayments float=0;
declare @payPlanDays int =0;
declare @isExists int=0;

if (@docType =0 OR @docType=3 OR @docType=4)
begin
select @payPlanDays= convert(int, right(PAYPLAN.code,len(PAYPLAN.code)-1)) 
from LG_XXX_CLCARD CLCARD WITH (NOLOCK) 
INNER JOIN LG_XXX_PAYPLANS  PAYPLAN WITH (NOLOCK)  ON (PAYPLAN.LOGICALREF=CLCARD.PAYMENTREF)
WHERE CLCARD.LOGICALREF=@clientId

	if (@payPlanDays>0)
	begin
		SELECT @clientDebt = ISNULL(SUM((CASE WHEN CLFLINE.DATE_<=DATEADD(DAY, -@payPlanDays , CONVERT(date, getdate())) THEN 1 ELSE 0 END)*(CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE -1 END)*CLFLINE.AMOUNT),0),
		@clientPayments = ISNULL(SUM((CASE WHEN CLFLINE.DATE_>DATEADD(DAY, -@payPlanDays , CONVERT(date, getdate())) THEN 1 ELSE 0 END)*(CASE WHEN CLFLINE.SIGN=1 THEN 1 ELSE 0 END)*CLFLINE.AMOUNT),0)
		FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK) 
		WHERE CLFLINE.CLIENTREF = @clientId AND CLFLINE.CANCELLED=0 AND CLFLINE.STATUS=0

		if (round(@clientDebt-@clientPayments,2)>0.01) set @isExists=1;
	end
end
	return @isExists;
end