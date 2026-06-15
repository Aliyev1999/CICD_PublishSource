CREATE function [dbo].[FN_TS_SaleFunctionality_IsUnPaidBillExists_XXX](@clientId int, @docType tinyint)
returns bit as
begin 
declare @clientDebt float=0;
declare @clientPayments float=0;
declare @payPlanDays int =0;
declare @isExists int=0;

if (@docType =0 OR @docType=3 OR @docType=4)
begin
select @payPlanDays= DUEDATECOUNT 
from LG_XXX_CLCARD WITH (NOLOCK) 
WHERE LOGICALREF=@clientId
	if (@payPlanDays>0)
	begin
		SELECT @clientDebt = ISNULL(SUM((CASE WHEN CLFLINE.DATE_<DATEADD(DAY, -@payPlanDays , CONVERT(date, getdate())) THEN 1 ELSE 0 END)*(CASE WHEN CLFLINE.SIGN=0 THEN 1 ELSE -1 END)*CLFLINE.AMOUNT),0),
		@clientPayments = ISNULL(SUM((CASE WHEN CLFLINE.DATE_>=DATEADD(DAY, -@payPlanDays , CONVERT(date, getdate())) THEN 1 ELSE 0 END)*(CASE WHEN CLFLINE.SIGN=1 THEN 1 ELSE 0 END)*CLFLINE.AMOUNT),0)
		FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK) 
		WHERE CLFLINE.CLIENTREF = @clientId AND CLFLINE.CANCELLED=0 AND CLFLINE.STATUS=0

		if (round(@clientDebt-@clientPayments,2)>0) set @isExists=1;
	end
end
	return @isExists;
end
GO
