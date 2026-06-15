CREATE OR ALTER function [dbo].[F_MGM_UserCashCardPermissions](@UserId bigint)
    RETURNS TABLE
        AS
        RETURN
        SELECT CashCard
        FROM [dbo].[F_MGM_GetAllPermittedUsersPermittedCashCard](@UserId)