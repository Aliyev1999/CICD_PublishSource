
CREATE FUNCTION F_MD_GetClientRelatedDocumentCountForDocumentCountRestriction
(
	@referenceId int,
	@operationId tinyint,
	@firm tinyint,
	@warehouseNr int = null,
	@userId int,
	@clientId int
)
RETURNS FLOAT
AS
BEGIN
	RETURN (SELECT SUM(ss.DocumentCount) AS Counts
			FROM (SELECT COUNT(*) AS DocumentCount
				  FROM OP_IncomingLog i WITH (NOLOCK)
				  JOIN OP_GeneralLog g WITH (NOLOCK) ON i.Id = g.RequestId
					  AND i.UserId = @referenceId
					  AND i.Firm = @firm
					  AND g.ImportResult = 0
					  AND DocType = (@operationId - 1)
				  LEFT JOIN OP_IncomingLogCommonExtension logex WITH (NOLOCK) ON logex.Id = i.Id
			WHERE (@warehouseNr IS NOT NULL OR logex.WhouseNr IS NULL)
					AND (@warehouseNr IS NULL OR logex.WhouseNr = @warehouseNr)
					AND i.RegisteredDate >= DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
					AND g.RegisteredDate >= DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
					AND i.ClientId = @clientId
			
			UNION ALL
			
			SELECT COUNT(*)
			FROM OP_RequestQueue r WITH (NOLOCK)
			LEFT JOIN OP_RequestQueueCommonExtension rc WITH (NOLOCK) ON rc.Id = r.Id
				  AND r.UserId = @referenceId
				  AND r.Firm = @firm
				  AND r.DocType = (@operationId - 1)
			WHERE (@warehouseNr IS NOT NULL OR rc.WhouseNr IS NULL)
					AND (@warehouseNr IS NULL OR rc.WhouseNr = @warehouseNr)
					AND r.RegisteredDate >= DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) 
					AND r.Step = 20
					AND r.ClientId = @clientId) AS ss)  
END