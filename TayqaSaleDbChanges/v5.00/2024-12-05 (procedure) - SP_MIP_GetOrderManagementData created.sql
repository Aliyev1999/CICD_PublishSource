create proc [dbo].[SP_MIP_GetOrderManagementData] @Firm smallint = null,
                                              @OrderBeginDate datetime,
                                              @OrderEndDate datetime,
                                              @RequestId int,
                                              @SalesmanCodeName nvarchar(255) = null,
                                              @ClientCodeNameGroupCode nvarchar(255) = null,
                                              @Status tinyint = null,
                                              @DeliveryStartDate datetime = null,
                                              @DeliveryEndDate datetime = null,
                                              @Divisions nvarchar(max) = null,
                                              @Warehouses nvarchar(max) = null,
                                              @SpeCode nvarchar(50) = null,
                                              @AuthCode nvarchar(50) = null,
                                              @CustomerOrderNo nvarchar(50) = null,
                                              @DocNumber nvarchar(50) = null,
                                              @Sorting nvarchar(100),
                                              @SkipCount int,
                                              @TakeCount int,
                                              @TotalCount int OUTPUT
AS
begin

    declare @Query nvarchar(max)

    declare @Result table
                    (
                        Firm            nvarchar(50),
                        FirmNr          smallint,
                        OrderDate       date,
                        Id              int,
                        ClientId        int,
                        ClientCode      nvarchar(50),
                        ClientName      nvarchar(200),
                        SalesmanCode    nvarchar(50),
                        SalesmanName    nvarchar(100),
                        Status          tinyint,
                        Amount          float,
                        ClientGroupCode nvarchar(50),
                        DeliveryDate    date,
                        DivisionNr      smallint,
                        DivisionName    nvarchar(50),
                        WarehouseName   nvarchar(50),
                        Specode         nvarchar(50),
                        AuthCode        nvarchar(50),
                        DocNumber       nvarchar(50),
                        CustomerOrderNo nvarchar(50),
						DocId           nvarchar(50),
						Period          smallint,
						ErpId           bigint
                    )


    set @Query = N'

    declare @OperationTotal table (Id int, Amount float)

    insert into @OperationTotal (Id, Amount)
    select Lines.Id, round(sum(Amount * Price),4) as Amount
    from OP_IncomingLogCommonLineExtension Lines with (nolock)
    join OP_IncomingLog Logs with (nolock) on Logs.Id = Lines.Id
    where Logs.DocType = 0 and (@Firm is null or ltrim(rtrim(@Firm)) = '' '' or Logs.Firm = @Firm) and Logs.ProcessDate between @OrderBeginDate and @OrderEndDate
    group by Lines.Id;

    select Firm. Name                 as Firm,
           Firm. Nr                   as FirmNr,
           ILog. ProcessDate          as OrderDate,
           ILog. Id                   as Id,
           Client. TigerId            as ClientId,
           Client. Code               as ClientCode,
           Client. Name               as ClientName,
           Salesman. Code             as SalesmanCode,
           Salesman. Name             as SalesmanName,
           cast(case
                when Status.CanceledUserId is not null then 4
                when Status.CanceledUserId is null and Status.ErpId is not null then 5
                when Queue.Id is not null then 0
                when Glo.ImportResult <> 0 then 1
                when Glo.ImportResult = 0 then 3
                else 2 end as tinyint)        as Status,
           LineTotal. Amount          as Amount,
           Client. Edino              as ClientGroupCode,
           Extension. DeliveryDate    as DeliveryDate,
           Division. Nr               as DivisionNr,
           Division. Name             as DivisionName,
           Warehouse. Name            as WarehouseName,
           ILog. Specode              as Specode,
           ILog. AuthCode             as AuthCode,
           ILog. DocNumber            as DocNumber,
           Extension. CustomerOrderNo as CustomerOrderNo,
		   Ilog. DocId                as DocId,
		   Ilog. Period               as Period,
		   Glo. TigerId               as ErpId

    from OP_IncomingLog ILog with (nolock)
             join OP_IncomingLogCommonExtension Extension with (nolock) on Extension. Id = ILog. Id
             join @OperationTotal LineTotal on LineTotal. Id = ILog. Id
             join MD_Firm Firm with (nolock) on Firm. Nr = ILog. Firm and Firm. IsActive = 1
             join MD_Division Division with (nolock) on Division. Nr = ILog. Division and Division. Firm = ILog. Firm
             join MD_Warehouse Warehouse with (nolock) on Warehouse. Nr = Extension. WhouseNr and Warehouse. Firm = ILog. Firm
             join MD_Client Client with (nolock) on Client. TigerId = ILog. ClientId and ILog. Firm = Client. Firm
             left join MD_Salesman Salesman with (nolock) on Salesman. TigerId = ILog. SalesmanRef and Salesman. Firm = ILog. Firm
             left join OP_GeneralLog Glo with (nolock) on Glo.RequestId = ILog.Id
             left join OP_ERPIntegrationtResultLog Erp with (nolock) on Erp.GeneralId = Glo.Id
             left join OP_RequestQueue Queue with (nolock) on Queue.Id = ILog.Id
             left join OP_OperationCompletionStatus Status with (nolock) on Status.RequestId = ILog.Id

    where ILog. DocType = 0  and ILog. ProcessDate between @OrderBeginDate and @OrderEndDate
	'
	
	if @Firm is not null 
        set @Query = concat(@Query, ' and ILog. Firm = @Firm')

    if @RequestId is not null
        set @Query = concat(@Query, ' and ILog.Id=@RequestId')

    if @SalesmanCodeName is not null
       set @Query = concat(@Query, ' and (Salesman.Name like ''%'' + @SalesmanCodeName + ''%'' or Salesman.Code like ''%'' + @SalesmanCodeName + ''%'') ')


    if @ClientCodeNameGroupCode is not null
        set @Query = concat(@Query,
                            ' and (Client.Name like ''%'' + @ClientCodeNameGroupCode + ''%'' or Client.Edino like ''%'' + @ClientCodeNameGroupCode + ''%'' or Client.Code like ''%'' + @ClientCodeNameGroupCode + ''%'') ')

    if @DeliveryStartDate is not null
        set @Query = concat(@Query, ' and (Extension.DeliveryDate between @DeliveryStartDate and @DeliveryEndDate)')

    if @Status is not null
    set @Query = concat(@Query, 
                        ' and (case
                               when Status.CanceledUserId is not null then 4
                               when Status.CanceledUserId is null and Status.ErpId is not null then 5
                               when Queue.Id is not null then 0
                               when Glo.ImportResult <> 0 then 1
                               when Glo.ImportResult = 0 then 3
                               else 2 end) = @Status')
	
    if @Divisions is not null
        set @Query = concat(@Query, ' and (ILog.Division in (select value from F_SplitList(@Divisions, '','')))')

    if @Warehouses is not null
        set @Query = concat(@Query, ' and (Extension.WhouseNr in (select value from F_SplitList(@Warehouses, '','')))')

    if @SpeCode is not null
        set @Query = concat(@Query, ' and (ILog.Specode like ''%'' + @SpeCode + ''%'')')
	

    if @AuthCode is not null
        set @Query = concat(@Query, ' and (ILog.AuthCode like ''%'' + @AuthCode + ''%'')')

    if @CustomerOrderNo is not null
        set @Query = concat(@Query, ' and (Extension.CustomerOrderNo like ''%'' + @CustomerOrderNo + ''%'')')

    if @DocNumber is not null
        set @Query = concat(@Query, ' and (ILog.DocNumber like ''%'' + @DocNumber + ''%'')')

	if @sorting is null set @Query = concat(@Query, ' order by ILog. Id desc ')
    if @sorting is not null set @Query = concat(@Query, ' order by ' + @sorting)

    insert into @Result
        execute sp_executesql @Query,
                N'@Firm smallint,
                  @OrderBeginDate datetime,
                  @OrderEndDate datetime,
                  @RequestId int ,
                  @SalesmanCodeName nvarchar(255) =null ,
                  @ClientCodeNameGroupCode nvarchar(255) =null ,
                  @Status tinyint = null,
                  @DeliveryStartDate datetime = null,
                  @DeliveryEndDate datetime = null,
                  @Divisions nvarchar(max) = null,
                  @Warehouses nvarchar(max) = null,
                  @SpeCode nvarchar(50) = null,
                  @AuthCode nvarchar(50) = null,
                  @CustomerOrderNo nvarchar(50) = null,
                  @DocNumber nvarchar(50) = null,
                  @Sorting nvarchar(100),
                  @SkipCount int,
                  @TakeCount int',
                @Firm = @Firm,
                @OrderBeginDate = @OrderBeginDate,
                @OrderEndDate = @OrderEndDate,
                @RequestId = @RequestId,
                @SalesmanCodeName = @SalesmanCodeName,
                @ClientCodeNameGroupCode = @ClientCodeNameGroupCode,
                @Status = @Status,
                @DeliveryStartDate = @DeliveryStartDate,
                @DeliveryEndDate = @DeliveryEndDate,
                @Divisions = @Divisions,
                @Warehouses = @Warehouses,
                @SpeCode = @SpeCode,
                @AuthCode = @AuthCode,
                @CustomerOrderNo = @CustomerOrderNo,
                @DocNumber = @DocNumber,
                @Sorting = @Sorting,
                @SkipCount = @SkipCount,
                @TakeCount = @TakeCount


    set @TotalCount = (select count(Id) from @Result);

    select *
    from @Result
    order by coalesce(@sorting, 'Id')
    offset @skipCount rows fetch next @TakeCount rows only

end