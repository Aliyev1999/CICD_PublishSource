CREATE OR ALTER PROCEDURE [dbo].[SP_CHL_GetQuestionAnswerReasonsReport](
    @firm SMALLINT,
    @startDate DATETIME,
    @endDate DATETIME,
    @clientNameCodeOrGroupCode NVARCHAR(500),
    @clientSpecialCodes NVARCHAR(500),
    @surveyNameOrCode NVARCHAR(500),
    @surveySpecialCodes NVARCHAR(50),
    @userIds NVARCHAR(MAX),
    @reasonIds NVARCHAR(MAX),
    @reasonTypes NVARCHAR(MAX) = NULL,
	@currentUserId bigint
)
AS
BEGIN
    declare @Query nvarchar(max) = N'
with Data as (select coalesce(NewReason. Value,
                              Detail. ReasonValue,
                              OldContent. Name,
                              NewContent. Name collate SQL_Latin1_General_CP1_CI_AS)                       as ReasonName,
                     case
                         when coalesce(NewReason. Value collate SQL_Latin1_General_CP1_CI_AS, Detail. ReasonValue) is not null then 0
                         else coalesce(Detail. ReasonId, NewReason. ReasonId)
                         end                                                                              as ReasonId,
                     Firm. Name                                                                            as FirmName,
                     Firm. Nr                                                                              as FirmNr,
                     Client. Name                                                                          as ClientName,
                     Client. Code                                                                          as ClientCode,
                     Client. Edino                                                                         as ClientGroupCode,
                     case
                                       when NewReason.Type is not null then NewReason.Type
                                       when NewReason.Type is null and (Detail.ReasonId is not null or Detail.ReasonValue is not null) then 1
                                       end                                   as ReasonType

              from CHL_UserSurveyResponseDetail Detail with (nolock)
                       join CHL_UserSurveyResponse Response with (nolock) on Response. Id = Detail. UserSurveyResponseId
                       join MD_Client Client with (nolock) on Client. TigerId = Response. ClientId and Client. Firm = Response. Firm
                       join CHL_Survey Survey with (nolock) on Survey. Id = Response. SurveyId
                       join MD_Firm Firm with (nolock) on Firm. Nr = Response. Firm and Firm. IsActive = 1
					   join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = Response.UserId
                       left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason. UserSurveyResponseDetailId = Detail. Id
                       left join MD_StopReason OldContent with (nolock) on OldContent. Id = NewReason. ReasonId
                       left join MD_StopReason NewContent with (nolock) on NewContent. Id = Detail. ReasonId

              where Response. SavedDate between @startDate and @endDate
                and coalesce(NewReason. Value,
                             Detail. ReasonValue,
                             OldContent. Name,
                             NewContent. Name collate SQL_Latin1_General_CP1_CI_AS) is not null '

    if @firm is not null
        set @Query = concat(@Query, N' and Firm. Nr = @firm')

    if @clientNameCodeOrGroupCode is not null
        set @Query = concat(@Query,
                            N' and (Client. Code like ''%''+@clientNameCodeOrGroupCode+''%'' or Client. Name like ''%''+@clientNameCodeOrGroupCode+''%''                                    or Client. Edino like ''%''+@clientNameCodeOrGroupCode+''%'')')

    if @clientSpecialCodes is not null
        set @Query = concat(@Query,
                            N' and (Client. SpecialCode like ''%''+@clientSpecialCodes+''%'' or Client. SpecialCode2 like ''%''+@clientSpecialCodes+''%''                                    or Client. SpecialCode3 like ''%''+@clientSpecialCodes+''%'' or Client. SpecialCode4 like ''%''+@clientSpecialCodes+''%''                                    or Client. SpecialCode5 like ''%''+@clientSpecialCodes+''%'')')

    if @userIds is not null
        set @Query = concat(@Query,
                            N' and (Response. UserId in (select * from F_SplitList(@userIds, '','')))')

    if @surveyNameOrCode is not null
        set @Query = concat(@Query, N' and (Survey. Code like ''%''+@surveyNameOrCode+''%'' or Survey. Name like ''%''+@surveyNameOrCode+''%'')')


    if @surveySpecialCodes is not null
        set @Query = concat(@Query,
                            N' and (Survey. Specode1 like ''%''+@surveySpecialCodes+''%'' or Survey. Specode2 like ''%''+@surveySpecialCodes+''%''                                    or Survey. Specode3 like ''%''+@surveySpecialCodes+''%'')')


    set @Query = concat(@Query,
                        N')

                        select ReasonName,
                               ReasonId,
                               FirmName,
                               FirmNr,
                               ClientName,
                               ClientCode,
                               ClientGroupCode,
                               cast(ReasonType as tinyint) as ReasonType,
                               count(*) as ReasonCountByClient
                        from Data
                        where 1=1 ')

    if @reasonIds is not null
        set @Query = concat(@Query, N' and (ReasonId in (select * from F_SplitList(@reasonIds, '','')))')
    if @reasonTypes is not null
        set @Query = concat(@Query, N' and (ReasonType in (select * from F_SplitList(@reasonTypes, '','')))')

    set @Query = concat(@Query, ' group by ReasonName, ReasonId, FirmName, FirmNr, ClientName, ClientCode, ClientGroupCode, ReasonType')

    exec sp_executesql @Query,
         N'@firm SMALLINT,
            @startDate DATETIME,
            @endDate DATETIME,
            @clientNameCodeOrGroupCode NVARCHAR(500),
            @clientSpecialCodes NVARCHAR(500),
            @surveyNameOrCode NVARCHAR(500),
            @surveySpecialCodes NVARCHAR(50),
            @userIds NVARCHAR(MAX) ,
            @reasonIds NVARCHAR(MAX),
            @reasonTypes NVARCHAR(MAX) = NULL,
			@currentUserId bigint',
         @firm = @firm,
         @startDate = @startDate,
         @endDate = @endDate,
         @clientNameCodeOrGroupCode = @clientNameCodeOrGroupCode,
         @clientSpecialCodes = @clientSpecialCodes,
         @surveyNameOrCode = @surveyNameOrCode,
         @surveySpecialCodes = @surveySpecialCodes,
         @userIds = @userIds,
         @reasonIds = @reasonIds,
         @reasonTypes = @reasonTypes,
		 @currentUserId=@currentUserId

END