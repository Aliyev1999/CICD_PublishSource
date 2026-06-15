CREATE FUNCTION [dbo].[F_MD_GetClientGroupItemQuantityOperationRestriction](@firm smallint, @tigerClientId INT, @proccessDate DATE, @operationId TINYINT)
    RETURNS @T TABLE
               (
                   Id               INT,
                   Firm             SMALLINT,
				   GroupName        NVARCHAR(50),
				   GroupCode		NVARCHAR(50),
				   GroupType		smallint,
                   TigerItemId      INT,
                   OperationId      TINYINT,
                   StartDate        DATE,
                   EndDate          DATE,
                   MaxQuantity      FLOAT,
				   CreationTime     DATETIME,
				   CreatorUserName  NVARCHAR(50)
               )
AS
BEGIN

    INSERT INTO @T
    SELECT Id,
           Firm,
           GroupName,
           GroupCode,
		   GroupType,
           TigerItemId,
           OperationId,
           StartDate,
           EndDate,
           MaxQuantity,
		   CreationTime,
		   CreatorUserName
    FROM (
             SELECT R.Id,
                    r.Firm as Firm,
                    cgi.GroupName as GroupName,
                    cgi.GroupCode as GroupCode,
					cgi.GroupType,
                    TigerItemId,
                    OperationId,
                    StartDate,
                    EndDate,
                    MaxQuantity,
                    ROW_NUMBER() OVER (PARTITION BY R.Firm,cgd.ClientId,TigerItemId, OperationId ORDER BY DATEDIFF(DAY, @proccessDate, EndDate)) AS RowNumber,
					IIF(R.LastModificationTime IS NOT NULL, R.LastModificationTime, R.CreationTime) AS CreationTime, -- R.CreationTime
					IIF(R.LastModifierUserId IS NOT NULL, MU.UserName, CU.UserName) AS CreatorUserName
             FROM MD_ClientGroupItemQuantityOperationRestriction R
			 LEFT JOIN AbpUsers CU ON R.CreatorUserId = CU.Id
			 LEFT JOIN AbpUsers MU ON R.LastModifierUserId = MU.Id
			 INNER JOIN MD_ClientGroupData cgd on cgd.GroupId = r.ClientGroupId and cgd.Firm = r.Firm
			 LEFT JOIN MD_ClientGroupInfo cgi on cgd.GroupId = cgi.GroupId and cgd.Firm = cgi.Firm
             WHERE cgd.ClientId = @tigerClientId
               AND @proccessDate >= StartDate
               AND @proccessDate <= EndDate
               AND @operationId=OperationId 
			   AND @firm = r.Firm 
               AND Status = 0
         ) result
    WHERE result.RowNumber = 1
    RETURN;
END