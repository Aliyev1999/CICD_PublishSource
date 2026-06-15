CREATE OR ALTER function [dbo].[F_MGM_GetConfirmationOperations](
    @userId int,
    @beginDate datetime,
    @endDate datetime,
    @isCompleted bit
    )
    returns table
        as
        return(with Data as (select ILog.Id,
                                    ILog.DocId,
                                    ILog.DocType,
                                    ILog.RegisteredDate,
                                    ILog.ProcessDate,
                                    ILog.ClientId,
                                    ILog.UserId,
                                    ILog.FeedbackUserId,
                                    ILog.CurrencyType,
                                    ILog.Firm,
                                    ILog.Note,
                                    Users.Name           as UserName,
                                    Users.Surname        as UserSurname,
                                    Users.Code           as UserCode,
                                    Photo.SecureUrl      as UserPhoto,
                                    FeedbackUser.Name    as FeedbackUserName,
                                    FeedbackUser.Surname as FeedbackUserSurname,
                                    Currency.Code        as CurrencyCode,
									Audit.RejectionTime,
                                    Audit.RejecterUserId,
									Audit.ConfirmationTime,
                                    Audit.ConfirmerUserId
                             from OP_ThirdPartyIncomingLog ILog with (nolock)
                                      inner join AbpUsers Users with (nolock) on Users.Id = ILog.UserId
                                      inner join F_UIM_GetOrganizationTreeUsers(@userId) OrgUsers on OrgUsers.UserId = Users.Id
                                      left join AbpUserProfilePhoto Photo with (nolock) on Photo.UserId = Users.Id
                                      left join OP_ThirdPartyAuditLog Audit with (nolock) on Audit.RequestId = ILog.Id
                                      left join AbpUsers FeedbackUser with (nolock) on FeedbackUser.Id = ILog.FeedbackUserId
                                      left join MD_Currency Currency with (nolock)
                                                on Currency.Type = ILog.CurrencyType and Currency.Firm = ILog.Firm
                             where (@beginDate is null or ILog.RegisteredDate between @beginDate and @endDate)),

                    StatusCalculations as (
                        -- DocType 0-4: Common Line Status
                        select ILog.Id,
                               case
                                   when isnull(queue.ProcessingStatus, 0) = 1 then 1
                                   when glog.ImportResult = 970 or rqueue.step = 11 then 6
                                   when (Line2.Amount - isnull(LineResultAmount.Amount, 0)) = 0 then 2
                                   when glog.ImportResult = 969 or rqueue.step = 11 then 3
                                   else 5
                                   end as Status
                        from OP_ThirdPartyIncomingLog ILog with (nolock)
                                 left join OP_GeneralLog glog with (nolock) on ILog.Id = glog.RequestId
                                 left join OP_RequestQueue rqueue with (nolock) on rqueue.Id = ILog.Id
                                 left join OP_ThirdPartyRequestQueue queue with (nolock) on queue.Id = ILog.Id
                                 left join (select Id, sum(Amount) as Amount
                                            from OP_ThirdPartyIncomingLogCommonLineExtension with (nolock)
                                            group by Id) Line2 on ILog.Id = Line2.Id
                                 left join (select Id, sum(Amount) as Amount
                                            from OP_ThirdPartyCommonLineResultLog with (nolock)
                                            group by Id) LineResultAmount on ILog.Id = LineResultAmount.Id
                        where ILog.DocType in (0, 1, 2, 3, 4)

                        union all

                        -- DocType 5-6: Cash Line Status
                        select ILog.Id,
                               case
                                   when isnull(queue.ProcessingStatus, 0) = 1 then 1
                                   when glog.ImportResult = 970 or rqueue.step = 11 then 6
                                   when (Line.Amount - isnull(LineResultAmount.Amount, 0)) = 0 then 2
                                   when glog.ImportResult = 969 or rqueue.step = 11 then 3
                                   else 5
                                   end as Status
                        from OP_ThirdPartyIncomingLog ILog with (nolock)
                                 left join OP_GeneralLog glog with (nolock) on ILog.Id = glog.RequestId
                                 left join OP_RequestQueue rqueue with (nolock) on rqueue.Id = ILog.Id
                                 left join OP_ThirdPartyRequestQueue queue with (nolock) on queue.Id = ILog.Id
                                 left join (select Id, sum(Amount) as Amount
                                            from OP_ThirdPartyIncomingLogCashExtension with (nolock)
                                            group by Id) Line on ILog.Id = Line.Id
                                 left join (select Id, sum(Amount) as Amount
                                            from OP_ThirdPartyCashResultLog with (nolock)
                                            group by Id) LineResultAmount on ILog.Id = LineResultAmount.Id
                        where ILog.DocType in (5, 6)

                        union all

                        -- DocType 21-24: Warehouse Operation Status
                        select ILog.Id,
                               case
                                   when isnull(queue.ProcessingStatus, 0) = 1 then 1
                                   when queue.ActionType = 3 then 6
                                   when (LineAmount.Amount - isnull(LineResultAmount.Amount, 0)) = 0 then 2
                                   when isnull(LineResultAmount.Amount, 0) = 0 then 3
                                   else 5
                                   end as Status
                        from OP_ThirdPartyIncomingLog ILog with (nolock)
                                 left join OP_ThirdPartyRequestQueue queue with (nolock) on queue.Id = ILog.Id
                                 left join (select Extension.Id,
                                                   sum(iif(ResultLog.Quantity is not null, ResultLog.Quantity, Extension.Quantity)) as Amount
                                            from OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Extension with (nolock)
                                                     left join OP_ThirdPartyWarehouseOperationLineResultLog ResultLog with (nolock)
                                                               on Extension.Id = ResultLog.Id and Extension.ItemId = ResultLog.ItemId
                                            group by Extension.Id) LineAmount on ILog.Id = LineAmount.Id
                                 left join (select Id, sum(Quantity) as Amount
                                            from OP_ThirdPartyWarehouseOperationLineResultLog with (nolock)
                                            group by Id) LineResultAmount on ILog.Id = LineResultAmount.Id
                        where ILog.DocType in (21, 22, 23, 24)),

                    AmountCalculations as (
                        -- DocType 0-4
                        select Extension.Id,
                               sum(isnull(ResultLog.Amount, Extension.Amount) * Extension.Price) - Extension.DiscountAmount as Amount
                        from OP_ThirdPartyIncomingLogCommonLineExtension Extension with (nolock)
                                 left join OP_ThirdPartyCommonLineResultLog ResultLog with (nolock)
                                           on Extension.Id = ResultLog.Id
                                               and ResultLog.ItemId = Extension.ItemId
                                               and ResultLog.IsPromo = Extension.IsPromo
                        where Extension.IsPromo = 0
                           or ResultLog.IsPromo = 0
                        group by Extension.Id, Extension.DiscountAmount

                        union all

                        -- DocType 5-6
                        select Id,
                               sum(Amount) as Amount
                        from OP_ThirdPartyIncomingLogCashExtension with (nolock)
                        group by Id)

                              select top 100000
							         concat(Data.UserName, ' ', Data.UserSurname)    as Salesman,
                                     Data.UserCode                                   as SalesmanCode,
                                     Data.UserPhoto                                  as SalesmanPhoto,
                                     case
                                         when Data.DocType in (0, 1, 2, 3, 4, 5, 6) then Client.Name
                                         when Data.DocType = 21 then WarehouseIn.Name
                                         when Data.DocType = 22 then WarehouseOut.Name
                                         else WarehouseIn.Name + '-' + WarehouseOut.Name
                                         end                                         as ClientName,
                                     case
                                         when Data.DocType in (0, 1, 2, 3, 4, 5, 6) then Client.Code
                                         when Data.DocType = 21 then cast(WarehouseIn.Nr as nvarchar(max))
                                         when Data.DocType = 22 then cast(WarehouseOut.Nr as nvarchar(max))
                                         else cast(WarehouseIn.Nr as nvarchar(max)) + '-' + cast(WarehouseOut.Nr as nvarchar(max))
                                         end                                         as ClientCode,
                                     Data.Id                                         as RequestId,
                                     cast(Data.DocId as nvarchar(50))                as DocId,
                                     Data.RegisteredDate as [Date],
                                     case
                                         when Data.DocType in (21, 22, 23, 24) then cast(0 as float)
                                         else round(isnull(calculations.Amount, 0), 2)
                                         end                                         as Amount,
                                     isnull(Data.CurrencyCode, 'AZN')                as CurrencyCode,
                                     Data.Note,
                                     cast(Data.DocType as tinyint)                   as DocType,
                                     case
                                         when @isCompleted = 1 then concat(Data.FeedbackUserName, ' ', Data.FeedbackUserSurname)
                                         else null
                                         end                                         as CommentName,
                                     case
                                         when @isCompleted = 1 then coalesce(Data.RejectionTime, Data.ConfirmationTime)
                                         else null
                                         end                                         as CommentDate,
                                     case
                                         when @isCompleted = 1 then StatusCalc.Status
                                         else null
                                         end                                         as CommentStatus
                              from Data
                                       left join MD_Client Client with (nolock)
                                                 on Data.ClientId = Client.TigerId and Data.Firm = Client.Firm
                                       left join OP_ThirdPartyIncomingLogWarehouseOperationExtension WarehouseExt with (nolock)
                                                 on WarehouseExt.Id = Data.Id
                                       left join MD_Warehouse WarehouseIn with (nolock)
                                                 on WarehouseExt.WarehouseIn = WarehouseIn.Nr and WarehouseIn.Firm = Data.Firm
                                       left join MD_Warehouse WarehouseOut with (nolock)
                                                 on WarehouseExt.WarehouseOut = WarehouseOut.Nr and WarehouseOut.Firm = Data.Firm
                                       left join AmountCalculations calculations on Data.Id = calculations.Id
                                       left join StatusCalculations StatusCalc on Data.Id = StatusCalc.Id
                              where (
                                  (@isCompleted = 0 and (Data.RejecterUserId is null and Data.ConfirmerUserId is null))
                                      or
                                  (@isCompleted = 1 and (Data.RejecterUserId is not null or Data.ConfirmerUserId is not null))
                                  )
								  order by Data.RegisteredDate desc

								
 )
