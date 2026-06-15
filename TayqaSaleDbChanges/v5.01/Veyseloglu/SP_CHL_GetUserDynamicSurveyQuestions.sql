USE [VESASSAP]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHL_GetUserDynamicSurveyQuestions]    Script Date: 3/5/2025 10:18:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_CHL_GetUserDynamicSurveyQuestions] @surveyId INT,
                                                         @clientId INT, @UserId INT
--    -- ,@UserId int
AS
BEGIN

  --declare @surveyId INT = 15430, @clientId INT = 1000004091
--TODO: bu hissede istifadecini de nezere almaq lazimdir ki hemin istifadeci hemin musteride en son hansi taksi basladib ki hemin taska aid gondermek olsun.

    declare @CurrentTime datetime = (select getdate())

    declare @ClientCode nvarchar(100) = (select top 1 Code
                                         from MD_Client with (nolock)
                                         where Firm = 20
                                           and IsDeleted = 0
                                           and Status = 0
                                           and TigerId = @clientId)

	declare @UserCode nvarchar(100) = (select top 1 Code
                                         from Abpusers with (nolock)
                                         where 
                                            IsDeleted = 0
                                           and IsActive = 1
                                           and Id = @UserId)

    declare @InvoiceList table
                         (
                             PackageId bigint,
                             InvoiceNo nvarchar(100)
                         )

------------------------------------------------------------------------------------------------------------------------------------

    insert into @InvoiceList (PackageId, InvoiceNo)
    SELECT distinct Package.PackageId, InvoiceNo
    FROM Spec_SAP_DeliveryPackage Package with (nolock)
             JOIN Spec_SAP_DeliveryPackageClient Client with (nolock) ON Package.PackageId = Client.PackageId
             JOIN Spec_SAP_DeliveryPackageInvoice Invoice with (nolock) ON Invoice.PackageId = Client.PackageId AND Invoice.ClientCode = Client.ClientCode
    WHERE Package.IsDeleted = 0
      and Client.IsDeleted = 0
      and Invoice.IsDeleted = 0
      and Client.ClientCode = @ClientCode
	  and Package.DriverCode = @UserCode
------------------------------------------------------------------------------------------------------------------------------------

    declare @LastLogTime datetime = (select max(RegisteredDate)
                                     from Spec_SAP_DeliveryQuestions with (nolock)
                                     where ClientId = @clientId)

    if exists(select Firm
              from CHL_UserSurveyResponse with (nolock)
              where ClientId = @clientId
			    and UserId = @UserId
                and SurveyId = 15430
                and SavedDate >= @LastLogTime
				and Firm = 20)
        begin
            delete
            from @InvoiceList
            where InvoiceNo in (select distinct InvoiceNo
                                from Spec_SAP_DeliveryQuestions with (nolock)
                                where RegisteredDate = @LastLogTime)
        end
		declare @NewId UNIQUEIDENTIFIER = (select NEWID())

declare @PackageId nvarchar(50)
set @PackageId = (select top 1 Note from WPM_Task with (nolock) where Id = (select top 1 last_value(TaskId) over (order by CreatedDate) from WPM_TaskTicket where ClientId = @clientId and UserId = @UserId and FinalizedDate is null))

