
ALTER PROCEDURE [dbo].[SP_OP_GetThirdPartyInvoices]
	@firm smallint,
	@startDate datetime,
	@endDate datetime,
	@docType tinyint null,
	@invoiceId int null,
	@users nvarchar(max) null,
	@clientNameCodeEdino nvarchar(max) null,
	@status tinyint null,
	@skipCount int null,
	@takeCount int null,
	@sorting nvarchar(255),
    @totalCount INT OUT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
        DECLARE @Result TABLE (
            RequestId INT,
            Status TINYINT,
            DocCreatedTime DATETIME,
            FirmName NVARCHAR(MAX),
            DocType TINYINT,
            Username NVARCHAR(MAX),
            UserFullName NVARCHAR(MAX),
            ClientName NVARCHAR(MAX),
            ClientCode NVARCHAR(MAX),
            Edino NVARCHAR(MAX),
            TotalAmount FLOAT
        );

        WITH MainData AS (
            SELECT
                ilog.Id AS RequestId,
                CASE
                    WHEN ISNULL(queue.ProcessingStatus, 0) = 1 THEN 1
                    WHEN SUM(line.Amount - lineResult.Amount) = 0 THEN 2
                    WHEN glog.ImportResult = 969 or rqueue.step = 11 THEN 3
					WHEN SUM(line.Amount - lineResult.Amount) > 0  THEN 4
                    else 1
                END AS Status,
                ilog.DocCreatedTime AS DocCreatedTime,
                firm.Name AS FirmName,
                ilog.DocType AS DocType,
                u.UserName AS Username,
                u.Name + u.Surname AS UserFullName,
                client.Name AS ClientName,
                client.Code AS ClientCode,
                client.Edino AS Edino,
                SUM(line.Price * iif(line.IsPromo=0,line.Amount,0)-line.DiscountAmount) AS TotalAmount
            FROM
                OP_ThirdPartyIncomingLog ilog
			LEFT JOIN 
				OP_GeneralLog glog on ilog.Id = glog.RequestId
			LEFT JOIN 
				OP_RequestQueue rqueue  on rqueue.Id = ilog.Id
            JOIN
                OP_ThirdPartyIncomingLogCommonLineExtension line ON ilog.Id = line.Id
            JOIN
                MD_Firm firm ON firm.Nr = ilog.Firm
            JOIN
                AbpUsers u ON u.Id = ilog.UserId
            JOIN
                MD_Client client ON client.TigerId = ilog.ClientId
			LEFT JOIN
				OP_ThirdPartyRequestQueue queue ON queue.Id = ilog.Id
            LEFT JOIN
                OP_ThirdPartyCommonLineResultLog lineResult ON line.Id = lineResult.Id
                AND line.ItemId = lineResult.ItemId
                AND line.IsPromo = lineResult.IsPromo
            WHERE ';

    IF @firm IS NOT NULL
        SET @sql = @sql + ' firm.Nr = @firm AND ';

    SET @sql = @sql + '
                ilog.DocCreatedTime >= @startDate AND ilog.DocCreatedTime <= @endDate ';

    IF @docType IS NOT NULL
        SET @sql = @sql + ' AND ilog.DocType = @docType ';

    IF @invoiceId IS NOT NULL
        SET @sql = @sql + ' AND ilog.Id = @invoiceId ';

    IF @users IS NOT NULL
        SET @sql = @sql + ' AND ilog.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '','')) ';

    IF @clientNameCodeEdino IS NOT NULL
        SET @sql = @sql + ' AND (client.Code LIKE ''%'' + @clientNameCodeEdino + ''%'' OR client.Name LIKE ''%'' + @clientNameCodeEdino + ''%'' OR client.Edino LIKE ''%'' + @clientNameCodeEdino + ''%'') ';

    SET @sql = @sql + '
            GROUP BY
                ilog.Id,
                ilog.ProcessingStatus,
                firm.Name,
                ilog.DocType,
                u.UserName,
                u.Name,
                u.Surname,
                client.Name,
                client.Code,
                ilog.DocCreatedTime,
                client.Edino,
				queue.ProcessingStatus,
				glog.ImportResult,
				rqueue.step
        '

	 SET @sql = @sql + '
	 union

	 SELECT
            ilog.Id AS RequestId,
            CASE
                WHEN ISNULL(queue.ProcessingStatus, 0) = 1 THEN 1
                WHEN SUM(line.Amount - lineResult.Amount) = 0 THEN 2
                WHEN glog.ImportResult = 969 or rqueue.step = 11 THEN 3
				WHEN SUM(line.Amount - lineResult.Amount) > 0  THEN 4
                ELSE 1
            END AS Status,
            ilog.DocCreatedTime AS DocCreatedTime,
            firm.Name AS FirmName,
            ilog.DocType AS DocType,
            u.UserName AS Username,
            u.Name + u.Surname AS UserFullName,
            client.Name AS ClientName,
            client.Code AS ClientCode,
            client.Edino AS Edino,
            line.Amount AS TotalAmount
        FROM
            OP_ThirdPartyIncomingLog ilog
		LEFT JOIN 
				OP_GeneralLog glog on ilog.Id = glog.RequestId
		LEFT JOIN 
				OP_RequestQueue rqueue  on rqueue.Id = ilog.Id
        JOIN
            OP_ThirdPartyIncomingLogCashExtension line ON ilog.Id = line.Id
        JOIN
            MD_Firm firm ON firm.Nr = ilog.Firm
        JOIN
            AbpUsers u ON u.Id = ilog.UserId
        JOIN
            MD_Client client ON client.TigerId = ilog.ClientId
		LEFT JOIN
				OP_ThirdPartyRequestQueue queue ON queue.Id = ilog.Id
        LEFT JOIN
            OP_ThirdPartyCashResultLog lineResult ON line.Id = lineResult.Id
            AND line.Id = lineResult.Id
		WHERE
	 '
	 IF @firm IS NOT NULL
        SET @sql = @sql + ' firm.Nr = @firm AND ';

    SET @sql = @sql + '
                ilog.DocCreatedTime >= @startDate AND ilog.DocCreatedTime <= @endDate ';

    IF @docType IS NOT NULL
        SET @sql = @sql + ' AND ilog.DocType = @docType ';

    IF @invoiceId IS NOT NULL
        SET @sql = @sql + ' AND ilog.Id = @invoiceId ';

    IF @users IS NOT NULL
        SET @sql = @sql + ' AND ilog.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '','')) ';

    IF @clientNameCodeEdino IS NOT NULL
        SET @sql = @sql + ' AND (client.Code LIKE ''%'' + @clientNameCodeEdino + ''%'' OR client.Name LIKE ''%'' + @clientNameCodeEdino + ''%'' OR client.Edino LIKE ''%'' + @clientNameCodeEdino + ''%'') ';

    SET @sql = @sql + '
            GROUP BY
				ilog.Id,
				ilog.ProcessingStatus,
				firm.Name,
				ilog.DocType,
				u.UserName,
				u.Name,
				u.Surname,
				client.Name,
				client.Code,
				ilog.DocCreatedTime,
				client.Edino,
				line.Amount,
				queue.ProcessingStatus,
				glog.ImportResult,
				rqueue.step
        '


	SET @sql = @sql + '
	 union

	 SELECT
                ilog.Id AS RequestId,
                CASE
                    WHEN ISNULL(queue.ProcessingStatus, 0) = 1 THEN 1
                    WHEN SUM(line.Quantity - lineResult.Quantity) = 0 THEN 2
                    WHEN glog.ImportResult = 969 or rqueue.step = 11 THEN 3
					WHEN SUM(line.Quantity - lineResult.Quantity) > 0  THEN 4
                    ELSE 1
                END AS Status,
                ilog.DocCreatedTime AS DocCreatedTime,
                firm.Name AS FirmName,
                ilog.DocType AS DocType,
                u.UserName AS Username,
                u.Name + u.Surname AS UserFullName,
				null AS ClientName,
				null AS ClientCode,
				null AS Edino,
                Cast(0 as Float) AS TotalAmount
            FROM
                OP_ThirdPartyIncomingLog ilog
			LEFT JOIN 
				OP_GeneralLog glog on ilog.Id = glog.RequestId
			LEFT JOIN 
				OP_RequestQueue rqueue  on rqueue.Id = ilog.Id
            JOIN
                OP_ThirdPartyIncomingLogWarehouseOperationLineExtension line ON ilog.Id = line.Id
            JOIN
                MD_Firm firm ON firm.Nr = ilog.Firm
            JOIN
                AbpUsers u ON u.Id = ilog.UserId
			LEFT JOIN
				OP_ThirdPartyRequestQueue queue ON queue.Id = ilog.Id
            LEFT JOIN
                OP_ThirdPartyWarehouseOperationLineResultLog lineResult ON line.Id = lineResult.Id
                AND line.ItemId = lineResult.ItemId
		WHERE
	 '
	 IF @firm IS NOT NULL
        SET @sql = @sql + ' firm.Nr = @firm AND ';

    SET @sql = @sql + '
                ilog.DocCreatedTime >= @startDate AND ilog.DocCreatedTime <= @endDate ';

    IF @docType IS NOT NULL
        SET @sql = @sql + ' AND ilog.DocType = @docType ';

    IF @invoiceId IS NOT NULL
        SET @sql = @sql + ' AND ilog.Id = @invoiceId ';

    IF @users IS NOT NULL
        SET @sql = @sql + ' AND ilog.UserId IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '','')) ';

    SET @sql = @sql + '
            GROUP BY
                ilog.Id,
                ilog.ProcessingStatus,
                firm.Name,
                ilog.DocType,
                u.UserName,
                u.Name,
                u.Surname,
                ilog.DocCreatedTime,
				queue.ProcessingStatus,
				glog.ImportResult,
				rqueue.step
        )'




       SET @sql = @sql + ' INSERT INTO @Result (
            RequestId,
            Status,
            DocCreatedTime,
            FirmName,
            DocType,
            Username,
            UserFullName,
            ClientName,
            ClientCode,
            Edino,
            TotalAmount
        )
        SELECT * FROM MainData ';


		IF @status IS NOT NULL
			SET @sql = @sql + ' WHERE Status = @status ';

		SET @sql = @sql + '
			SET @totalCount = (SELECT COUNT(*) FROM @Result);
			SELECT * FROM @Result ';
	
		IF @sorting IS NOT NULL
			set @sql = @sql+ ' ORDER BY ' + @sorting;

		IF @skipCount IS NOT NULL AND @takeCount IS NOT NULL
			set @sql = @sql + ' offset  @skipCount rows fetch next @takeCount rows only';

		 PRINT CAST(@sql AS NTEXT);

    EXEC sp_executesql @sql,
        N'@firm smallint, 
		@startDate datetime, 
		@endDate datetime, 
		@docType tinyint, 
		@invoiceId int, 
		@users nvarchar(max), 
		@clientNameCodeEdino nvarchar(max), 
		@status tinyint,	
		@skipCount int,
		@takeCount int,
		@sorting nvarchar(255), 
		@totalCount INT OUTPUT',
        @firm, 
		@startDate, 
		@endDate, 
		@docType, 
		@invoiceId, 
		@users, 
		@clientNameCodeEdino, 
		@status,
		@skipCount ,
		@takeCount, 
		@sorting,
		@totalCount OUTPUT;
END;


select ISNULL(ProcessDate,'') from OP_ThirdPartyRequestQueue