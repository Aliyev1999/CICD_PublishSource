Create or ALTER PROCEDURE [dbo].[SP_MGM_GetPhotoGalleryData] 
												   @firm smallint ,
@userId BIGINT,
                                                   @begin datetime2,
                                                   @end datetime2,
                                                   @takeCount int,
                                                   @skipCount int
AS
BEGIN

    if @takeCount is null or @takeCount = 0 set @takeCount = 1000000
    if @skipCount is null or @skipCount = 0 set @skipCount = 0;

    with Data as (
        -- Workplan / Task images
        select distinct Header.Firm             as Firm,
                        Files.Id                as Id,
                        Files.SecureUrl         as Url,
                        2                       as SourceType,
                        Header.UserId           as UserId,
                        Header.ClientId         as ClientId,
                        Detail.CreatedDate      as Date,
                        Detail.CreatedLatitude  as OperationLatitude,
                        Detail.CreatedLongitude as OperationLongitude
        from WPM_Attachment Files with (nolock)
                 join WPM_TaskTicketAction Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join WPM_TaskTicket Header with (nolock) on Header.Id = Detail.TaskTicketId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
                 join WPM_TaskAction actions with (nolock) on actions.Id = Detail.ActionId
        where Header.CreatedDate between @begin and @end
          and Files.Type = 3
          and actions.ActionType = 1
		  And Header.Firm=@firm

        union

        -- Static surveys
        select distinct Header.Firm             as Firm,
                        Files.Id                as Id,
                        Files.SecureUrl         as Url,
                        1                       as SourceType,
                        Header.UserId           as UserId,
                        Header.ClientId         as ClientId,
                        Header.SavedDate        as Date,
                        Header.CreatedLatitude  as OperationLatitude,
                        Header.CreatedLongitude as OperationLongitude
        from CHL_Attachment Files with (nolock)
                 join CHL_UserSurveyResponseDetail Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join CHL_UserSurveyResponse Header with (nolock) on Header.Id = Detail.UserSurveyResponseId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
        where Header.SavedDate between @begin and @end
          and Files.Type = 3
		  and Header.Firm=@firm

        union

        -- Dynamic surveys
        select distinct Header.Firm             as Firm,
                        Files.Id                as Id,
                        Files.SecureUrl         as Url,
                        1                       as SourceType,
                        Header.UserId           as UserId,
                        Header.ClientId         as ClientId,
                        Header.SavedDate        as Date,
                        Header.CreatedLatitude  as OperationLatitude,
                        Header.CreatedLongitude as OperationLongitude
        from CHL_Attachment Files with (nolock)
                 join CHL_UserDynamicSurveyResponseDetail Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join CHL_UserSurveyResponse Header with (nolock) on Header.Id = Detail.UserSurveyResponseId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
        where Header.SavedDate between @begin and @end 
          and Files.Type = 3
		  and Header.Firm=@firm

        union

        -- Visit and client photos
        select distinct Files.Firm                       as Firm,
                        Files.Id                         as Id,
                        Files.SecureUrl                  as Url,
                        iif(Files.ContentType = 1, 5, 3) as SourceType, -- 3: visit, 5: client
                        Files.UploadedUserId             as UserId,
                        Files.ClientId                   as ClientId,
                        Files.FileCreatedDate            as Date,
                        nullif(Files.Latitude, 0)        as OperationLatitude,
                        nullif(Files.Longitude, 0)       as OperationLongitude
        from OP_FileUploadLog Files with (nolock)
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Files.UploadedUserId
        where Files.FileCreatedDate between @begin and @end and Files.Firm=@firm


        union

        -- Inventory
        select distinct Header.Firm          as Firm,
                        Files.Id             as Id,
                        Files.SecureUrl      as Url,
                        4                    as SourceType,
                        Header.CreatorUserId as UserId,
                        Header.ClientTigerId as ClientId,
                        Header.CreatedDate   as Date,
                        null                 as OperationLatitude,
                        null                 as OperationLongitude
        from IM_InventoryStateHistoryImage Files with (nolock)
                 join IM_InventoryStateHistory Header with (nolock) on Header.Id = Files.InventoryStateHistoryId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.CreatorUserId
        where Header.CreatedDate between @begin and @end and Header.Firm=@firm)

    select Data.Url                                                                         as PhotoUrl,
           Data.Id,
           Data.SourceType,
           Client.Code                                                                      as ClientCode,
           Client.Name                                                                      as ClientName,
           CASE
               when Client.Latitude = 0 or Client.Latitude is null or OperationLatitude = 0 or OperationLatitude is null
                   then null
               when
                   geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(geography::Point(OperationLatitude, OperationLongitude, 4326)) <=
                   300 THEN CAST(1 AS TINYINT)
               when
                   geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(geography::Point(OperationLatitude, OperationLongitude, 4326)) >
                   300 THEN CAST(2 AS TINYINT)
               ELSE 0
               END                                                                          as LocationType,
           Users.Id                                                                         as UserId,
           CONCAT(Users.Name, ' ', Users.Surname)                                           as UserName,
           Data.Date                                                                        as Date,
           CAST(IIF(Reaction.LikedCount > 0 or Reaction.dislikedCount > 0, 1, NULL) as BIT) as IsLiked,
           CAST(IIF(Comment.Count > 0, 1, NULL) as BIT)                                     as HasComment,
           CAST(Reaction.LikedCount AS SMALLINT)                                            AS LikedCount,
           CAST(Reaction.DislikedCount AS SMALLINT)                                         AS DislikedCount,
           CAST(Comment.Count AS SMALLINT)                                                  AS CommentCount,
           IIF(Reacted.ReferenceId IS NULL, 1, 0)                                           AS CanLike

    from Data
             left join MD_Client Client with (nolock)
                       on Client.TigerId = Data.ClientId and Client.Firm = Data.Firm --and Client.IsDeleted = 0
             join AbpUsers Users with (nolock) on Users.Id = Data.UserId and Users.IsDeleted = 0
             left join (select distinct SourceType, ReferenceId, CreatorUserId
                        from MD_PhotoLike with (nolock)) Reacted
                       on Reacted.SourceType = Data.SourceType
                           and Reacted.ReferenceId = Data.Id
                           and Reacted.CreatorUserId = @userId
             left join (select ReferenceId,
                               SourceType,
                               sum(case when Status = 1 then 1 else 0 end) as LikedCount,
                               sum(case when Status = 0 then 1 else 0 end) as DislikedCount
                        from (select distinct ReferenceId, SourceType, Status, CreatorUserId
                              from MD_PhotoLike with (nolock)) UniqueReactions
                        group by ReferenceId, SourceType) Reaction
                       on Reaction.ReferenceId = Data.Id and Reaction.SourceType = Data.SourceType

             left join (select ReferenceId, SourceType, count(Id) as Count
                        from MD_PhotoComment with (nolock)
                        group by ReferenceId, SourceType) Comment
                       on Comment.ReferenceId = Data.Id and Comment.SourceType = Data.SourceType
    GROUP BY Data.Url,
             Data.Id,
             Data.SourceType,
             Client.Code,
             Client.Name,
             Client.Latitude,
             Client.Longitude,
             Data.OperationLatitude,
             Data.OperationLongitude,
             Users.Id,
             Users.Name,
             Users.Surname,
             Data.Date,
             Reaction.LikedCount,
             Reaction.DislikedCount,
             Comment.Count,
             Reacted.ReferenceId
    order by Data.Date desc
    offset @skipCount rows fetch next @takeCount rows only

END;