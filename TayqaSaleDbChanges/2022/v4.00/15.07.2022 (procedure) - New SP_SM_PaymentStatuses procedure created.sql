
/****** Object:  StoredProcedure [dbo].[SP_SM_PaymentStatuses]    Script Date: 7/15/2022 11:48:15 AM ******/

CREATE  PROCEDURE [dbo].[SP_SM_PaymentStatuses](
											@firm SMALLINT NULL,
											@beginDate DATE NULL,
											@endDate DATE NULL,
											@divisions NVARCHAR(500) NULL,
											@departments NVARCHAR(500) NULL,
											@clientNameOrCode NVARCHAR(MAX) NULL,
											@salesmanNameOrCode NVARCHAR(MAX) NULL,
											@cashNameOrCode NVARCHAR(MAX) NULL,
											@docStatus TINYINT = NULL,
											@isCancelled BIT = NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX) = 'SELECT FO.Period,
										   F.[Name]			AS FirmName,
										   F.Nr				AS FirmNr,
										   FO.ERPId,
										   FO.[Date]		AS DocDate,
										   C.Code			AS ClientCode,
										   C.[Name]			AS ClientName,
										   S.[Name]			AS SalesmanName,
										   S.Code			AS SalesmanCode,
										   CC.Code			AS CashCode,
										   CC.[Name]		AS CashName,
										   DIV.[Name]		AS Division,
										   DEP.[Name]		AS Department,
										   IL.DocStatus,
										   FO.IsCancelled,
										   FO.Amount
									FROM ERP_FinanceOperation FO WITH (NOLOCK)
											 JOIN MD_Division DIV  WITH (NOLOCK) ON FO.Division = DIV.Nr AND FO.Firm = DIV.Firm and DIV.IsDeleted = 0
											 JOIN MD_Department DEP  WITH (NOLOCK) ON FO.Department = DEP.Nr AND FO.Firm = DEP.Firm and dep.IsDeleted = 0
											 JOIN MD_Firm F  WITH (NOLOCK) ON FO.Firm = F.Nr and f.IsActive = 1
											 JOIN MD_Client C  WITH (NOLOCK) ON FO.ClientId = C.TigerId AND FO.Firm = C.Firm AND C.[Status] = 0 AND C.IsDeleted = 0
											 JOIN MD_Salesman S  WITH (NOLOCK) ON FO.SalesmanId = S.TigerId AND FO.Firm = S.Firm AND S.IsDeleted = 0 AND S.[Status] = 0
											 JOIN OP_GeneralLog GL WITH (NOLOCK) ON GL.TigerId = FO.ERPId AND GL.ImportResult = 0
											 JOIN OP_IncomingLog IL ON IL.Id = GL.RequestId
											 JOIN OP_IncomingLogCashExtension CEX WITH (NOLOCK) ON CEX.Id = GL.RequestId 
											 JOIN MD_CashCard CC WITH (NOLOCK) ON CC.Code = CEX.CashCode AND CC.Firm = FO.Firm AND CC.IsDeleted = 0
											 WHERE 1 = 1'

    IF @firm IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND F.Nr = @firm')
    
	IF @beginDate IS NOT NULL AND @endDate IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (CONVERT(DATE, FO.[Date]) >= @beginDate)')

	IF @endDate IS NOT NULL AND @endDate IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (CONVERT(DATE, FO.[Date]) <= @endDate)')

	IF @divisions IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (DIV.Nr IN (SELECT TRIM([Value]) FROM F_SplitList(@divisions, '','')))')

	IF @departments IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (DEP.Nr IN (SELECT TRIM([Value]) FROM F_SplitList(@departments, '','')))')

	IF @clientNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (C.Name LIKE ''%'+@clientNameOrCode+'%'' OR C.Code LIKE ''%'+@clientNameOrCode+'%'')')

	IF @salesmanNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (S.Name LIKE ''%'+@salesmanNameOrCode+'%'' OR S.Code LIKE ''%'+@salesmanNameOrCode+'%'')')

	IF @cashNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (CC.Name LIKE ''%'+@cashNameOrCode+'%'' OR CC.Code LIKE ''%'+@cashNameOrCode+'%'')')
	
	IF @docStatus IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (IL.DocStatus = @docStatus)')

	IF @isCancelled IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (FO.IsCancelled = @isCancelled)')

	SET @Query = CONCAT(@Query, ' ORDER BY FO.[Date] DESC')

	PRINT CAST(@Query as NTEXT)


    EXEC sp_executesql @Query, N'@firm SMALLINT,
								 @beginDate DATE,
								 @endDate DATE,
								 @divisions NVARCHAR(500),
								 @departments NVARCHAR(500),
								 @clientNameOrCode NVARCHAR(MAX),
								 @salesmanNameOrCode NVARCHAR(MAX),
								 @cashNameOrCode NVARCHAR(MAX),
								 @docStatus TINYINT,
								 @isCancelled BIT',
								 
								 @firm=@firm,
								 @beginDate=@beginDate,
								 @endDate=@endDate,
								 @divisions=@divisions,
								 @departments=@departments,
								 @clientNameOrCode=@clientNameOrCode,
								 @salesmanNameOrCode=@salesmanNameOrCode,
								 @cashNameOrCode=@cashNameOrCode,
								 @docStatus=@docStatus,
								 @isCancelled=@isCancelled
END
