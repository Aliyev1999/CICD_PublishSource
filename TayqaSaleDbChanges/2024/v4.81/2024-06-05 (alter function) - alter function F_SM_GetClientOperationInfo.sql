ALTER function [dbo].[F_SM_GetClientOperationInfo](@givenDate date, @userId int, @firm smallint, @clientId int)
    returns table as return
            (
                select ugd.ActionTypeId,
                       case
                           when ugd.ActionTypeId >= 1 and ugd.ActionTypeId <= 11 then ugd.ActionLogId
                           when ugd.ActionTypeId = 30 then vl.Id
                           else null end       as RequestId,
                       act.Type                as ActionName,
                       ugd.GpsDate             as CreatedDate,
                       ugd.Latitude            as CreatedLatitude,
                       ugd.Longitude           as CreatedLongitude,
                       s.Name                  as SalesmanName,
                       s.Code                  as SalesmanCode,
					   case when ugd.ActionTypeId  in (6,7) then ''
					   else
                       cast(concat(GrossWeight.GrossWeight, ' KG') as nvarchar(max)) 
					   end as Note,
                       case
                           when ugd.ActionTypeId in (6, 7)
                               then (select top 1 cast(JSON_VALUE(ImportResult, '$.ERPDocInfo.Total') as float) as 'Price'
                                     from OP_ERPIntegrationtResultLog with (nolock)
                                     where GeneralId =
                                           (select top 1 Id from OP_GeneralLog with (nolock) where RequestId = ugd.ActionLogId))
                           when ugd.ActionTypeId in (1, 2, 3, 4, 5, 11)
                               then (select top 1 cast(JSON_VALUE(ImportResult, '$.ERPDocInfo.GrossAmount') as float) as 'Price'
                                     from OP_ERPIntegrationtResultLog with (nolock)
                                     where GeneralId =
                                           (select top 1 Id from OP_GeneralLog with (nolock) where RequestId = ugd.ActionLogId))
                           end                 as Price
                from OP_UserActionGpsData ugd with (nolock)
					     join SYS_UserActionType act with (nolock) on ugd.ActionTypeId = act.Id and act.Status = 1
                         left join OP_IncomingLog il with (nolock) on ugd.ActionLogId = il.Id AND ugd.ActionTypeId IN
                                                                                                  (1, 2, 3, 4, 5, 6, 7,
                                                                                                   8, 9, 10, 11)
                         left join (Select Id, round(sum(Unit.GrossWeight*Line.Amount), 2) as GrossWeight
                                    from OP_IncomingLogCommonLineExtension Line with (nolock)
                                             join MD_ItemUnit Unit with (nolock) on Line.ItemId = Unit.TigerItemId and Line.ItemUnitCode = Unit.Code
                                    group by Id) GrossWeight on GrossWeight.Id = il.Id
                         left join OP_ClientVisitLog vl with (nolock) on vl.Id = ugd.ActionLogId and ugd.ActionTypeId = 30
                         left join MD_Salesman s with (nolock) on il.Firm = s.Firm and il.SalesmanRef = s.TigerId
                where cast(GpsDate as date) = @givenDate
                  and ugd.Firm = @firm
                  and ugd.ClientId = @clientId
                  and ugd.UserId = @userId
                order by ugd.GpsDate desc
                offset 0 rows
            )