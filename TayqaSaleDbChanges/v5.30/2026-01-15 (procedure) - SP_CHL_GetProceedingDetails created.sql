CREATE OR ALTER PROCEDURE [dbo].[SP_CHL_GetProceedingDetails](
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
    @answerTxt nvarchar(200),
    @normativeNameOrCode nvarchar(max),
    @skipCount int,
    @takeCount int,
    @sorting nvarchar(max),
    @totalCount int OUT
)
AS
BEGIN
    SET NOCOUNT OFF;

    DECLARE @ProceedingDetails TABLE
                               (
                                   UserId                  INT,
                                   UserFullname            NVARCHAR(255),
                                   UserCode				   NVARCHAR(255),
                                   ClientId                INT,
                                   ClientCode              NVARCHAR(500),
                                   ClientName              NVARCHAR(255),
                                   SurveyId                INT,
                                   SurveyName              NVARCHAR(255),
                                   QuestionStatus          TINYINT,
                                   QuestionId              INT,
                                   QuestionAnswerTypeId    INT,
                                   QuestionName            NVARCHAR(255),
                                   QuestionDescription     NVARCHAR(MAX),
                                   IsAnswerRequired        BIT,
                                   SavedDate               DATETIME,
                                   Answers                 NVARCHAR(MAX),
                                   Reasons                 NVARCHAR(MAX),
                                   GroupName               NVARCHAR(255),
                                   Point                   FLOAT,
                                   SurveyContentType       NVARCHAR(100),
                                   ReportId                INT,
                                   AnswerId                NVARCHAR(500),
                                   ReasonType              NVARCHAR(500),
                                   IsAttachmentExists      BIT,
                                   RatingAnswerSymbolType  TINYINT,
                                   RatingAnswerSymbolCount TINYINT,
                                   NormativeText           NVARCHAR(500),
                                   NormativeName           NVARCHAR(255),
                                   NormativeCode           NVARCHAR(MAX)
                               );

    DECLARE @sql NVARCHAR(MAX) = N'
