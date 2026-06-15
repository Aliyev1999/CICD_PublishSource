
ALTER Function [dbo].[FN_TS_Report_GetWarehouseInOutData_XXX_YY](@warehouseNr smallint, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                select CAPIBLOCK_CREADEDDATE      AS Date,
                       FICHENO    AS FicheNo,
                       SPECODE    AS Specode,
                       5       AS Amount,
                       'AZN'     AS CurrencyCode,
                       case
                           when TRCODE <> 25 then TRCODE
                           when TRCODE = 25 and SOURCEINDEX = @warehouseNr then 26
                           when TRCODE = 25 and DESTINDEX = @warehouseNr then TRCODE
                           end    as 'OperationType',
                       LOGICALREF AS FicheId,
                       case
                           when IOCODE = 1 then 1
                           when IOCODE = 3 then 0
                           when IOCODE = 2 and SOURCEINDEX = @warehouseNr then 0
                           when IOCODE = 2 and DESTINDEX = @warehouseNr then 1
                           end    as 'InOut'
                from LG_XXX_YY_STFICHE WITH (NOLOCK)
                WHERE TRCODE IN (11, 12, 13, 14, 25, 50, 51)
                  AND DATE_ between @beginDate AND @endDate
                  and (SOURCEINDEX = @warehouseNr or DESTINDEX = @warehouseNr)
            )