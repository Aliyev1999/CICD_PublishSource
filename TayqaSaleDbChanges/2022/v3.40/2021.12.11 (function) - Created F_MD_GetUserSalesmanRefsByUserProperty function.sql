CREATE FUNCTION [dbo].[F_MD_GetUserSalesmanRefsByUserProperty](@userId int, @firm smallint)
RETURNS @TResult TABLE(SalesmanRef int)
BEGIN
INSERT @TResult
Select Distinct S.TigerId As SalesmanRef
From MD_SalesmanClientMapping SM
Inner Join F_GetPermittedClientForUser(@userId) PC On (PC.Firm = SM.Firm And PC.ClientId = SM.ClientId)
Inner Join MD_Salesman S On (S.Firm = SM.Firm And S.TigerId = SM.SalesmanId)
Where PC.UserId = @userId And SM.Firm = @firm

return;
END;
GO


