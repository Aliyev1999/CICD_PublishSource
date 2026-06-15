
CREATE FUNCTION F_MD_GetClientRelatedDocumentCountRestriction
(
	@firm smallint,
	@operationId tinyint,
	@warehouseNr int  = null,
	@referenceId int
)
returns @T table
(
	Limit int,
	ReferenceId int
)
AS
BEGIN

	INSERT INTO @T
	SELECT docRest.Limit, docRest.ReferenceId from MD_DocumentCountRestriction docRest WITH(NOLOCK)
	WHERE RestrictionType = 1
	  AND ReferenceId = @referenceId
	  AND IsActive = 1
      AND (@warehouseNr IS NOT NULL OR WarehouseNr IS NULL)
      AND (@warehouseNr IS NULL OR WarehouseNr = @warehouseNr)
	  AND OperationId = @operationId
	  AND Firm = @firm
	  AND RestrictionTargetType = 2

	RETURN;
END