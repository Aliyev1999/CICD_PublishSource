CREATE OR ALTER function [dbo].[F_CHL_GetSurveyDetailedFeedbacksAll]
(
	@QuestionNameOrCode nvarchar(255),
	@QuestionSpecialCodes nvarchar(max),
	@QuestionGroupName nvarchar(255),
	@SurveyNameOrCode nvarchar(255),
	@SurveySpecialCodes nvarchar(max),
	@Firm smallint,
	@ClientNameCodeOrEdino nvarchar(255),
	@ClientSpecialCodes nvarchar(max),
	@SurveyContentType int,
	@pointType tinyint,
    @startDate datetime,
    @endDate datetime,
    @answersInSeperatedLines bit,
    @reasonsInSeparatedLines bit,
    @reasonTypes nvarchar(max),
    @reasonIds nvarchar(max),
    @currentUserId bigint,
    @userIds nvarchar(max),
    @questionStatus bit,
    @searchForStaticAnswers bit,
    @staticAnswers nvarchar(max),
    @answerTxt nvarchar(200)
)
Returns TABLE
as
return
(
	select distinct
			report.UserId									as UserId,
			users.Name + ' ' + users.Surname				as UserFullname,
			report.ClientId									as ClientId,
			client.Code										as ClientCode,
			client.Name										as ClientName,
			report.SurveyId									as SurveyId,
			report.SurveyName								as SurveyName,
			report.Status									as QuestionStatus,
			report.QuestionId								as QuestionId,
			report.QuestionAnswerTypeId						as QuestionAnswerTypeId,
			report.QuestionName								as QuestionName,
			case
				when question.QuestionGroupId is not null 
				then questionGroup.Name
				else '' end									as GroupName,
			report.IsAnswerRequired							as IsAnswerRequired,
			report.SavedDate								as SavedDate,
			report.Answers									as Answers,
			report.Reasons									as Reasons,
			report.Point									as Point,
			report.ReportId									as ReportId,
			question.Description							as QuestionDescription,
			case
				when surveyContentType is not null
				then surveyContentType.Name
				else '' end									as SurveyContentType,
			report.AnswerId									as AnswerId,
			report.ReasonType								as ReasonType,
			case
				when attachment.Type = 3
				then cast(1 as bit)
				else cast(0 as bit) end						as IsAttachmentExists,
			report.RatingAnswerSymbolType					as RatingAnswerSymbolType,
			report.RatingAnswerSymbolCount					as RatingAnswerSymbolCount
	from F_CHL_GetSurveyDetailedFeedback(@pointType, @startDate, @endDate, @answersInSeperatedLines,
										 @reasonsInSeparatedLines, @reasonTypes, @reasonIds, @currentUserId,
										 @userIds, @questionStatus, @searchForStaticAnswers, @staticAnswers, @answerTxt) report
	join CHL_Question question on report.QuestionId = question.Id
	left join CHL_QuestionGroup questionGroup on question.QuestionGroupId = questionGroup.Id
	join CHL_Survey survey on report.SurveyId = survey.Id
	join MD_Client client on report.ClientId = client.TigerId and survey.Firm = client.Firm
	join AbpUsers users on report.UserId = users.Id
	left join MD_StopReason surveyContentType on surveyContentType.Type = 7 and survey.SurveyContentType = surveyContentType.Id
	left join CHL_UserSurveyResponseDetail userSurveyResponseDetail on report.QuestionId = userSurveyResponseDetail.QuestionId
																   and report.ReportId = userSurveyResponseDetail.UserSurveyResponseId
	left join CHL_Attachment attachment on userSurveyResponseDetail.Id = attachment.ReferenceId
	left join CHL_Answer answer on userSurveyResponseDetail.AnswerId = answer.Id
	where (@SurveyContentType is null or surveyContentType = @SurveyContentType)
	  and (@QuestionNameOrCode is null or question.Name like '%'+ @QuestionNameOrCode +'%' or question.Code = @QuestionNameOrCode)
	  and (@QuestionSpecialCodes is null or question.Specode1 like '%' + @QuestionSpecialCodes + '%' 
									     or question.Specode2 like '%' + @QuestionSpecialCodes + '%'
										 or question.Specode3 like '%' + @QuestionSpecialCodes + '%')
	  and (@QuestionGroupName is null or questionGroup.Name like '%' + @QuestionGroupName + '%')
	  and (@SurveyNameOrCode is null or survey.Name like '%' + @SurveyNameOrCode + '%'
									 or survey.Code = @SurveyNameOrCode)
	  and (@SurveySpecialCodes is null or survey.Specode1 like '%' + @SurveySpecialCodes + '%'
									   or survey.Specode2 like '%' + @SurveySpecialCodes + '%'
									   or survey.Specode3 like '%' + @SurveySpecialCodes + '%')
	  and (@ClientNameCodeOrEdino is null or client.Name like '%' + @ClientNameCodeOrEdino + '%'
										  or client.Code = @ClientNameCodeOrEdino
										  or client.Edino = @ClientNameCodeOrEdino)
	  and (@ClientSpecialCodes is null or client.SpecialCode like '%' + @ClientSpecialCodes + '%'
									   or client.SpecialCode2 like '%' + @ClientSpecialCodes + '%'
									   or client.SpecialCode3 like '%' + @ClientSpecialCodes + '%'
									   or client.SpecialCode4 like '%' + @ClientSpecialCodes + '%'
									   or client.SpecialCode5 like '%' + @ClientSpecialCodes + '%')

)

