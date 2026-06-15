ALTER PROCEDURE [dbo].[SP_SM_PaymentStatuses](
    @firm SMALLINT NULL,
    @beginDate DATE NULL,
    @endDate DATE NULL,
    @divisions NVARCHAR(500) NULL,
    @users NVARCHAR(500) NULL,
    @departments NVARCHAR(500) NULL,
    @clientNameOrCode NVARCHAR(MAX) NULL,
    @salesmanNameOrCode NVARCHAR(MAX) NULL,
    @cashNameOrCode NVARCHAR(MAX) NULL,
    @docStatus TINYINT = NULL,
    @isCancelled BIT = NULL,
	@reasonIds nvarchar(100))
AS
BEGIN

     DECLARE @Query NVARCHAR(MAX) = '
	
	SELECT FinOps.Period                                            as Period,
       Firm.[Name]													as FirmName,
       Firm.Nr														as FirmNr,
       cast(FinOps.Id as bigint)									as ERPId,
       FinOps.ProcessDate											AS DocDate,
       Client.Code													as ClientCode,
       Client.[Name]												as ClientName,
       isnull(Salesman.[Name], '''')                               as SalesmanName,
       isnull(Salesman.Code, '''')                                 as SalesmanCode,
       json_value(Response.ImportResult, ''$.ERPDocInfo.FicheNo'') as CashCode,
       concat(CashCard.Code, '' - '', CashCard.[Name])             as CashName,
       ''''														   as Division,
       ''''														   as Department,
       FinOps.DocStatus											   as DocStatus,
       cast(iif(FinOps.DocStatus = 99, 1, 0) as bit)			   as IsCancelled,
       Extension.Amount											   as Amount,
       BMUsers.UserName											   as SalesPersonHeadName,
       SMUsers.UserName											   as SaleManagerName,
       usr.UserName												   as UserName

FROM OP_IncomingLog FinOps WITH (NOLOCK)
         JOIN MD_Firm Firm WITH (NOLOCK) ON FinOps.Firm = Firm.Nr --and Firm.IsActive = 1
         JOIN MD_Client Client WITH (NOLOCK) ON FinOps.ClientId = Client.TigerId AND FinOps.Firm = Client.Firm and Client.IsDeleted = 0
         JOIN OP_GeneralLog GenLog WITH (NOLOCK) ON GenLog.RequestId = FinOps.Id AND GenLog.ImportResult = 0
         JOIN OP_ERPIntegrationtResultLog Response with (nolock) on Response.GeneralId = GenLog.Id
         JOIN OP_IncomingLogCashExtension Extension WITH (NOLOCK) ON Extension.Id = GenLog.RequestId
         JOIN MD_CashCard CashCard WITH (NOLOCK) ON CashCard.Code = Extension.CashCode AND CashCard.Firm = FinOps.Firm --AND CashCard.IsDeleted = 0
         LEFT JOIN MD_Division Division WITH (NOLOCK) ON FinOps.Division = Division.Nr AND FinOps.Firm = Division.Firm --and Division.IsDeleted = 0
         LEFT JOIN MD_Department Department WITH (NOLOCK) ON FinOps.Department = Department.Nr AND FinOps.Firm = Department.Firm --and Department.IsDeleted = 0
         LEFT JOIN MD_Salesman Salesman WITH (NOLOCK) ON FinOps.SalesmanRef = Salesman.TigerId AND FinOps.Firm = Salesman.Firm --AND Salesman.IsDeleted = 0
         left join (select Parent.UserId,
                           max(BM.UserId) as BmUser,
                           max(SM.UserId) as SmUser
                    from F_UIM_OrganizationUserParent(0) Parent
                             left join F_GetUsersByType(''SalesPersonHead'') BM on BM.UserId = Parent.ParentId
                             left join F_GetUsersByType(''SaleManager'') SM on SM.UserId = Parent.ParentId
                    group by Parent.UserId) UserParents on UserParents.UserId = FinOps.UserId
         left join AbpUsers BMUsers with (nolock) on BMUsers.Id = UserParents.BmUser
         left join AbpUsers SMUsers with (nolock) on SMUsers.Id = UserParents.SmUser
         left join AbpUsers usr on usr.Id = FinOps.UserId and usr.IsActive = 1 and usr.IsDeleted = 0
WHERE 1 = 1

	'

    IF @firm IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Firm.Nr = @firm')

    IF @beginDate IS NOT NULL AND @endDate IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (CONVERT(DATE, FinOps.[ProcessDate]) >= @beginDate)')

    IF @endDate IS NOT NULL AND @endDate IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (CONVERT(DATE, FinOps.[ProcessDate]) <= @endDate)')

    IF @divisions IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Division.Nr IN (SELECT TRIM([Value]) FROM F_SplitList(@divisions, '','')))')

    IF @departments IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Department.Nr IN (SELECT TRIM([Value]) FROM F_SplitList(@departments, '','')))')

    IF @clientNameOrCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Client.Name LIKE ''%' + @clientNameOrCode + '%'' OR Client.Code LIKE ''%' + @clientNameOrCode + '%'')')

    IF @salesmanNameOrCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Salesman.Name LIKE ''%' + @salesmanNameOrCode + '%'' OR Salesman.Code LIKE ''%' + @salesmanNameOrCode + '%'')')

    IF @cashNameOrCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (json_value(Response.ImportResult, ''$.ERPDocInfo.FicheNo'') like ''%' + @cashNameOrCode + '%'' OR CashCard.Name LIKE ''%' + @cashNameOrCode + '%'' OR CashCard.Code LIKE ''%' + @cashNameOrCode + '%'')')

    IF @docStatus IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (FinOps.DocStatus = @docStatus)')

    IF @isCancelled IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (cast(iif(FinOps.DocStatus=99,1,0) as bit) = @isCancelled)')

    SET @Query = CONCAT(@Query, ' ORDER BY FinOps.[ProcessDate] DESC')

	--print @query

    EXEC sp_executesql @Query, N'@firm SMALLINT,
								 @beginDate DATE,
								 @endDate DATE,
								 @divisions NVARCHAR(500),
								 @users NVARCHAR(500),
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
         @users=@users,
         @departments=@departments,
         @clientNameOrCode=@clientNameOrCode,
         @salesmanNameOrCode=@salesmanNameOrCode,
         @cashNameOrCode=@cashNameOrCode,
         @docStatus=@docStatus,
         @isCancelled=@isCancelled

END