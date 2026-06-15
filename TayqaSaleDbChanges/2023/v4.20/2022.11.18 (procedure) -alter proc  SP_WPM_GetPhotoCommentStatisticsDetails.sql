ALTER procedure [dbo].[SP_WPM_GetPhotoCommentStatisticsDetails](@clientCodeOrName nvarchar(50) null,
                                                                 @startDate datetime null,
                                                                 @endDate datetime null,
                                                                 @reasons nvarchar(MAX) null,
    --@comments nvarchar(MAX) null,
                                                                 @sourceTypes nvarchar(MAX) null)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
with Data as (select Users.UserName                                                                                       as UserName,
                     coalesce(Tickets.ClientId, Responses.ClientId, VisitAndShowCase.ClientId, StateUpdate.ClientTigerId) as ClientId,
                     Comments.Comment                                                                                     as Comment,
                     Comments.CreationTime                                                                                as Date,
                     Comments.CreatorUserId                                                                               as UserId,
                     Reasons.Id                                                                                           as ReasonId,
                     Reasons.Name                                                                                         as ReasonName,
                     Comments.SourceType                                                                                  as SourceType,
                     --coalesce(WPM.Url, CHL.Url, VisitAndShowCase.FilePath, StateUpdateImg.ImagePath)                      as Url,
                     coalesce(WPM.SecureUrl, CHL.SecureUrl, VisitAndShowCase.SecureUrl, StateUpdateImg.SecureUrl)         as Url


              from MD_PhotoComment Comments with (nolock)
                       join MD_StopReason Reasons with (nolock) on Comments.ReasonId = Reasons.Id and Reasons.Type = 9
                       join AbpUsers Users with (nolock) on Users.Id = Comments.CreatorUserId

                       left join WPM_Attachment WPM with (nolock) on WPM.Type = 3 and WPM.Id = Comments.ReferenceId and Comments.SourceType = 2
                       left join WPM_TaskTicketAction Actions with (nolock) on Actions.Id = WPM.ReferenceId
                       left join WPM_TaskTicket Tickets with (nolock) on Tickets.Id = Actions.TaskTicketId

                       left join CHL_Attachment CHL with (nolock) on CHL.Type = 3 and CHL.Id = Comments.ReferenceId and Comments.SourceType = 1
                       left join CHL_UserSurveyResponseDetail Details with (nolock) on Details.Id = CHL.ReferenceId
                       left join CHL_UserSurveyResponse Responses with (nolock) on Responses.Id = Details.UserSurveyResponseId

                       left join OP_FileUploadLog VisitAndShowCase with (nolock)
                                 on (VisitAndShowCase.Id = Comments.ReferenceId and VisitAndShowCase.ContentType = 2 and Comments.SourceType = 3) or -- Visit
                                    (VisitAndShowCase.Id = Comments.ReferenceId and VisitAndShowCase.ContentType = 1 and Comments.SourceType = 5) -- Client photos

                       left join IM_InventoryStateHistoryImage StateUpdateImg with (nolock) on StateUpdateImg.Id = Comments.ReferenceId and Comments.SourceType = 4
                       left join IM_InventoryStateHistory StateUpdate with (nolock) on StateUpdate.Id = StateUpdateImg.InventoryStateHistoryId

              where Comments.CreationTime between @startDate and @endDate)

select Clients.Name    as ClientName,
       Clients.Code    as ClientCode,
       Clients.TigerId as ClientId,
       Clients.Edino   as Edino,
       Data.Comment    as Comment,
       Data.Date       as Date,
       Data.UserName   as UserName,
       Data.ReasonName as ReasonName,
       Data.ReasonId   as ReasonId,
       Data.SourceType as SourceType,
       Data.Url        as Url

from Data
         join MD_Client Clients with (nolock) on Data.ClientId = Clients.TigerId and Clients.Firm = 9 and Clients.IsDeleted = 0
'

    IF @clientCodeOrName IS NOT NULL
        SET @Query = CONCAT(@Query,
                            ' AND (Clients.Code LIKE ''%'' + @clientCodeOrName + ''%''  OR Clients.Name LIKE ''%'' + @clientCodeOrName + ''%'' OR Clients.Edino LIKE N''%'' + @clientCodeOrName + ''%'')')

    IF @reasons IS NOT NULL SET @Query = CONCAT(@Query, ' AND Data.ReasonId IN (SELECT * FROM F_SplitList(@reasons, '',''))')

    IF @sourceTypes IS NOT NULL SET @Query = CONCAT(@Query, ' AND Data.SourceType IN (SELECT * FROM F_SplitList(@sourceTypes, '',''))')

    EXEC sp_executesql @Query,
         N'@clientCodeOrName nvarchar(50) null,
              @startDate datetime null,
              @endDate datetime null,
              @reasons nvarchar(MAX) null,
              @sourceTypes nvarchar(MAX) null',
         @clientCodeOrName = @clientCodeOrName,
         @startDate = @startDate,
         @endDate = @endDate,
         @reasons = @reasons,
         @sourceTypes = @sourceTypes
END
go



