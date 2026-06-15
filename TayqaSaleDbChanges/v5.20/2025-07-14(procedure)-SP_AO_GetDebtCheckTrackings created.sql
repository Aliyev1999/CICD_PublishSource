CREATE OR ALTER PROCEDURE [dbo].[SP_AO_GetDebtCheckTrackings] @firm smallint,
                                                    @isForwardDate bit,
                                                    @startDate datetime,
                                                    @endDate datetime,
                                                    @clientNameCodeGroupCode nvarchar(max) = NULL,
                                                    @reasonIds nvarchar(max) = NULL,
                                                    @controlledUserIds nvarchar(max) = NULL,
                                                    @status tinyint = NULL,
                                                    @projectId int = NULL,
                                                    @actNumber nvarchar(max) = NULL,
                                                    @customerSpecCode12345 nvarchar(max) = NULL,
                                                    @taskNumber nvarchar(max) = NULL,
                                                    @currentUserId bigint,
                                                    @sorting nvarchar(500) = NULL,
                                                    @maxResultCount int,
                                                    @skipCount int = 0,
                                                    @totalCount INT OUTPUT
AS
BEGIN

-- *Status
-- Pending = 1
-- Cancelled
-- Rejected
-- Accepted
-- Assigned
-- InProgress
-- Completed

    declare @Query nvarchar(max)='

declare @Result table(
						DebtCheckId int,
						TaskRequestId int,
						TaskNumber int,
						ProjectName nvarchar(100),
						FirmName nvarchar(100),
						ActNumber nvarchar(100),
						ClientCode nvarchar(150),
						ClientName nvarchar(150),
						InspectionType nvarchar(150),
						ControlledDate datetime,
						FinalDifferenceAmount float,
						OpenDifferenceAmount float,
						Status TINYINT,
						InitialDifference float,
						ControlledUser nvarchar(150),
						SalesmanCodeName nvarchar(150),
						SalesPersonHeadCodeName nvarchar(150),
						ForwardedDate datetime
						);
