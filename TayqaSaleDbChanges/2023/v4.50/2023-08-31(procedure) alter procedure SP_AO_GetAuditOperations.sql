
ALTER   PROCEDURE [dbo].[SP_AO_GetAuditOperations] @firm smallint null,
												 @startDate datetime null,
												 @endDate datetime null,  
												 @isActDate bit null,
												 @clientNameCodeGroupCode nvarchar(max) null,
												 @reasonIds nvarchar(max) null ,
												 @controlledUserIds nvarchar(max) null,
												 @debtCheckOperationStatus tinyint null, 
												 @isConfirmed bit null, 
												 @actNumber nvarchar(max) null,
												 @customerSpecCode12345 nvarchar(max) null, 
												 @userSpecCode12345 nvarchar(max) null, 
												 @closerUserIds nvarchar(max) null, 
												 @sorting nvarchar(max) null,
												 @currentUserId bigint,
												 @uId uniqueidentifier null

									AS	begin
declare @Query nvarchar(max) ='
select operation.Id                                              as Id,
	   operation.UId											 as UId,
       firm.Name                                                 as FirmName,
       operation.ControlDate                                     as ControlledDate,
       operation.ActDate                                         as ActDate,
       operation.ActNo                                           as ActNumber,
       controlledUser.UserName                                   as ControlledUser,
       reason.Name                                               as InspectionType,
	   operation.IsConfirmed                                     as ConfirmStatus,
       operation.ClientDebt                                      as CurrentDebt,
       operation.ActualDebt                                      as ActualDebt,
       operation.OperationStatus                                 as OperationStatus,
       operation.LastModificationTime                            as LastOperationDate,
       ModifierUser.UserName                                     as LastOperationMaker,
       cast(iif(attachment.AuditOperationId is not null, 1, 0) as bit)        as IsImageExists,
       isnull(finalized.AuditOperationLineCount, 0)              as AuditOperationLine,
       operation.InitialDifference                               as InitialDifference,
       operation.InitialDifference - isnull(finalized.Amount, 0) as FinalDifferenceAmount,
	   operation.InitialDifference-isnull(Amount.Amount,0) as  OpenDifferenceAmount,
       cast(iif(status.AuditOperationId is not null, 1, 0) as bit)                  as IsAllOperationLinesConfirmed,
	   client.Code                                               as ClientCode,
	   client.Name                                               as ClientName,
	   avoidanceReason.Name                                      as AvoidanceReason,
	   operation.SpeCode1										 as SpeCode1,
	   operation.SpeCode2										 as SpeCode2,
	   operation.SpeCode3										 as SpeCode3,
	   operation.ControlUserId									 as ControlUserId

from AO_AuditOperation operation with (nolock)
         join MD_Firm firm with (nolock) on operation.Firm = firm.Nr and firm.IsActive = 1
         join MD_Client client with (nolock)
              on client.TigerId = operation.ClientId and Client.IsDeleted = 0 and client.Status = 0 and Client.Firm = operation.Firm
         join AbpUsers controlledUser with (nolock)
              on controlledUser.Id = operation.ControlUserId and controlledUser.IsActive = 1 and controlledUser.IsDeleted = 0
	     join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = controlledUser.Id
		 left join UIM_UserProperty specodes with(nolock) on specodes.UserId=controlledUser.Id and specodes.Firm=operation.Firm 
         left join MD_StopReason reason with (nolock) on operation.ReasonId = reason.Id and reason.IsActive = 1 and reason.IsDeleted = 0 and Type=22
         left join MD_StopReason avoidanceReason with (nolock) on operation.TerminationOrCancelReasonId = avoidanceReason.Id and avoidanceReason.IsActive = 1 and avoidanceReason.IsDeleted = 0 and (avoidanceReason.Type  = 24 Or avoidanceReason.Type = 25)
         left join AbpUsers ModifierUser with (nolock) 
                   on ModifierUser.Id = operation.LastModifierUserId and ModifierUser.IsActive = 1 and ModifierUser.IsDeleted = 0
         left join (SELECT distinct AuditOperationId
                    FROM AO_AuditOperationLineAttachment attachment
                             join AO_auditOperationLine line on line.Id = attachment.AuditOperationLineId) attachment
                   on attachment.AuditOperationId = operation.Id
         left join ( select AuditOperationId, count( Id) as AuditOperationLineCount, sum(iif (Status=1,Amount,0))  Amount 
                    from AO_AuditOperationLine  
                    group by AuditOperationId) finalized on finalized.AuditOperationId = operation.Id
		 left join ( select AuditOperationId, count( Id) as AuditOperationLineCount, sum(Amount)  Amount 
                    from AO_AuditOperationLine  Where Status not in (2)
                    group by AuditOperationId) Amount on Amount.AuditOperationId = operation.Id
		 left join (Select  AuditOperationId from AO_AuditOperationLine 
					except 
					select distinct AuditOperationId from AO_AuditOperationLine where Status in (0,2)) status on status.AuditOperationId=operation.Id
		where operation.IsDeleted = 0 and firm.Nr=@firm '
