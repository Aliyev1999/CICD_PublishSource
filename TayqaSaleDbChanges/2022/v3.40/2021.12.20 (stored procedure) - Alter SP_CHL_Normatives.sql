ALTER PROCEDURE [dbo].[SP_CHL_Normatives](
											@firm SMALLINT NULL,
											@status BIT NULL,
											@normativeNameOrCode NVARCHAR(500) NULL,
											@questionNameOrCode NVARCHAR(500) NULL,
											@clientNameCodeOrEdino NVARCHAR(500) NULL,
											@clientGroupNameOrCode NVARCHAR(500) NULL,
											@clientGroupType SMALLINT NULL,
											@searchByCreationTime BIT NULL,
											@startDate DATETIME NULL,
											@endDate DATETIME NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
			SELECT DISTINCT
				N.Name,
				N.Code,
				N.Firm AS FirmNr,
				N.Id,
				N.CreationTime,
				N.[Description],
				N.[Status],
				N.StartDate,
				N.EndDate,
				N.Type,
				F.Name AS FirmName,
                (SELECT COUNT(*) FROM MD_Client CL WHERE CL.TigerId IN (SELECT ClientId FROM CHL_NormativeForClient WHERE NormativeId = N.Id AND Firm = N.Firm) AND Firm = N.Firm AND (CL.IsDeleted  IS NULL OR CL.IsDeleted = 0) AND CL.[Status] = 0) AS ClientsCount,
                (SELECT COUNT(*) FROM MD_ClientGroupInfo CGR WHERE CGR.GroupId IN (SELECT GroupId FROM CHL_NormativeForClientGroup WHERE NormativeId = N.Id AND Firm = N.Firm) AND Firm = N.Firm AND CGR.IsDeleted = 0 AND CGR.GroupType = @clientGroupType) AS ClientGroupsCount
			FROM CHL_Normative N
					JOIN MD_Firm F ON N.Firm = F.Nr
                    LEFT JOIN CHL_QuestionNormativeMapping QNM ON QNM.NormativeId = N.Id
                    LEFT JOIN CHL_Question Q ON QNM.QuestionId = Q.Id
					LEFT JOIN CHL_NormativeForClient CN ON CN.NormativeId = N.Id
					LEFT JOIN CHL_NormativeForClientGroup CGN ON CGN.NormativeId = N.Id
					LEFT JOIN MD_ClientGroupInfo CG ON CG.GroupId = CGN.GroupId AND CG.Firm = CGN.Firm AND CG.IsDeleted = 0
					LEFT JOIN MD_Client C ON C.TigerId = CN.ClientId AND C.Firm = CN.Firm AND C.[Status]=0 AND (C.IsDeleted IS NULL OR C.IsDeleted = 1)
					LEFT JOIN MD_Client CC ON CC.TigerId = CN.ClientId AND CC.Firm = CN.Firm
			WHERE (1 = 1)'

	-- PRINT CAST(@Query as NTEXT)

    IF @firm IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND F.Nr = @firm')

	IF @status IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND N.[Status] = @status')
    
	IF @startDate IS NOT NULL AND @endDate IS NOT NULL AND (@searchByCreationTime = 1)
		SET @Query = CONCAT(@Query, ' AND (N.CreationTime BETWEEN @startDate AND @endDate)')

    IF @clientNameCodeOrEdino IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (C.Name LIKE ''%'+@clientNameCodeOrEdino+ '%'' OR C.Code LIKE ''%'+@clientNameCodeOrEdino+'%'' OR C.Edino LIKE ''%'+@clientNameCodeOrEdino+'%'')')

	IF @clientGroupNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (CG.GroupName LIKE ''%'+@clientGroupNameOrCode+'%'' OR CG.GroupCode LIKE ''%'+@clientGroupNameOrCode+'%'')')

	IF @normativeNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (N.Name LIKE ''%'+@normativeNameOrCode+'%'' OR N.Code LIKE ''%'+@normativeNameOrCode+'%'')')

    IF @questionNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (Q.Name LIKE ''%'+@questionNameOrCode+'%'' OR Q.Code LIKE ''%'+@questionNameOrCode+'%'')')

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
									@status BIT,
									@normativeNameOrCode NVARCHAR(500),
									@questionNameOrCode NVARCHAR(500),
									@clientNameCodeOrEdino NVARCHAR(500),
									@clientGroupNameOrCode NVARCHAR(500),
									@clientGroupType SMALLINT,
									@searchByCreationTime BIT,
									@startDate DATETIME,
									@endDate DATETIME',
									@firm=@firm,
									@status=@status,
									@normativeNameOrCode = @normativeNameOrCode,
									@questionNameOrCode = @questionNameOrCode,
									@clientNameCodeOrEdino = @clientNameCodeOrEdino,
									@clientGroupNameOrCode = @clientGroupNameOrCode,
									@clientGroupType = @clientGroupType,
									@searchByCreationTime = @searchByCreationTime,
									@startDate = @startDate,
									@endDate = @endDate
END
GO