CREATE OR  ALTER function [dbo].[F_MGM_GetStaticContent](@userId BIGINT, @referenceType TINYINT, @referenceId bigint)
RETURNS TABLE
AS
RETURN
SELECT Id, msr.Name FROM MD_StopReason msr
WHERE msr.Type = 2 and msr.IsActive=1 and msr.IsDeleted=0