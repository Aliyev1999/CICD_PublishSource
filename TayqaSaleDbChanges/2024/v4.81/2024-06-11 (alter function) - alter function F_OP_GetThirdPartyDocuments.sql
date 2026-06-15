

ALTER function [dbo].[F_OP_GetThirdPartyDocuments]
(
	@userId int,
	@beginDate datetime,
	@endDate datetime,
	@firm smallint
)
returns table
	as return (
select ILog.Id                                                as Id,
       cast(ILog.DocType as smallint)                         as Type,
       ILog.DocNumber                                         as DocNumber,
       round(isnull(Line.Amount, 0),2)                        as Amount,
       ILog.UserId                                            as CreatorUserId,
       Users.UserName                                         as CreatorUserName,
       concat(Users.Name, ' ', Users.Surname)                 as CreatorUserFullName,
       Salesman.Code                                          as SalesmanCode,
       Salesman.Name                                          as SalesmanName,
       cast(ILog.Division as smallint)                        as DivisionNr,
       Division.Name                                          as DivisionName,
       cast(Warehouse.Nr as nvarchar(max))                    as WarehouseNr,
       Warehouse.Name                                         as WarehouseName,
       ILog.ClientId                                          as ClientId,
       Client.Code                                            as ClientCode,
       Client.Name                                            as ClientName,
       Client.Edino                                           as ClientEdino,
        case
                    when isnull(queue.ProcessingStatus, 0) = 1 then 1
                    when (Line2.Amount - LineResultAmount.Amount) = 0 THEN 2
                    WHEN glog.ImportResult = 969 or rqueue.step = 11 THEN 3
                    else 5     end      as Status,
       cast(Feedback.FeedbackDate as bigint)                  as FeedbackDate,
       Feedback.FeedbackUserId                                as FeedbackUserId,
       FeedbackUsers.UserName                                 as FeedbackUserName,
       concat(FeedbackUsers.Name, ' ', FeedbackUsers.Surname) as FeedbackUserFullName,
       Feedback.FeedbackNote                                  as Note,
	   ILog.RegisteredDate                                    as Date

from OP_ThirdPartyIncomingLog ILog with (nolock)
		 left join OP_GeneralLog glog with (nolock) on ILog.Id = glog.RequestId
		 left join OP_RequestQueue rqueue with (nolock) on rqueue.Id = ILog.Id
         join MD_Client Client with (nolock) on ILog.ClientId = Client.TigerId and ILog.Firm = Client.Firm
         join AbpUsers Users with (nolock) on Users.Id = ILog.UserId
         join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
         left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = ILog.SalesmanRef
         left join MD_Division Division with (nolock) on Division.Nr = ILog.Division and ILog.Firm = Division.Firm
         left join OP_ThirdPartyResultLog Feedback with (nolock) on Feedback.RequestId = ILog.Id
         left join OP_ThirdPartyRequestQueue RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
         left join AbpUsers FeedbackUsers with (nolock) on FeedbackUsers.Id = Feedback.FeedbackUserId
		 left join OP_ThirdPartyRequestQueue queue ON queue.Id = ILog.Id
         left join (select distinct Id from OP_ThirdPartyCommonLineResultLog) lineResult on ILog.Id = lineResult.Id
         left join (select Extension.Id, sum(iif(ResultLog.Amount is not null, ResultLog.Amount,Extension.Amount)*Price)-Extension.DiscountAmount as Amount
                    from OP_ThirdPartyIncomingLogCommonLineExtension Extension with (nolock)
					left join OP_ThirdPartyCommonLineResultLog ResultLog on Extension.Id=ResultLog.Id and ResultLog.ItemId=Extension.ItemId
					and ResultLog.IsPromo=Extension.IsPromo
					where Extension.IsPromo=0 or ResultLog.IsPromo=0
                    group by Extension.Id,Extension.DiscountAmount) Line on Ilog.Id = line.Id
		 left join (select Id, sum(Amount) as Amount
                    from OP_ThirdPartyIncomingLogCommonLineExtension with (nolock)
                    group by Id) Line2 on Ilog.Id = line2.Id
		 left join (select Id, sum(Amount) as Amount
                    from OP_ThirdPartyCommonLineResultLog with (nolock)
                    group by Id) LineResultAmount on Ilog.Id = LineResultAmount.Id
         left join OP_ThirdPartyIncomingLogCommonExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
         left join MD_Warehouse Warehouse with (nolock) on WarehouseId.WhouseNr = Warehouse.Nr and Warehouse.Firm = ILog.Firm
where Ilog.DocType in (0, 1, 2, 3, 4) and ILog.Firm=@firm and ILog.ProcessDate between cast(@beginDate as date) and cast(@endDate as date)


union

select ILog.Id                                                as Id,
       cast(ILog.DocType as smallint)                         as Type,
       ILog.DocNumber                                         as DocNumber,
       round(isnull(Cash.Amount, 0),2)                        as Amount,
       ILog.UserId                                            as CreatorUserId,
       Users.UserName                                         as CreatorUserName,
       concat(Users.Name, ' ', Users.Surname)                 as CreatorUserFullName,
       Salesman.Code                                          as SalesmanCode,
       Salesman.Name                                          as SalesmanName,
       cast(ILog.Division as smallint)                        as DivisionNr,
       Division.Name                                          as DivisionName,
       cast(Warehouse.Nr as nvarchar(max))                                         as WarehouseNr,
       Warehouse.Name                                         as WarehouseName,
       ILog.ClientId                                          as ClientId,
       Client.Code                                            as ClientCode,
       Client.Name                                            as ClientName,
       Client.Edino                                           as ClientEdino,
       case
                    when isnull(queue.ProcessingStatus, 0) = 1 then 1
                    when (Line.Amount - LineResultAmount.Amount) = 0 THEN 2
                    WHEN glog.ImportResult = 969 or rqueue.step = 11 THEN 3
                    else 5     end      as Status,
       cast(Feedback.FeedbackDate as bigint)                  as FeedbackDate,
       Feedback.FeedbackUserId                                as FeedbackUserId,
       FeedbackUsers.UserName                                 as FeedbackUserName,
       concat(FeedbackUsers.Name, ' ', FeedbackUsers.Surname) as FeedbackUserFullName,
       Feedback.FeedbackNote                                  as Note,
	   ILog.RegisteredDate                                    as Date
from OP_ThirdPartyIncomingLog ILog with (nolock)
		 left join OP_GeneralLog glog with (nolock) on ILog.Id = glog.RequestId
		 left join OP_RequestQueue rqueue with (nolock) on rqueue.Id = ILog.Id
         join MD_Client Client with (nolock) on ILog.ClientId = Client.TigerId and ILog.Firm = Client.Firm
         join AbpUsers Users with (nolock) on Users.Id = ILog.UserId
		 join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
         left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = ILog.SalesmanRef
		 left join OP_ThirdPartyRequestQueue queue ON queue.Id = ILog.Id
         left join MD_Division Division with (nolock) on Division.Nr = ILog.Division and ILog.Firm = Division.Firm
         left join OP_ThirdPartyResultLog Feedback with (nolock) on Feedback.Id = ILog.Id
         left join AbpUsers FeedbackUsers with (nolock) on FeedbackUsers.Id = Feedback.FeedbackUserId
         left join OP_ThirdPartyIncomingLogCashExtension Cash with (nolock) on Cash.Id = ILog.Id
		 left join (select Id, sum(Amount ) as Amount
                    from OP_ThirdPartyIncomingLogCashExtension with (nolock)
                    group by Id) Line on Ilog.Id = line.Id
		 left join OP_ThirdPartyRequestQueue RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
		 left join (select distinct Id from OP_ThirdPartyCashResultLog) lineResult on ILog.Id = lineResult.Id
		 left join (select  Id,sum(Amount) as Amount from OP_ThirdPartyCashResultLog group by Id) lineResultAmount on ILog.Id = lineResultAmount.Id
         left join OP_ThirdPartyIncomingLogCommonExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
         left join MD_Warehouse Warehouse with (nolock) on WarehouseId.WhouseNr = Warehouse.Nr and Warehouse.Firm = ILog.Firm
where ILog.DocType in (5, 6) and ILog.Firm=@firm and ILog.ProcessDate between cast(@beginDate as date) and cast(@endDate as date)

--union

--select distinct ILog.Id                                                as Id,
--       cast(ILog.DocType as smallint)                         as Type,
--       ILog.DocNumber                                         as DocNumber,
--       cast(0 as float)                                       as Amount,
--       ILog.UserId                                            as CreatorUserId,
--       Users.UserName                                         as CreatorUserName,
--       concat(Users.Name, ' ', Users.Surname)                 as CreatorUserFullName,
--       Salesman.Code                                          as SalesmanCode,
--       Salesman.Name                                          as SalesmanName,
--       cast(ILog.Division as smallint)                        as DivisionNr,
--       Division.Name                                          as DivisionName,
--       case ILog.DocType
--           when 21 then cast(InWarehouse.Nr as nvarchar(max)) 
--           when 22 then cast(OutWarehouse.Nr as nvarchar(max)) 
--           when 23 then concat(InWarehouse.Nr, '-', OutWarehouse.Nr)
--           when 24 then concat(InWarehouse.Nr, '-', OutWarehouse.Nr)
--           end                                                as WarehouseNr,
--       case ILog.DocType
--           when 21 then InWarehouse.Name
--           when 22 then OutWarehouse.Name
--           when 23 then concat(InWarehouse.Name, '-', OutWarehouse.Name)
--           when 24 then concat(InWarehouse.Name, '-', OutWarehouse.Name)
--           end                                                as WarehouseName,
--       ILog.ClientId                                          as ClientId,
--       Client.Code                                            as ClientCode,
--       Client.Name                                            as ClientName,
--       Client.Edino                                           as ClientEdino,
--       case
--                    when isnull(queue.ProcessingStatus, 0) = 1 then 1
--                    when (LineAmount.Amount - LineResultAmount.Amount) = 0 then 2
--                    WHEN LineResultAmount.Amount = 0 then 3
--                    else 5     end      as Status,
--       cast(Feedback.FeedbackDate as bigint)                  as FeedbackDate,
--       Feedback.FeedbackUserId                                as FeedbackUserId,
--       FeedbackUsers.UserName                                 as FeedbackUserName,
--       concat(FeedbackUsers.Name, ' ', FeedbackUsers.Surname) as FeedbackUserFullName,
--       Feedback.FeedbackNote                                  as Note,
--	   ILog.RegisteredDate                                    as Date
--from OP_ThirdPartyIncomingLog ILog with (nolock)
--         left join MD_Client Client with (nolock) on ILog.ClientId = Client.TigerId and ILog.Firm = Client.Firm
--         join AbpUsers Users with (nolock) on Users.Id = ILog.UserId
--		 join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
--         left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = ILog.SalesmanRef
--         left join MD_Division Division with (nolock) on Division.Nr = ILog.Division and ILog.Firm = Division.Firm
--         left join OP_ThirdPartyResultLog Feedback with (nolock) on Feedback.Id = ILog.Id
--		 left join (select Extension.Id, sum(iif(ResultLog.Quantity is not null, ResultLog.Quantity,Extension.Quantity )) as Amount
--                    from OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Extension with (nolock)
--					left join OP_ThirdPartyWarehouseOperationLineResultLog ResultLog with(nolock) on Extension.Id=ResultLog.Id
--					and Extension.ItemId=ResultLog.ItemId
--                    group by Extension.Id) LineAmount on Ilog.Id = LineAmount.Id
--		 left join OP_ThirdPartyRequestQueue queue ON queue.Id = Ilog.Id
--		 left join (select distinct Id from OP_ThirdPartyWarehouseOperationLineResultLog) lineResult on ILog.Id = lineResult.Id
--		 left join (select Id,sum(Quantity) as Amount from OP_ThirdPartyWarehouseOperationLineResultLog
--		 group by Id) lineResultAmount on ILog.Id = lineResultAmount.Id
--		 left join OP_ThirdPartyRequestQueue RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
--         left join AbpUsers FeedbackUsers with (nolock) on FeedbackUsers.Id = Feedback.FeedbackUserId
--         left join OP_ThirdPartyIncomingLogWarehouseOperationExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
--         left join OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Line with (nolock) on Line.Id = ILog.Id
--         left join MD_Warehouse InWarehouse with (nolock) on WarehouseId.WarehouseIn = InWarehouse.Nr and InWarehouse.Firm=ILog.Firm
--         left join MD_Warehouse OutWarehouse with (nolock) on WarehouseId.WarehouseOut = OutWarehouse.Nr and OutWarehouse.Firm=ILog.Firm
--where ILog.DocType in (21,22,23,24) and ILog.Firm=@firm and ILog.ProcessDate between cast(@beginDate as date) and cast(@endDate as date)


)