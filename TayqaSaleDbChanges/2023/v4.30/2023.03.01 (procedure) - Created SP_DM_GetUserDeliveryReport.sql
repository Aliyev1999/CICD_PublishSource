CREATE PROCEDURE [dbo].[SP_DM_GetUserDeliveryReport] @clientFilter nvarchar(max) null,
                                                    @truckIds nvarchar(max) null ,
													@startDate date,
													@endDate date,
													@userIds nvarchar(max) null,
													@currentUserId int

AS
BEGIN

--Author: by TayqaTech for TayqaSale on 2023.02.13 (Shahri Yahyayeva)
--Description: this query returns Driver's KPI report in Service Portal
--Ticket: TSC-4323

    declare @Query nvarchar(max) =' with PandCCounts as (Select TransportClient.TransportPackageId,
       count(TransportOrder.Id)                          as PlannedOrderCount,
       sum(iif(TransportOrder.DeliveryStatus > 0, 1, 0)) as CompletedOrderCount,
	
       count(distinct TransportClient.ClientTigerId)       as PlannedClientCount,
       count(distinct iif(TransportClient.DeliveryStatus>0,TransportClient.ClientTigerId,null))  as DeliveredClientCount,
       sum(Item.PlannedItemCount)             as PlannedItemCount
from DM_TransportClient TransportClient with (nolock)
         join DM_TransportOrder TransportOrder with (nolock) on TransportClient.Id = TransportOrder.TransportClientId
         join MD_Client Client with(nolock) on TransportClient.ClientFirm = Client.Firm and TransportClient.ClientTigerId = Client.TigerId and Client.IsDeleted = 0 and Client.Status = 0
         join (select distinct Orders.Id OrderId, count(distinct OrderLine.ItemId) as PlannedItemCount
               from DM_Order Orders with (nolock)
                        join DM_OrderLine OrderLine with (nolock) on OrderLine.OrderId = Orders.Id
               group by Orders.Id) Item on TransportOrder.OrderId = Item.OrderId  where 1=1 '
    if @clientFilter is not null
        set @Query = concat(@Query,
                            ' and (Client.Code like ''%''+@clientFilter+''%'' or Client.Name like ''%''+@clientFilter+''%'' or Client.Edino like ''%''+@clientFilter+''%'') ')

    set @Query = concat(@Query, ' group by TransportClient.TransportPackageId )
select cast(TransportPackage.UserId as bigint) as UserId,
       count(TransportPackage.Id)              as PlannedPackageCount,
       sum(PlannedClientCount)   as PlannedClientCount,
       sum(DeliveredClientCount) as DeliveredClientCount,
	   concat(users.Name,'' '',users.Surname) as DeliveryName,
	   users.UserName            as UserName,
	   round(cast(sum(DeliveredClientCount * 1.) / sum(PlannedClientCount) as float),2) as DeliveredClientPercent,
       sum(PlannedOrderCount)    as PlannedOrderCount,
       sum(CompletedOrderCount)  as CompletedOrderCount,
	   round(cast(sum(CompletedOrderCount * 1.) / sum(PlannedOrderCount) AS FLOAT),2) OrderPercent,
       sum(PlannedItemCount)     as PlannedItemCount
from DM_TransportPackage TransportPackage with(nolock)
         join PandCCounts counts with(nolock) on counts.TransportPackageId = TransportPackage.Id
		 join AbpUsers users with(nolock) on users.Id=TransportPackage.UserId and users.IsDeleted=0 and users.IsActive=1
		 join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = users.Id
where TransportPackage.UserId is not null and TransportPackage.TransportStatusId >= 4 and --StatusId >= 4 Planlanir ve Tamamlanmis statusda olmayan baglamalar
(Cast(TransportPackage.StartTime as date) <= @endDate and @startDate <= Cast(TransportPackage.EndTime as date) )
 ')

    if @truckIds is not null set @Query = concat(@Query, ' and (TransportPackage.TruckId in (select ltrim(Value) from F_SplitList(''', @truckIds, ''',', ''',''))) ')
	if @userIds is not null set @Query=concat(@Query, ' and (TransportPackage.UserId in (select ltrim(Value) from F_SplitList(''', @userIds, ''',', ''',''))) ' )
    set @Query = concat(@Query, ' group by TransportPackage.UserId,concat(users.Name,'' '',users.Surname),users.UserName  ')

    exec sp_executesql @Query, N'@startDate datetime = null,
							 @endDate datetime = null, 
							 @truckIds nvarchar(max)=null,
							 @clientFilter nvarchar(max)=null,
							 @userIds nvarchar(max)=null,
							 @currentUserId int',
         @startDate =@startDate,
         @endDate =@endDate,
         @truckIds = @truckIds,
         @clientFilter=@clientFilter,
		 @userIds=@userIds,
		 @currentUserId=@currentUserId
END
