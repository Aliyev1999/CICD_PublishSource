CREATE PROCEDURE [dbo].[SP_AO_GetUsersAudit] @userId INT,
                                            @beginDate DATETIME,
                                            @endDate DATETIME,
                                            @clientId INT NULL,
								    @firm SMALLINT
AS

-- Author: TayqaTech for TayqaSale (Shahri Yahyayeva) on 01.03.2022 
-- Query: returns the result of hybrid user's report for audit operations
-- Ticket: 

BEGIN
    select operation.Id                                              as AuditVisitId,
           client.Code                                               as ClientCode,
           client.Name                                               as ClientName,
           client.Edino                                              as ClientEdino,
           cast(operation.ActDate as date)                           as ActDate,
           operation.ActNo                                           as ActNo,
           operation.ClientDebt                                      as ClientDebt,
           operation.ActualDebt                                      as ActualDebt,
           operation.InitialDifference - isnull(finalized.Amount, 0) as FinalDifference,
           cast(operation.OperationStatus as tinyint)                as OperationStatus,
           cast(operation.IsConfirmed as tinyint)                    as ConfirmationStatus,
           cast(isnull(finalized.AuditOperationLineCount, 0) as int) as DifferenceCount
    from AO_AuditOperation operation with (nolock)
             join AbpUsers users with (nolock) on users.Id = operation.CreatedUserId and users.IsActive = 1 and users.IsDeleted = 0
             join Md_Client client with (nolock)
                  on client.TigerId = operation.ClientId and client.IsDeleted = 0 and client.Status = 0 and client.Firm = operation.Firm
             left join (select AuditOperationId, count(Id) as AuditOperationLineCount, sum(iif(Status = 1, Amount, 0)) Amount
                        from AO_AuditOperationLine with(nolock)
                        group by AuditOperationId) finalized on finalized.AuditOperationId = operation.Id
    where operation.IsDeleted = 0
      and operation.Firm = @firm
      and cast(operation.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
      and operation.CreatedUserId = @userId
      and (operation.ClientId = @ClientId or @ClientId is null)
	  order by operation.CreatedDate desc
END


