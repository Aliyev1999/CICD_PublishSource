alter procedure [dbo].[SP_CHL_GetQuestionAnswerReasonDetails](
    @startDate DATETIME,
    @endDate DATETIME,
    @clientNameCodeOrGroupCode NVARCHAR(500),
    @surveyNameOrCode NVARCHAR(500),
    @surveySpecialCodes NVARCHAR(50),
    @reasonIds NVARCHAR(MAX),
    @reasonTypes NVARCHAR(MAX) = NULL,
    @userIds NVARCHAR(MAX))
AS
BEGIN
    declare @Query nvarchar(max) = N'

with AllReasons as (select Detail. Id                                                      as DetailId,
                           Response. Id                                                    as ResponseId,
                           Response. SurveyId                                              as SurveyId,
                           Response. SavedDate                                             as Date,
                           Response. UserId                                                as UserId,
                           Response. ClientId                                              as ClientId,
                           Response. Firm                                                  as Firm,
                           Detail. QuestionId                                              as QuestionId,
                           case
                            when coalesce(NewReason. Value collate SQL_Latin1_General_CP1_CI_AS, Detail. ReasonValue collate SQL_Latin1_General_CP1_CI_AS) is not null then 0
                            else coalesce(Detail. ReasonId, NewReason. ReasonId)
                            end                                                            as ReasonId,
                           coalesce(NewReason. Value,
                                    Detail. ReasonValue,
                                    OldContent. Name collate SQL_Latin1_General_CP1_CI_AS,
                                    NewContent. Name collate SQL_Latin1_General_CP1_CI_AS) as Reason
                    from CHL_UserSurveyResponseDetail Detail with (nolock)
                             join CHL_UserSurveyResponse Response with (nolock) on Response. Id = Detail. UserSurveyResponseId
                             left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason. UserSurveyResponseDetailId = Detail. Id
                             left join MD_StopReason OldContent with (nolock) on OldContent. Id = NewReason. ReasonId
                             left join MD_StopReason NewContent with (nolock) on NewContent. Id = Detail. ReasonId

                    where cast(Response. SavedDate as date) between cast(@startDate as date) and cast(@endDate as date)
                      and coalesce(NewReason. Value,
                                   Detail. ReasonValue,
                                   OldContent. Name collate SQL_Latin1_General_CP1_CI_AS,
                                   NewContent. Name collate SQL_Latin1_General_CP1_CI_AS) is not null'

    if @reasonTypes = '3' and @reasonIds is null
        set @Query = concat(@Query, N' and (Detail. ReasonValue is not null or NewReason. Value is not null)')

    if @userIds is not null
        set @Query = concat(@Query,
                            N' and (Response. UserId in (select * from F_SplitList(@userIds, '','')))')

    set @Query = concat(@Query, N')

select Users. UserName      as UserName,
       AllReasons. Date     as Date,
       Client. Code         as ClientCode,
       Client. Name         as ClientName,
       Client. Edino        as ClientGroupCode,
       Survey. Name         as SurveyName,
       Question. Name       as QuestionName,
       AllReasons. ReasonId as ReasonId,
       AllReasons. Reason   as ReasonName,
       AllReasons. DetailId as ResponseDetailId
from AllReasons
         join CHL_Survey Survey with (nolock) on Survey. Id = AllReasons. SurveyId
         join MD_Client Client with (nolock) on Client. TigerId = AllReasons. ClientId and Client. Firm = AllReasons. Firm
         join AbpUsers Users with (nolock) on Users. Id = AllReasons. UserId
         join CHL_Question Question with (nolock) on Question. Id = AllReasons. QuestionId

where 1=1')


    if @reasonIds is not null
        set @Query = concat(@Query, N' and (ReasonId in (select * from F_SplitList(@reasonIds, '','')))')

    if @clientNameCodeOrGroupCode is not null
        set @Query = concat(@Query,
                            N' and (Client. Code like ''%''+@clientNameCodeOrGroupCode+''%'' or Client. Name like ''%''+@clientNameCodeOrGroupCode+''%''                                    or Client. Edino like ''%''+@clientNameCodeOrGroupCode+''%'')')

    if @surveyNameOrCode is not null
        set @Query = concat(@Query, N' and (Survey. Code like ''%''+@surveyNameOrCode+''%'' or Survey. Name like ''%''+@surveyNameOrCode+''%'')')

    if @surveySpecialCodes is not null
        set @Query = concat(@Query,
                            N' and (Survey. Specode1 like ''%''+@surveySpecialCodes+''%'' or Survey. Specode2 like ''%''+@surveySpecialCodes+''%''                                  or Survey. Specode3 like ''%''+@surveySpecialCodes+''%'')')


    --print cast(@Query as ntext)
    execute sp_executesql @Query,
            N'@startDate DATETIME, @endDate DATETIME, @clientNameCodeOrGroupCode NVARCHAR(500), @surveyNameOrCode NVARCHAR(500),
            @surveySpecialCodes NVARCHAR(50), @reasonIds NVARCHAR(MAX),@reasonTypes NVARCHAR(MAX),@userIds NVARCHAR(MAX) ',
            @startDate = @startDate,
            @endDate = @endDate,
            @clientNameCodeOrGroupCode = @clientNameCodeOrGroupCode,
            @surveyNameOrCode = @surveyNameOrCode,
            @surveySpecialCodes = @surveySpecialCodes,
            @reasonIds = @reasonIds,
            @reasonTypes = @reasonTypes,
            @userIds = @userIds

END

go