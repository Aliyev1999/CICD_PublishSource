ALTER FUNCTION [dbo].[F_MD_GetClientItemQuantityOperationRestriction](@firm smallint, @tigerClientId INT, @proccessDate DATE, @operationId TINYINT)
    RETURNS @T TABLE
               (
                   Id               INT,
                   Firm             SMALLINT,
                   TigerClientId    INT,
                   TigerItemId      INT,
                   OperationId      TINYINT,
                   StartDate        DATE,
                   EndDate          DATE,
                   MaxQuantity      FLOAT,
				   CreationTime     DATETIME,
				   CreatorUserName  NVARCHAR(MAX)
               )
AS
BEGIN

    INSERT INTO @T
    SELECT Id,
           Firm,
           TigerClientId,
           TigerItemId,
           OperationId,
           StartDate,
           EndDate,
           MaxQuantity,
		   CreationTime,
		   CreatorUserName
    FROM (
             SELECT R.Id,
                    Firm,
                    TigerClientId,
                    TigerItemId,
                    OperationId,
                    StartDate,
                    EndDate,
                    MaxQuantity,
                    ROW_NUMBER() OVER (PARTITION BY Firm,TigerClientId,TigerItemId, OperationId ORDER BY DATEDIFF(DAY, @proccessDate, EndDate)) AS RowNumber,
					IIF(R.LastModificationTime IS NOT NULL, R.LastModificationTime, R.CreationTime) AS CreationTime, -- R.CreationTime
					IIF(R.LastModifierUserId IS NOT NULL, MU.UserName, CU.UserName) AS CreatorUserName
             FROM MD_ClientItemQuantityOperationRestriction R
			 LEFT JOIN AbpUsers CU ON R.CreatorUserId = CU.Id
			 LEFT JOIN AbpUsers MU ON R.LastModifierUserId = MU.Id
             WHERE TigerClientId = @tigerClientId
               AND @proccessDate >= StartDate
               AND @proccessDate <= EndDate
               AND @operationId=OperationId 
			   AND @firm = Firm 
               AND Status = 0
         ) result
    WHERE result.RowNumber = 1
    RETURN;
END
