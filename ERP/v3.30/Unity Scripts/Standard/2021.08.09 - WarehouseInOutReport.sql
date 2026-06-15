create Function [dbo].[FN_TS_Report_GetWarehouseInOutData_XXX_YY](@warehouseNr smallint, @beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
	select DATE_ AS Date,FICHENO AS FicheNo,SPECODE AS Specode, 
	case when TRCODE<> 25 then TRCODE
     when TRCODE=25 and SOURCEINDEX=@warehouseNr then 26
       when TRCODE=25 and DESTINDEX=@warehouseNr then TRCODE
       end as 'OperationType',
       LOGICALREF AS FicheId,
case when IOCODE=1 then 0
     when IOCODE=3 then 1
       when IOCODE=2 and SOURCEINDEX=@warehouseNr then 1
       when IOCODE=2 and DESTINDEX=@warehouseNr then 0
       end as 'InOut'
from LG_XXX_YY_STFICHE WITH (NOLOCK)
WHERE TRCODE IN (11,12,13,14,25,50,51) AND DATE_ between @beginDate AND @endDate and (SOURCEINDEX = @warehouseNr or DESTINDEX=@warehouseNr)
)


GO

create Function [dbo].[FN_TS_Report_GetWarehouseInOutLineData_XXX_YY](@ficheId int)
RETURNS TABLE
AS RETURN
(
	SELECT distinct LINE.STFICHEREF ,  ITEM.NAME AS ItemName, ITEM.CODE AS ItemCode, UNITLINE.CODE AS UnitCode, LINE.AMOUNT AS Quantity 
	from LG_XXX_YY_STLINE LINE WITH (NOLOCK)
	INNER JOIN LG_XXX_ITEMS ITEM WITH (NOLOCK) ON ITEM.LOGICALREF = LINE.STOCKREF
	INNER JOIN LG_XXX_UNITSETL UNITLINE WITH (NOLOCK) ON UNITLINE.LOGICALREF=LINE.UOMREF
	WHERE LINE.STFICHEREF = @ficheId
)