declare @WhereFilter nvarchar (max)

if @isActDate = 0 set @WhereFilter = '
 and ( operation.ControlDate between @startDate and @endDate) '

if @isActDate = 1 set @WhereFilter =  '
 and (operation.ActDate between @startDate and @endDate)  '

set @Query = CONCAT(@Query, @WhereFilter)
if @uId is not null set @Query =  ' and (operation.UId = @uId)  '
if @isConfirmed is not null set @Query=concat(@Query,' and operation.IsConfirmed=@isConfirmed ')
if @clientNameCodeGroupCode is not null set @Query = concat(@Query, ' and (client.Code like ''%''+@clientNameCodeGroupCode+''%'' or client.Name like ''%''+@clientNameCodeGroupCode+''%''or Client.Edino like ''%''+@clientNameCodeGroupCode+''%'') ')
if @reasonIds is not null set @Query = concat(@Query,' and (reason.Id in (select ltrim(Value) from F_SplitList(''', @controlledUserIds, ''',', ''',''))) ')
if @controlledUserIds is not null set @Query = concat(@Query, ' and (operation.ControlUserId in (select ltrim(Value) from F_SplitList(''', @controlledUserIds, ''',', ''',''))) ')
if @debtCheckOperationStatus is not null set @Query = concat (@Query, ' and operation.OperationStatus =@debtCheckOperationStatus' )
if @actNumber is not null set @Query = concat(@Query, ' and operation.ActNo like ''%''+@actNumber ')
if @customerSpecCode12345 is not null
    set @Query = concat(@Query,
                        ' and (client.SpecialCode like ''%''+@customerSpecCode12345+''%'' or client.SpecialCode2 like ''%''+@customerSpecCode12345+''%'' or client.SpecialCode3 like ''%''+@customerSpecCode12345+''%'' or client.SpecialCode4 like ''%''+@customerSpecCode12345+''%'' or client.SpecialCode5 like ''%''+@customerSpecCode12345+''%'') ')
if @userSpecCode12345 is not null
    set @Query = concat(@Query,
                        ' and (specodes.Specode1 like ''%''+@userSpecCode12345+''%'' or specodes.Specode2 like ''%''+@userSpecCode12345+''%'' or specodes.Specode3 like ''%''+@userSpecCode12345+''%'' or specodes.Specode4 like ''%''+@userSpecCode12345+''%'' or specodes.Specode5 like ''%''+@userSpecCode12345+''%'') ')
if @closerUserIds is not null set @Query = concat(@Query, ' and (operation.LastModifierUserId in (select ltrim(Value) from F_SplitList(''',@closerUserIds, ''',', ''','')))  ')
if @sorting is null set @Query = concat(@Query, ' order by operation.CreatedDate desc '  )
if @sorting is not null set @Query=concat(@Query, ' order by ' + @sorting )
	print @Query
 exec dbo.sp_executesql @Query,N'
												 @firm smallint = null, 
												 @startDate datetime = null, 
												 @endDate datetime = null, 
												 @isActDate bit= null, 
												 @clientNameCodeGroupCode nvarchar(max)= null,
												 @reasonIds nvarchar(max) =null ,
												 @controlledUserIds nvarchar(max) =null, 
												 @debtCheckOperationStatus tinyint=0, 
												 @isConfirmed bit= null, 
												 @actNumber nvarchar(max) = null,
												 @customerSpecCode12345 nvarchar(max) =null, 
												 @userSpecCode12345 nvarchar(max) = null, 
												 @closerUserIds nvarchar(max)= null, 
												 @sorting nvarchar(max) = null,
												 @currentUserId bigint,
												 @uId uniqueidentifier null',
												 @firm =@firm,
												 @startDate =@startDate,
												 @endDate =@endDate,
												 @isActDate =@isActDate,
												 @clientNameCodeGroupCode =@clientNameCodeGroupCode,
												 @reasonIds =@reasonIds ,
												 @controlledUserIds =@controlledUserIds,
												 @debtCheckOperationStatus =@debtCheckOperationStatus,
												 @isConfirmed =@isConfirmed,
												 @actNumber =@actNumber,
												 @customerSpecCode12345 =@customerSpecCode12345,
												 @userSpecCode12345 =@userSpecCode12345,
												 @closerUserIds =@closerUserIds,
												 @sorting =@sorting,
												 @currentUserId=@currentUserId,
												 @uId=@uId
				end