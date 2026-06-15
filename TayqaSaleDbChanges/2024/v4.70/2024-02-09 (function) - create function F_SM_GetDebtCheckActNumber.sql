CREATE FUNCTION [dbo].[F_SM_GetDebtCheckActNumber](
    @firm smallint,
    @clientId int,
    @creatorUserId bigint,
    @controlUserId int,
    @controlDate datetime =null
)
    RETURNS nvarchar(50)
AS
BEGIN
    DECLARE @result NVARCHAR(50);

    DECLARE @maxId INT;
    SELECT @maxId = MAX(Id) + 1 FROM AO_AuditOperation where Firm=@firm;

    SET @result = 'TEF-' + CAST(@maxId AS NVARCHAR(10));

    RETURN @result;

END