'

    set @Query = concat(@Query, '

with Data as(
select Ops.Id                                                              as DebtCheckId,
       Requests.Id                                                         as TaskRequestId,
       task.Id                                                             as TaskNumber,
       Project.Name                                                        as ProjectName,
       Firm.Name                                                           as FirmName,
       Ops.ActNo                                                           as ActNumber,
       Client.Code                                                         as ClientCode,
       Client.Name                                                         as ClientName,
       Inspection.Name                                                     as InspectionType,
       Ops.ControlDate                                                     as ControlledDate,
       isnull(Ops.InitialDifference, 0) - isnull(Finalized.FinalAmount, 0) as FinalDifferenceAmount,
       isnull(ops.InitialDifference,0)-isnull(Amount.Amount,0) as  OpenDifferenceAmount,
       Requests.Status                                                     as Status,
       Ops.InitialDifference                                               as InitialDifference,
       Controller.UserName                                                 as ControlledUser,
       nullif(concat(Salesman.Code, '' - '', Salesman.Name), '' - '')      as SalesmanCodeName,
       nullif(concat(Manager.Code, '' - '', Manager.Name), '' - '')        as SalesPersonHeadCodeName,
	   Requests.CreationTime as ForwardedDate

from WMM_TaskRequest Requests with (nolock)
         join AO_AuditOperation Ops with (nolock) on Ops.Id = Requests.SourceId
         join MD_Firm Firm with (nolock) on Firm.Nr = Ops.Firm
         join MD_Client Client with (nolock) on Client.TigerId = Ops.ClientId
         join MD_StopReason Inspection with (nolock) on Inspection.Id = Ops.ReasonId
         join AbpUsers Controller with (nolock) on Controller.Id = Ops.ControlUserId
         join F_GetPermittedUsers (@currentUserId) Tree on Tree.UserId = Requests.CreatorUserId
         join WMM_Project Project on Project.Id = Requests.ProjectId
		 left join WMM_Task task with(nolock) on task.Id=Requests.SourceId and Requests.SourceType=2
         left join (select AuditOperationId, sum(iif(Status = 1, Amount, 0)) FinalAmount, sum(Amount) as TotalAmount
                    from AO_AuditOperationLine with (nolock)
                    where Status <> 2
                    group by AuditOperationId) Finalized on Finalized.AuditOperationId = Ops.Id
		  --left join (select AuditOperationId, count(Id) as AuditOperationLineCount, sum(iif(Status = 1, Amount, 0)) Amount
    --                from AO_AuditOperationLine
    --                group by AuditOperationId) finalized on finalized.AuditOperationId = ops.Id
         left join (select AuditOperationId, count(Id) as AuditOperationLineCount, sum(Amount) Amount
                    from AO_AuditOperationLine
                    Where Status not in (2)
                    group by AuditOperationId) Amount on Amount.AuditOperationId = ops.Id
         left join MD_Salesman Salesman with (nolock) on Salesman.TigerId = Ops.SalesmanId and Salesman.Firm = Ops.Firm
         left join MD_Salesman Manager with (nolock) on Manager.TigerId = Ops.SalesPersonHeadId and Manager.Firm = Ops.Firm
where Requests.SourceType = 1 and Ops.Firm = @firm ')

    if @isForwardDate = 1
        set @Query = concat(@Query, ' and Requests.CreationTime between @startDate and @endDate ');

    if @isForwardDate = 0
        set @Query = concat(@Query, ' and Ops.ControlDate between @startDate and @endDate ')

    if @clientNameCodeGroupCode is not null
        set @Query = concat(@Query, ' and (Client.Code like ''%''+@clientNameCodeGroupCode+''%'' or Client.Name like ''%''+@clientNameCodeGroupCode+''%''
                                        or Client.Edino like ''%''+@clientNameCodeGroupCode+''%'') ')

    if @reasonIds is not null
        set @Query = concat(@Query, ' and (Ops.ReasonId in (select ltrim(Value) from F_SplitList(''', @reasonIds, ''',', ''','')))')

    if @controlledUserIds is not NULL
        set @Query = concat(@Query, 'and  (Ops.ControlUserId in (select ltrim(Value) from F_SplitList(''', @controlledUserIds, ''',', ''',''))) ')

    if @status is not null set @Query = concat(@Query, ' and Requests.Status = @status ')

    if @projectId is not null set @Query = concat(@Query, ' and Requests.ProjectId = @projectId ')

    if @actNumber is not null set @Query = concat(@Query, ' and Ops.ActNo like ''%''+@actNumber+''%''')

   if @customerSpecCode12345 is not null
    set @Query = concat(@Query, ' and (Client.SpecialCode like ''%'' + @customerSpecCode12345 + ''%'' or Client.SpecialCode2 like ''%'' + @customerSpecCode12345 + ''%'' or Client.SpecialCode3 like ''%'' + @customerSpecCode12345 + ''%'' or Client.SpecialCode4 like ''%'' + @customerSpecCode12345 + ''%'' or Client.SpecialCode5 like ''%'' + @customerSpecCode12345 + ''%'') ')


    if @taskNumber is not null 
    set @Query = concat(@Query, ' and task.Id like ''%''+@taskNumber+''%'' ')
    set @Query = concat(@Query, ')
insert into @Result(DebtCheckId  ,
						TaskRequestId,
						TaskNumber,
						ProjectName,
						FirmName,
						ActNumber,
						ClientCode ,
						ClientName ,
						InspectionType ,
						ControlledDate ,
						FinalDifferenceAmount,
						OpenDifferenceAmount ,
						Status ,
						InitialDifference ,
						ControlledUser ,
						SalesmanCodeName ,
						SalesPersonHeadCodeName,
						ForwardedDate)

         select * from Data
set @totalCount = (select count(*) from @Result)


select * from @Result
    ')
    if @skipCount is not null or @maxResultCount is not null
        set @Query = concat(@Query, ' order by  ' + isnull(@Sorting, 'ForwardedDate desc') + ' offset @skipCount rows fetch next @maxResultCount rows only')


    exec sp_executesql @Query,
         N'@firm smallint,@isForwardDate bit,@startDate datetime,@endDate datetime,@clientNameCodeGroupCode nvarchar(max) = NULL,
           @reasonIds nvarchar(max) = NULL,@controlledUserIds nvarchar(max) = NULL,@status tinyint = NULL,@projectId int = NULL,
           @actNumber nvarchar(max) = NULL,@customerSpecCode12345 nvarchar(max) = NULL,@taskNumber nvarchar(max) = NULL,
           @currentUserId bigint, @sorting nvarchar(500) = NULL,@maxResultCount int,@skipCount int = 0,@totalCount INT OUTPUT',
         @firm = @firm,
         @isForwardDate = @isForwardDate,
         @startDate = @startDate,
         @endDate = @endDate,
         @clientNameCodeGroupCode = @clientNameCodeGroupCode,
         @reasonIds = @reasonIds,
         @controlledUserIds = @controlledUserIds,
         @status = @status,
         @projectId = @projectId,
         @actNumber = @actNumber,
         @customerSpecCode12345 = @customerSpecCode12345,
         @taskNumber = @taskNumber,
         @currentUserId = @currentUserId,
         @sorting = @sorting,
         @maxResultCount = @maxResultCount,
         @skipCount = @skipCount,
         @totalCount = @totalCount out


END