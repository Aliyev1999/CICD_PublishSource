-- replace @firm with firm number before running script
create Function [dbo].[FN_TS_MasterData_GetClientGroupForWarehouse_XXX](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT @firm As Firm,  CLCARD.LOGICALREF AS ClientId, CLCARD.ORGLOGOID AS GroupId, 
CLCARD.CAPIBLOCK_CREADEDDATE AS CreatedDate, CLCARD.CAPIBLOCK_MODIFIEDDATE AS ModifiedDate
FROM LG_XXX_CLCARD CLCARD WITH (NOLOCK)
WHERE CLCARD.ACTIVE=0 AND  CLCARD.ORGLOGOID !=''
);
