CREATE OR ALTER PROCEDURE [dbo].[SP_IM_GetAssetBindingsForApp](
    @userId bigint,
    @firm smallint,
    @beginDate datetime,
    @endDate datetime
)
AS
BEGIN

with UniqueAttachments as (
    select 
        ReferenceId,
        string_agg(SecureUrl, ',') AS Files 
    from IM_AssetAttachment with (nolock)
    where Type IN(1,2,3)
    group by ReferenceId
)
    select  binding.Id             as OperationId,
           cast(binding.AssetId as bigint) as AssetId,
           AssetNr                         as AssetNr,
           item.TigerId                    as ItemId,
           item.Code                       as ItemCode,
           item.Name                       as ItemName,
           ActNo                           as ActNo,
           binding.BindingType             as BindingType,
           binding.BindingReference        as BindingReference,
           binding.PlannedReceivingPerson  as ReceivingPerson,
           PlannedHandoverDate             as PlannedBindingDate,
           PlannedReturnDate               as PlannedReturnDate,
           content.Name                    as BindingReason,
           AuditDayCount                   as AuditDayCount,
           binding.Note                    as Note,
           binding.Status                  as Status,
           ISNULL(attachments.Files, '') AS Files

    from IM_AssetBinding binding with (nolock)
             join IM_Asset asset with (nolock) on asset.Id = binding.AssetId and asset.Firm = binding.Firm
             join MD_Item item with (nolock) on item.TigerId = asset.ItemId and binding.Firm = item.Firm
             left join UniqueAttachments attachments on attachments.ReferenceId = binding.Id
             left join IM_StaticContent content with (nolock) on content.Id = binding.BindingReasonId

    where binding.Firm = @Firm
      and cast(binding.PlannedHandoverDate as date) between cast(@beginDate as date) and cast(@endDate as date)
      and binding.AssignedUserId = @UserId
      and binding.Status <> 4
END
