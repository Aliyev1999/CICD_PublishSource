CREATE FUNCTION [dbo].[F_SM_GetSalesmenAndSalesPersonHeads]
(
    @Firm smallint ,
    @ClientId int,
    @ControlDate datetime =null

)
RETURNS TABLE
AS
RETURN
(
select distinct
	   salesman.TigerId as Id,
	   salesman.Code as Code,
	   salesman.Name as Name,
	   cast(salesman.PositionId as tinyint) as PositionId 
from MD_SalesmanClientMapping mapping with(nolock)  
join MD_Salesman salesman with(nolock) on mapping.SalesmanId=salesman.TigerId and salesman.Firm=mapping.Firm
where mapping.ClientId=@ClientId 
and mapping.Firm = @Firm
       -- and (CAST(ControlDate AS date) = CAST(ISNULL(@ControlDate, GETDATE()) AS date))
and salesman.PositionId IN (1, 3, 13)

)