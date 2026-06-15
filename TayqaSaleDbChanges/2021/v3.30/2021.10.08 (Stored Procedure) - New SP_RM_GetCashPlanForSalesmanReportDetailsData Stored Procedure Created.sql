/****** Object:  StoredProcedure [dbo].[SP_RM_GetCashPlanForSalesmanReportDetailsData]    Script Date: 10/8/2021 3:07:32 PM ******/

ALTER PROCEDURE [dbo].[SP_RM_GetCashPlanForSalesmanReportDetailsData](
    @firm SMALLINT =NULL,
    @users NVARCHAR(500) =NULL,
    @clients NVARCHAR(500)= NULL,
    @months NVARCHAR(500)= NULL,
    @years NVARCHAR(500)= NULL,
    @salesmanId INT =NULL,
    @currencyType INT =NULL,
    @currentUserId INT =NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

	SET @Query =
        'WITH FACTQUERY AS (
            SELECT
                FOD.Firm,
                Q.UserId,
                Q.EmployeeId AS SalesmanId,
                YEAR(FOD.[Date]) AS [Year],
                MONTH(FOD.[Date]) AS [Month],
                SUM(FOD.Amount) AS Amount,
                CurrencyType,
                ClientId
            FROM ERP_FinanceOperation FOD
            JOIN (SELECT DISTINCT UEM.Firm, UEM.EmployeeId, UEM.UserId FROM UIM_UserEmployeeMapping UEM WHERE UEM.UserId IN (SELECT F.UserId FROM F_GetPermittedUsers(@currentUserId) F)) Q
            ON Q.Firm=FOD.Firm AND Q.EmployeeId=FOD.SalesmanId
            WHERE
                FOD.[Type] IN (5, 21) AND
                FOD.[Sign] = 1' -- ))'

    IF @users IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Q.[UserId] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @users, ''',', ''','')))')

    --SET @Query = CONCAT(@Query, '))')
    
    IF @salesmanId IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (FOD.SalesmanId = @salesmanId)')

    IF @firm IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (FOD.Firm = @firm)')

    IF @currencyType IS NOT NULL
            SET @Query = CONCAT(@Query, ' AND (FOD.CurrencyType = @currencyType)')
            
    SET @Query = CONCAT(@Query, 'GROUP BY
                                    FOD.Firm,
                                    FOD.ClientId,
                                    YEAR(FOD.[Date]),
                                    MONTH(FOD.[Date]),
                                    Q.UserId,
                                    Q.EmployeeId,
                                    FOD.CurrencyType)
                                SELECT
                                    C.Firm,
                                    FQ.UserId,
                                    FQ.SalesmanId,
                                    C.Name AS ClientName,
                                    C.Code AS ClientCode,
                                    FQ.[Year],
                                    FQ.[Month],
                                    FQ.CurrencyType,
                                    CAST(FQ.Amount AS float) AS FactAmount
                                FROM FACTQUERY FQ
                                JOIN MD_Firm F ON FQ.Firm = F.Nr AND FQ.CurrencyType = F.LocalCurrencyTypeId
                                JOIN MD_Client C ON FQ.Firm = C.Firm
                                AND FQ.ClientId = C.TigerId
                                WHERE (1=1)')

    IF @years IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (FQ.[Year] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @years, ''',', ''','')))')

    IF @months IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (FQ.[Month] IN (SELECT LTRIM(Value) FROM F_SplitList(''', @months, ''',', ''','')))')

    IF @clients IS NOT NULL
		SET @Query = CONCAT(@Query, ' AND (C.Code IN (SELECT LTRIM(Value) FROM F_SplitList(''', @clients, ''',', ''','')))')

    --SET @Query = CONCAT(@Query, ')')

    PRINT CAST(@Query as NTEXT)

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
											@users NVARCHAR(500),
											@clients NVARCHAR(500),
											@months NVARCHAR(500),
											@years  NVARCHAR(500),
                                            @salesmanId INT NULL,
											@currencyType INT NULL,
											@currentUserId INT NULL',
         @firm=@firm,
         @users=@users,
         @clients = @clients,
         @months = @months,
         @years = @years,
         @salesmanId=@salesmanId,
         @currencyType=@currencyType,
         @currentUserId=@currentUserId
END
