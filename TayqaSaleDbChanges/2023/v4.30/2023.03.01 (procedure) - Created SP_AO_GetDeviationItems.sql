CREATE PROCEDURE [dbo].[SP_AO_GetDeviationItems] @currentUserId INT,
                                                 @auditVisitId INT,
                                                 @firm SMALLINT
AS

-- Author: TayqaTech for TayqaSale (Shahri Yahyayeva)
-- Date: 01.03.2022 
-- Query: returns the result of details for the selected audit operation

BEGIN
    select cast(line.Id as int)                                                as OperationLineId,
           reason.Name                                                         as ReasonName,
           line.Amount                                                         as Amount,
           line.Description                                                    as Description,
           cast(line.Status as tinyint)                                        as Status,
           cast(iif(attachment.AuditOperationLineId is not null, 1, 0) as bit) as HasAttachment
    from AO_AuditOperationLine line with (nolock)
             left join MD_StopReason reason with (nolock) on line.ReasonId = reason.Id and reason.IsActive = 1 and reason.IsDeleted = 0
             join AbpUsers users with (nolock) on line.CreatorUserId = users.Id and users.IsActive = 1 and users.IsDeleted = 0
             left join (select distinct AuditOperationLineId from AO_AuditOperationLineAttachment with (nolock)) attachment on attachment.AuditOperationLineId = line.Id
             join AO_AuditOperation operation with (nolock) on operation.Id = line.AuditOperationId and operation.IsDeleted = 0
    where operation.Id = @AuditVisitId
--      and operation.CreatedUserId = @currentUserId
      and operation.Firm = @firm
    order by line.CreationTime desc
END