With PointCalculation_Combined AS (SELECT UserSurveyResponseDetail.UserSurveyResponseId,
                                          UserSurveyResponseDetail.QuestionId referenceID,

                                          CASE
                                              WHEN question.AnswerTypeId = 10 THEN
                                                  SUM(
                                                          CASE
                                                              WHEN question.weightingtype = 2
                                                                  AND (@pointType IS NULL OR SurveyQuestionAnswerPoint.PointType = @pointType)
                                                                  THEN ISNULL(SurveyQuestionAnswerPoint.Point, 0)

                                                              WHEN question.weightingtype = 1
                                                                  AND (@pointType IS NULL OR SurveyQuestionPoint.PointType = @pointType)
                                                                  THEN ISNULL(SurveyQuestionPoint.Point, 0)

                                                              ELSE 0
                                                              END
                                                  )

                                              ELSE
                                                  MAX(
                                                          CASE
                                                              WHEN (@pointType IS NULL
                                                                  OR COALESCE(SurveyQuestionAnswerPoint.PointType, SurveyQuestionPoint.PointType) = @pointType)
                                                                  THEN ISNULL(COALESCE(SurveyQuestionAnswerPoint.Point, SurveyQuestionPoint.Point), 0)
                                                              ELSE 0
                                                              END
                                                  )
                                              END AS                          Point

                                   FROM CHL_UserSurveyResponse UserSurveyResponse WITH (NOLOCK)
                                            JOIN CHL_UserSurveyResponseDetail UserSurveyResponseDetail WITH (NOLOCK)
                                                 ON UserSurveyResponse.Id = UserSurveyResponseDetail.UserSurveyResponseId
                                            JOIN CHL_Question question WITH (NOLOCK)
                                                 ON UserSurveyResponseDetail.QuestionId = question.Id
                                            join CHL_SurveyQuestion SurveyQuestion
                                                 on SurveyQuestion.SurveyId = UserSurveyResponse.SurveyId and
                                                    SurveyQuestion.QuestionId = UserSurveyResponseDetail.QuestionId
                                            LEFT JOIN CHL_SurveyQuestionAnswerPoint SurveyQuestionAnswerPoint WITH (NOLOCK)
                                                      ON UserSurveyResponseDetail.AnswerId = SurveyQuestionAnswerPoint.AnswerId AND question.weightingtype = 2
                                                          and SurveyQuestionAnswerPoint.SurveyQuestionId = SurveyQuestion.Id

                                            LEFT JOIN CHL_SurveyQuestionPoint SurveyQuestionPoint WITH (NOLOCK)
                                                      ON question.Id = SurveyQuestionPoint.SurveyQuestionId AND question.weightingtype = 1
                                   WHERE @answersInSeperatedLines = 0
								   AND UserSurveyResponse.SavedDate BETWEEN @startDate AND @endDate
                                   GROUP BY UserSurveyResponseDetail.UserSurveyResponseId, UserSurveyResponseDetail.QuestionId, question.AnswerTypeId,
                                            question.weightingtype),
     PointCalculation_Separated AS (SELECT UserSurveyResponseDetail.UserSurveyResponseId,
                                           UserSurveyResponseDetail.AnswerID referenceID,

                                           CASE
                                               WHEN question.AnswerTypeId = 10 THEN
                                                   SUM(
                                                           CASE
                                                               WHEN question.weightingtype = 2
                                                                   AND (@pointType IS NULL OR SurveyQuestionAnswerPoint.PointType = @pointType)
                                                                   THEN ISNULL(SurveyQuestionAnswerPoint.Point, 0)

                                                               WHEN question.weightingtype = 1
                                                                   AND (@pointType IS NULL OR SurveyQuestionPoint.PointType = @pointType)
                                                                   THEN ISNULL(SurveyQuestionPoint.Point, 0)

                                                               ELSE 0
                                                               END
                                                   )

                                               ELSE
                                                   MAX(
                                                           CASE
                                                               WHEN (@pointType IS NULL
                                                                   OR COALESCE(SurveyQuestionAnswerPoint.PointType, SurveyQuestionPoint.PointType) = @pointType)
                                                                   THEN ISNULL(COALESCE(SurveyQuestionAnswerPoint.Point, SurveyQuestionPoint.Point), 0)
                                                               ELSE 0
                                                               END
                                                   )
                                               END AS                        Point

                                    FROM CHL_UserSurveyResponse UserSurveyResponse WITH (NOLOCK)
                                             JOIN CHL_UserSurveyResponseDetail UserSurveyResponseDetail WITH (NOLOCK)
                                                  ON UserSurveyResponse.Id = UserSurveyResponseDetail.UserSurveyResponseId
                                             JOIN CHL_Question question WITH (NOLOCK)
                                                  ON UserSurveyResponseDetail.QuestionId = question.Id
                                             join CHL_SurveyQuestion SurveyQuestion
                                                  on SurveyQuestion.SurveyId = UserSurveyResponse.SurveyId and
                                                     SurveyQuestion.QuestionId = UserSurveyResponseDetail.QuestionId
                                             LEFT JOIN CHL_SurveyQuestionAnswerPoint SurveyQuestionAnswerPoint WITH (NOLOCK)
                                                       ON UserSurveyResponseDetail.AnswerId = SurveyQuestionAnswerPoint.AnswerId AND question.weightingtype = 2
                                                           and SurveyQuestionAnswerPoint.SurveyQuestionId = SurveyQuestion.Id

                                             LEFT JOIN CHL_SurveyQuestionPoint SurveyQuestionPoint WITH (NOLOCK)
                                                       ON question.Id = SurveyQuestionPoint.SurveyQuestionId AND question.weightingtype = 1
                                    WHERE @answersInSeperatedLines = 1
									AND UserSurveyResponse.SavedDate BETWEEN @startDate AND @endDate
                                    GROUP BY UserSurveyResponseDetail.UserSurveyResponseId, UserSurveyResponseDetail.AnswerID, question.AnswerTypeId,
                                             question.weightingtype),
     Data AS (SELECT ISNULL(users.Id, 0)                                                    AS UserId,
                     CONCAT(ISNULL(users.name, '' ''), '' '', ISNULL(users.surname, '' '')) AS UserFullname,
                     ISNULL(users.Code, '' '')										AS UserCode,
                     ISNULL(client.TigerId, 0)                                              AS ClientId,
                     ISNULL(client.Code, '' '')                                             AS ClientCode,
                     ISNULL(client.Name, '' '')                                             AS ClientName,
                     ISNULL(survey.Id, 0)                                                   AS SurveyId,
                     ISNULL(survey.Name, '' '')                                             AS SurveyName,
                     ISNULL(question.Status, 0)                                             AS QuestionStatus,
                     ISNULL(question.Id, 0)                                                 AS QuestionId,
                     ISNULL(question.AnswerTypeId, 0)                                       AS QuestionAnswerTypeId,
                     ISNULL(question.Name, '' '')                                           AS QuestionName,
                     ISNULL(question.Description, '' '')                                    AS QuestionDescription,
                     ISNULL(SurveyQuestion.IsAnswerRequired, 0)                                IsAnswerRequired,
                     ISNULL(UserSurveyResponse.SavedDate, '' '')                               SavedDate,
                     Answerdetailfeedback.Answers                                           AS Answers,
                     ISNULL(Answerdetailfeedback.Reasons, '' '')                               Reasons,
                     ISNULL(QuestionGroup.Name, '' '')                                      AS GroupName,
                     ISNULL(COALESCE(pc.Point, pcs.Point), 0)                               AS Point,
                     case
                         when surveyContentType is not null
                             then surveyContentType.Name
                         else '''' end                                                      as SurveyContentType,
                     ISNULL(UserSurveyResponse.Id, 0)                                       AS ReportId,
                     Answerdetailfeedback.AnswerId                                          AS AnswerId,
                     ISNULL(Answerdetailfeedback.ReasonType, '' '')                            ReasonType,
                     CASE
                         WHEN EXISTS (SELECT 1
                                      FROM CHL_UserSurveyResponseDetail usd
                                               JOIN CHL_Attachment attachment ON usd.Id = attachment.ReferenceId AND attachment.Type = 3
                                      WHERE usd.UserSurveyResponseId = UserSurveyResponse.Id) THEN CAST(1 AS BIT)
                         ELSE CAST(0 AS BIT)
                         END                                                                AS IsAttachmentExists,
                     ISNULL(Question.RatingAnswerSymbolType, 0)                             as RatingAnswerSymbolType,
                     ISNULL(Question.RatingAnswerSymbolCount, 0)                            AS RatingAnswerSymbolCount,
                     ISNULL(Normative.Text, '' '')                                          AS NormativeText,
                     ISNULL(Normative.Name, '' '')                                          AS NormativeName,
                     ISNULL(Normative.Code, '' '')                                          AS NormativeCode
              FROM CHL_UserSurveyResponse UserSurveyResponse WITH (NOLOCK)
                       JOIN AbpUsers users WITH (NOLOCK) ON UserSurveyResponse.UserId = users.Id
                       JOIN MD_Client client WITH (NOLOCK) ON UserSurveyResponse.ClientId = client.TigerId AND UserSurveyResponse.Firm = client.Firm
                       JOIN CHL_Survey survey WITH (NOLOCK) ON UserSurveyResponse.SurveyId = survey.Id
                       JOIN CHL_SurveyQuestion SurveyQuestion WITH (NOLOCK) ON SurveyQuestion.SurveyId = UserSurveyResponse.SurveyId
                       JOIN CHL_Question question WITH (NOLOCK) ON SurveyQuestion.QuestionId = question.Id
                       JOIN dbo.F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback(@startDate, @endDate, @answersInSeperatedLines, @reasonsInSeparatedLines,
                                                                                     @reasonTypes, @reasonIds) Answerdetailfeedback
                            ON Answerdetailfeedback.UserSurveyResponseId = UserSurveyResponse.Id AND Answerdetailfeedback.QuestionId = Question.Id
                       JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers ON PermittedUsers.UserId = UserSurveyResponse.UserId
                       LEFT JOIN CHL_QuestionGroup QuestionGroup WITH (NOLOCK) ON question.QuestionGroupId = QuestionGroup.ID
                       LEFT JOIN CHL_QuestionNormativeMapping Mapping WITH (NOLOCK) ON Question.Id = Mapping.QuestionId
                       LEFT join MD_StopReason surveyContentType on surveyContentType.Type = 7 and survey.SurveyContentType = surveyContentType.Id
                       LEFT JOIN CHL_Normative Normative WITH (NOLOCK)
                                 ON Mapping.NormativeId = Normative.Id AND Normative.StartDate <= cast(UserSurveyResponse.SavedDate as date) AND
                                    Normative.EndDate >= cast(UserSurveyResponse.SavedDate as date)
                       LEFT JOIN PointCalculation_Combined pc WITH (NOLOCK) ON pc.UserSurveyResponseId = UserSurveyResponse.Id
                  AND pc.referenceID = Answerdetailfeedback.questionId
                       LEFT JOIN PointCalculation_Separated pcs WITH (NOLOCK) ON pcs.UserSurveyResponseId = UserSurveyResponse.Id
                  AND pcs.referenceID = try_cast(Answerdetailfeedback.AnswerId as int)
              WHERE UserSurveyResponse.Firm = @Firm
                AND UserSurveyResponse.SavedDate BETWEEN @startDate AND @endDate
				';


    IF (@QuestionNameOrCode IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (question.Name LIKE ''%'' + @QuestionNameOrCode + ''%'' OR question.Code LIKE ''%'' + @QuestionNameOrCode + ''%'')');

    IF (@QuestionSpecialCodes IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (question.Specode1 LIKE ''%'' + @QuestionSpecialCodes + ''%'' OR question.Specode2 LIKE ''%'' + @QuestionSpecialCodes + ''%'')');

    IF (@QuestionGroupName IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND (QuestionGroup.Name LIKE ''%'' + @QuestionGroupName + ''%'')');

    IF (@SurveyNameOrCode IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (survey.Code LIKE ''%'' + @SurveyNameOrCode + ''%'' OR survey.Name LIKE ''%'' + @SurveyNameOrCode + ''%'')');

    IF (@surveySpecialCodes IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (Survey.Specode1 LIKE ''%'' + @surveySpecialCodes + ''%'' OR Survey.Specode2 LIKE ''%'' + @surveySpecialCodes + ''%'')');

    IF (@ClientNameCodeOrEdino IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (client.Name LIKE ''%'' + @ClientNameCodeOrEdino + ''%'' OR client.Code LIKE ''%'' + @ClientNameCodeOrEdino + ''%'' OR client.Edino LIKE ''%'' + @ClientNameCodeOrEdino + ''%'')');

    IF (@ClientSpecialCodes IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND (client.SpecialCode LIKE ''%'' + @ClientSpecialCodes + ''%'')');

    IF (@SurveyContentType IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND surveyContentType = @SurveyContentType');

    IF (@userIds IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND (UserSurveyResponse.UserId IN (SELECT * FROM F_SplitList(@userIds, '','')))');

    IF (@questionStatus IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND Question.Status = @questionStatus');

    IF (@answerTxt IS NOT NULL)
        SET @sql = CONCAT(@sql, ' AND ( Answerdetailfeedback.Answers   LIKE ''%'' + @answerTxt + ''%'')');

    IF (@normativeNameOrCode IS NOT NULL)
        SET @sql = CONCAT(@sql,
                          ' AND (Normative.Code LIKE ''%'' + @normativeNameOrCode + ''%'' OR Normative.Name LIKE ''%'' + @normativeNameOrCode + ''%'')');

    IF @searchForStaticAnswers = 1
        BEGIN
            IF @staticAnswers IS NULL OR @staticAnswers = '4'
                BEGIN
                    SET @sql = CONCAT(@sql, ' AND  Answerdetailfeedback.Answers   IS NULL');
                END
            ELSE
                IF @staticAnswers = '1'
                    BEGIN
                        SET @sql = CONCAT(@sql, ' AND  Answerdetailfeedback.Answers   = ''Yes''');
                    END
                ELSE
                    IF @staticAnswers = '0'
                        BEGIN
                            SET @sql = CONCAT(@sql, ' AND  Answerdetailfeedback.Answers   = ''No''');
                        END
                    ELSE
                        IF @staticAnswers = '0,1'
                            BEGIN
                                SET @sql = CONCAT(@sql, ' AND  Answerdetailfeedback.Answers   IN (''Yes'', ''No'')');
                            END
                        ELSE
                            IF @staticAnswers = '4,1'
                                BEGIN
                                    SET @sql = CONCAT(@sql,
                                                      ' AND ( Answerdetailfeedback.Answers   IS NULL OR  Answerdetailfeedback.Answers   = ''Yes'')');
                                END
                            ELSE
                                IF @staticAnswers = '4,0'
                                    BEGIN
                                        SET @sql = CONCAT(@sql,
                                                          ' AND ( Answerdetailfeedback.Answers   IS NULL OR  Answerdetailfeedback.Answers   = ''No'')');
                                    END
                                ELSE
                                    IF @staticAnswers = '4,0,1' OR @staticAnswers = 'ALL' OR @staticAnswers = '-1'
                                        BEGIN
                                            SET @sql = CONCAT(@sql,
                                                              ' AND ( Answerdetailfeedback.Answers   IS NULL OR  Answerdetailfeedback.Answers   IN (''Yes'', ''No''))');
                                        END
        END
    ELSE
        IF @searchForStaticAnswers = 0
            BEGIN
                SET @sql = CONCAT(
                        @sql,
                        ' AND (NULLIF(@answerTxt, '''') IS NULL
                            OR  Answerdetailfeedback.Answers   COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ''%'' + @answerTxt + ''%'')'
                           );
            END


    DECLARE @countSql NVARCHAR(MAX) = CONCAT(@sql, ' ) SELECT @totalCountOut = COUNT(*) FROM Data');

    EXEC sp_executesql @countSql,
         N'@QuestionNameOrCode nvarchar(255),
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
           @answerTxt nvarchar(200),
           @normativeNameOrCode nvarchar(max),
           @totalCountOut int OUTPUT',
         @QuestionNameOrCode = @QuestionNameOrCode,
         @QuestionSpecialCodes = @QuestionSpecialCodes,
         @QuestionGroupName = @QuestionGroupName,
         @SurveyNameOrCode = @SurveyNameOrCode,
         @SurveySpecialCodes = @SurveySpecialCodes,
         @Firm = @Firm,
         @ClientNameCodeOrEdino = @ClientNameCodeOrEdino,
         @ClientSpecialCodes = @ClientSpecialCodes,
         @SurveyContentType = @SurveyContentType,
         @pointType = @pointType,
         @startDate = @startDate,
         @endDate = @endDate,
         @answersInSeperatedLines = @answersInSeperatedLines,
         @reasonsInSeparatedLines = @reasonsInSeparatedLines,
         @reasonTypes = @reasonTypes,
         @reasonIds = @reasonIds,
         @currentUserId = @currentUserId,
         @userIds = @userIds,
         @questionStatus = @questionStatus,
         @searchForStaticAnswers = @searchForStaticAnswers,
         @staticAnswers = @staticAnswers,
         @answerTxt = @answerTxt,
         @normativeNameOrCode = @normativeNameOrCode,
         @totalCountOut = @totalCount OUTPUT;

    IF @sorting IS NOT NULL
        BEGIN
            SET @sql = CONCAT(@sql, ' ) SELECT * FROM Data ORDER BY ', @sorting);
            IF (@skipCount IS NOT NULL AND @takeCount IS NOT NULL)
                SET @sql = CONCAT(@sql, ' OFFSET ', @skipCount, ' ROWS FETCH NEXT ', @takeCount, ' ROWS ONLY');
        END
    ELSE
        BEGIN
            SET @sql = CONCAT(@sql, ' ) SELECT * FROM Data ORDER BY SavedDate DESC');
            IF (@skipCount IS NOT NULL AND @takeCount IS NOT NULL)
                SET @sql = CONCAT(@sql, ' OFFSET ', @skipCount, ' ROWS FETCH NEXT ', @takeCount, ' ROWS ONLY');
        END

    PRINT @sql


    INSERT INTO @ProceedingDetails
        EXEC sp_executesql @sql,
             N'@QuestionNameOrCode nvarchar(255),
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
               @answerTxt nvarchar(200),
               @normativeNameOrCode nvarchar(max)',
             @QuestionNameOrCode = @QuestionNameOrCode,
             @QuestionSpecialCodes = @QuestionSpecialCodes,
             @QuestionGroupName = @QuestionGroupName,
             @SurveyNameOrCode = @SurveyNameOrCode,
             @SurveySpecialCodes = @SurveySpecialCodes,
             @Firm = @Firm,
             @ClientNameCodeOrEdino = @ClientNameCodeOrEdino,
             @ClientSpecialCodes = @ClientSpecialCodes,
             @SurveyContentType = @SurveyContentType,
             @pointType = @pointType,
             @startDate = @startDate,
             @endDate = @endDate,
             @answersInSeperatedLines = @answersInSeperatedLines,
             @reasonsInSeparatedLines = @reasonsInSeparatedLines,
             @reasonTypes = @reasonTypes,
             @reasonIds = @reasonIds,
             @currentUserId = @currentUserId,
             @userIds = @userIds,
             @questionStatus = @questionStatus,
             @searchForStaticAnswers = @searchForStaticAnswers,
             @staticAnswers = @staticAnswers,
             @answerTxt = @answerTxt,
             @normativeNameOrCode = @normativeNameOrCode;


    SELECT * FROM @ProceedingDetails
END;