CREATE OR ALTER FUNCTION [dbo].[FN_IM_GenerateActNumber]
(
	@firmNr smallint,
    @bindDirection tinyint, -- təhkim istiqaməti
    @bindedPlace nvarchar(50), -- təhkim yeri
    @plannedHandoverDate datetime, -- planlaşdırılan verilmə tarixi
    @plannedReturnDate datetime -- geri alınma tarixi
)
RETURNS nvarchar(20)
AS
BEGIN
DECLARE @maxId INT;
SELECT @maxId = MAX(Id) + 1 FROM IM_AssetBinding WHERE Firm=@firmNr;
RETURN @maxId

END
