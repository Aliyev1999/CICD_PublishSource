CREATE OR ALTER   procedure [dbo].[SP_IM_GetAssetStateUpdateHistory]
(
	@userId bigint,
	@assetId smallint,
	@beginDate datetime,
	@endDate datetime
)
As
Begin

with UniqueAttachments as (select ReferenceId,
                                  string_agg(SecureUrl, ',') AS Files
                           from IM_AssetAttachment with (nolock)
                           where Type = 6
                           group by ReferenceId)
select IsAvailable                            as IsAvailable,
       IsRepairNeeded                         as IsRepairNeeded,
       location.Name                          as LocationType,
       Note                                   as Note,
       content.Name                           as State,
       astatus.RegisteredDate                 as StatusUpdateDate,
       concat(users.Name, ' ', users.Surname) as StatusUpdaterUserFullName,
       astatus.CreatorUserId                  as StatusUpdaterUserId,
       isnull(attachments.Files, '')          as Files

from IM_AssetStatusUpdateHistory astatus with (nolock)
         left join IM_StaticContent content with (nolock) on astatus.StateId = content.Id
         left join IM_StaticContent location with (nolock) on astatus.LocationType = location.Id
         join AbpUsers users with (nolock) on users.Id = astatus.CreatorUserId
         left join UniqueAttachments attachments with (nolock) on attachments.ReferenceId = astatus.Id

where astatus.AssetId = @assetId and astatus.RegisteredDate>=@beginDate and astatus.RegisteredDate<=@endDate 
order by astatus.RegisteredDate desc

end