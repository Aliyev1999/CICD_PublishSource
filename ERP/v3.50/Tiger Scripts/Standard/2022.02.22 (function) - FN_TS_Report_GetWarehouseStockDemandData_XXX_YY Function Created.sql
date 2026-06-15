/****** Object:  UserDefinedFunction [dbo].[FN_TS_Report_GetWarehouseStockDemandData_XXX_YY]    Script Date: 2/22/2022 10:15:27 AM ******/

CREATE Function [dbo].[FN_TS_Report_GetWarehouseStockDemandData_XXX_YY](@warehouseInNr smallint, @beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                select df.DATE_        as Date,
                       df.FICHENO      as FicheNo,
                       df.LOGICALREF   as FicheId,
                       w.NAME          as WarehouseOutName,
                       SUM(d.AMOUNT)   as TotalQuantity,
                       SUM(d.MEETAMNT) as AcceptedQuantity

                from LG_XXX_YY_DEMANDLINE d
                         inner join LG_XXX_YY_DEMANDFICHE df on df.LOGICALREF = d.DEMANDFICHEREF
                         inner join L_CAPIWHOUSE w on w.NR = d.SOURCEINDEX and w.FIRMNR = 9

                where (df.DATE_ between CAST(@beginDate AS date) AND CAST(@endDate AS date))
                  AND d.SOURCEINDEX = @warehouseInNr
                group by df.DATE_, df.FICHENO, df.LOGICALREF, w.NAME


            )