------------------------------------------------------------------------------------------------------------------------------------

    begin

        SELECT DISTINCT CAST(0 AS BIT)                                                                                                                     AS IsAnswerRequired,
                        CAST(1 AS TINYINT)                                                                                                                 AS QuestionType,
                        CAST(ROW_NUMBER() OVER (ORDER BY Invoice.Id) + 1 AS SMALLINT)                                                                      AS QuestionOrderNumber,
                        CONCAT(Invoice.InvoiceNo , ' ', N'- nömrəli faktura', ' | ',  Invoice.OrderNo , ' ' , IIF(OperationType = 1, N'- nömrəli sifariş', N'- nömrəli qaytarma')) AS QuestionName,
                        Invoice.InvoiceNo                                                                                                                  AS QuestionCode,
                        CONCAT(N'Təmsilçi : ', Salesman.Name COLLATE SQL_Latin1_General_CP1_CI_AS, ' | ', N'Əlaqə nömrəsi : ' , Invoice.SalesmanPhone , ' | ', Invoice.PackageId , ' Id-li bağlama' )              AS QuestionDescription,
                        NULL                                                                                                                               AS ReasonConditionType,
                        NULL                                                                                                                               AS ReasonConditionValue,
                        CAST(1 AS TINYINT)                                                                                                                 AS ReasonInputType,
                        CAST(0 AS TINYINT)                                                                                                                 AS QuestionStatus,
                        CAST(1 AS TINYINT)                                                                                                                 AS WeightingType,
                        CAST(0 AS FLOAT)                                                                                                                   AS AnswerMinValue,
                        CAST(0 AS FLOAT)                                                                                                                   AS AnswerMaxValue,
                        NULL                                                                                                                               AS ItemId,
                        NULL                                                                                                                               AS ItemGroupId,
                        CAST(2 AS TINYINT)                                                                                                                 AS PhotoUploadOption,
                        CAST(2 AS TINYINT)                                                                                                                 AS QuestionReasonSelectOption,
                        CAST(2 AS TINYINT)                                                                                                                 AS AnswerInputType,
                        NULL                                                                                                                               AS QuestionGroupCode,
                        NULL                                                                                                                               AS QuestionGroupName,
                        NULL                                                                                                                               AS QuestionGroupDescription,
                        NULL                                                                                                                               AS AnswerText,
                        NULL                                                                                                                               AS AnswerReasonSelectOption,
                        NULL                                                                                                                               AS AnswerReasonInputType,
                        NULL                                                                                                                               AS AnswerPhotoUploadOption,
                        CAST(0 AS BIT)                                                                                                                     AS IsCorrect,
                        NULL                                                                                                                               AS AnswerOrderNumber,
                        3                                                                                                                                  AS AnswerTypeId,
                        'SingleLineText'                                                                                                                   AS AnswerTypeName,
                        CAST(1 AS BIT)                                                                                                                     AS IsAnswerFree,
                        NULL                                                                                                                               AS QuestionAttachmentId,
                        NULL                                                                                                                               AS QuestionAttachmentUrl,
                        NULL                                                                                                                               AS QuestionSecureUrl,
                        NULL                                                                                                                               AS QuestionTagId,
                        NULL                                                                                                                               AS QuestionTag,
                        Reason.Id                                                                                                                          AS AnswerSelectReasonId,
                        Reason.Name                                                                                                                        AS AnswerSelectReasonName,
                        Reason.Description                                                                                                                 AS AnswerSelectReasonDescription,
                        CAST(3 AS TINYINT)                                                                                                                 AS AnswerSelectReasonType,
                        CAST(1 AS TINYINT)                                                                                                                 AS AnswerSelectSelectionType,
                        CAST(0 AS TINYINT)                                                                                                                 AS AnswerSelectMandatoryType,
                        NULL                                                                                                                               AS ReasonId,
                        NULL                                                                                                                               AS CustomReasonInputType,
                        NULL                                                                                                                               AS MandatoryType,
                        NULL                                                                                                                               AS ReasonType,
                        NULL                                                                                                                               AS ReasonValue,
                        NULL                                                                                                                               AS SelectionType,
                        NULL                                                                                                                               AS ReasonLabel,
                        CAST(0 AS BIT)                                                                          AS IsManualReasonAllowed
        FROM Spec_SAP_DeliveryPackageInvoice Invoice with (nolock)
                 join @InvoiceList List on List.InvoiceNo = Invoice.InvoiceNo
                 JOIN MD_Salesman Salesman with (nolock) ON Salesman.Code = Invoice.SalesmanCode COLLATE SQL_Latin1_General_CP1_CI_AS --and Firm = 10
                 CROSS JOIN MD_StopReason Reason
        WHERE Reason.Id BETWEEN 277 AND 305 and cast(List.PackageId as nvarchar(60)) = @PackageId
          AND ((OperationType = 1 AND Reason.Id BETWEEN 277 AND 302) OR (OperationType = 2 AND Reason.Id BETWEEN 303 AND 305))

        UNION all

        select CAST(0 AS BIT)                                                     as IsAnswerRequired,
               CAST(1 AS TINYINT)                                                 as QuestionType,
               cast(QuestionOrderNumber AS smallint)                              as QuestionOrderNumber,
               QuestionName,
               QuestionCode collate SQL_Latin1_General_CP1_CI_AS                  as QuestionCode,
               QuestionDescription,
               ReasonConditionType,
               ReasonConditionValue,
               CAST(1 AS TINYINT)                                                 AS ReasonInputType,
               CAST(0 AS TINYINT)                                                 AS QuestionStatus,
               CAST(1 AS TINYINT)                                                 AS WeightingType,
               CAST(0 AS FLOAT)                                                   AS AnswerMinValue,
               CAST(0 AS FLOAT)                                                   AS AnswerMaxValue,
               ItemId,
               ItemGroupId,
               CAST(1 AS TINYINT)                                                 AS PhotoUploadOption,
               CAST(1 AS TINYINT)                                                 AS QuestionReasonSelectOption,
               CAST(2 AS TINYINT)                                                 AS AnswerInputType,
               QuestionGroupCode,
               QuestionGroupName,
               QuestionGroupDescription,
               AnswerText,
               AnswerReasonSelectOption,
               AnswerReasonInputType,
               AnswerPhotoUploadOption,
               CAST(0 AS BIT)                                                     AS IsCorrect,
               AnswerOrderNumber,
               AnswerTypeId,
               AnswerTypeName,
               CAST(0 AS BIT)                                                     AS IsAnswerFree,
               QuestionAttachmentId,
               QuestionAttachmentUrl,
               QuestionSecureUrl,
               QuestionTagId,
               QuestionTag,
               AnswerSelectReasonId,
               AnswerSelectReasonName collate SQL_Latin1_General_CP1_CI_AS        AS AnswerSelectReasonName,
               AnswerSelectReasonDescription collate SQL_Latin1_General_CP1_CI_AS AS AnswerSelectReasonDescription,
               CAST(3 AS TINYINT)                                                 AS AnswerSelectReasonType,
               CAST(2 AS TINYINT)                                                 AS AnswerSelectSelectionType,
               CAST(0 AS TINYINT)                                                 AS AnswerSelectMandatoryType,
               ReasonId,
               CustomReasonInputType,
               MandatoryType,
               ReasonType,
               ReasonValue,
               SelectionType,
               ReasonLabel,
               CAST(0 AS BIT)                                                                          AS IsManualReasonAllowed
        from F_Spec_DynamicChecklistGeneralQuestion(@ClientCode)
        where exists(select * from @InvoiceList)

        insert into Spec_SAP_DeliveryQuestions (PackageId, InvoiceNo, ClientId,UserId, RegisteredDate,UniId)
        select PackageId, InvoiceNo, @ClientId,@UserId, @CurrentTime,@NewId
        from @InvoiceList where cast(PackageId as nvarchar(60)) = @PackageId;
    end
END