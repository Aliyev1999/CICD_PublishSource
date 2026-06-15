
CREATE proc [dbo].[SP_RP_GetReturningItemReportExpandedDetails] (@startDate date =NULL,
													@endDate date =NULL, 
													@firm smallint =NULL, 
													@userIds nvarchar(max)= NULL,
													@itemTigerIds nvarchar(max) =NULL, 
													@warehouses nvarchar(100)= NULL,
													@itemCode nvarchar(100)= NULL)
AS
BEGIN 
SET NOCOUNT ON;

Declare @Query nvarchar(max);

Set @Query=
'with cte as (
    select us.Id                                                                                      as userId,
           us.Name + '' '' + us.Surname                                                                 as userName,
           IIF(loq.DocType in (0, 4, 5), (un.Convfact2 / un.Convfact1) * line.Amount, 0)              as orderamount,
           IIF(loq.DocType in (0, 4, 5), (un.Convfact2 / un.Convfact1) * line.Amount * line.Price, 0) as orderprice,
           IIF(loq.DocType in (1, 2), (un.Convfact2 / un.Convfact1) * line.Amount, 0)                 as returnamount,
           IIF(loq.DocType in (1, 2), line.Price*line.Amount, 0)    as returnprice

    from OP_IncomingLogCommonLineExtension line with (nolock)
             join OP_IncomingLogCommonExtension ext with (nolock) on line.Id = ext.Id
             join OP_IncomingLog loq with (nolock) on ext.Id = loq.Id
			 join OP_GeneralLog glog with (nolock) on loq.Id=glog.RequestId
             join MD_Item item with (nolock) on line.ItemId = item.TigerId and item.Firm = loq.Firm
             join MD_ItemUnit un with (nolock) on line.ItemUnitCode = un.Code and line.ItemId = un.TigerItemId and un.IsDeleted=0
             join AbpUsers us with (nolock) on loq.UserId = us.Id
             join MD_Firm firm with (nolock)
                  on firm.Nr = loq.Firm and item.Firm = firm.Nr and un.Firm = firm.Nr and firm.IsActive = 1
             join MD_Warehouse w with (nolock) on firm.Nr = w.Firm and w.Nr = ext.WhouseNr
    where un.Convfact1 > 0 and glog.ImportResult=0 
	and (loq.ProcessDate>=@startDate) and (loq.ProcessDate<=@endDate) and item.Code=@itemCode  '

	IF @startDate IS NOT NULL and @endDate IS NOT NULL
	   SET @Query = CONCAT(@Query, ' AND (loq.ProcessDate between @startDate AND @endDate)')

	IF @firm IS NOT NULL
		SET @Query = CONCAT(@Query, ' and firm.Nr = @firm')

	IF @userIds IS NOT NULL
		SET @Query = CONCAT(@Query, ' and (us.Id IN (SELECT * FROM F_SplitList(@userIds, '','')))')

	IF @itemTigerIds IS NOT NULL
	    SET @Query = CONCAT(@Query, ' and (item.TigerId IN (SELECT * FROM F_SplitList(@itemTigerIds, '','')))')


	IF @warehouses IS NOT NULL
	    SET @Query = CONCAT (@Query, ' and  (w.Nr in ( SELECT * FROM F_SplitList(@warehouses, '','')))')


	SET @Query = CONCAT(@Query, ' )')

	

Declare @EndOfQuery nvarchar(max)=' 
							 select userId                                                                         as UserId,
							 userName                                                                              as UserName,
							 sum(orderamount)                                                                      as SaleAmountSum,
							 round(sum(orderprice),2)                                                              as SalePriceSum,
							 sum(returnamount)                                                                     as ReturnAmountSum,
                             round(sum(returnprice),2)                                                             as ReturnPriceSum,
							 round(sum(returnamount) / (select sum(returnamount) from cte) * 100, 2) as ReturnAmountPct,
							 round(sum(returnprice) / (select sum(returnprice) from cte) * 100, 2) as  ReturnPricePct


                             from cte
                             group by userId, userName 
							 having sum(returnamount)>0 
							 order by sum(returnamount) desc
							 '


   SET @Query=CONCAT(@Query,@EndOfQuery);

   EXEC sp_executesql @Query, N'@startDate date,
                                @endDate date,
                                @firm smallint,
                                @userIds nvarchar(max),
								@itemTigerIds nvarchar(max),
								@warehouses nvarchar(100),
								@itemCode nvarchar(100)',
								@startDate=@startDate,
								@endDate=@endDate,
								@firm=@firm,
								@userIds=@userIds,
								@itemTigerIds=@itemTigerIds,
								@warehouses=@warehouses,
								@itemCode=@itemCode

	END
GO


