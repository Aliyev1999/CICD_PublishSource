CREATE OR ALTER function [dbo].[F_MGM_GetAllPermittedUsersPermittedCashCard](@UserId bigint)
    RETURNS TABLE
        AS
        RETURN
        (
		SELECT CashCard.Firm,
                CashCard.TigerId                 AS CashCard,
                CashCard.Code,
                CashCard.Name,
                PermittedCashCard.OperationId,
                PermittedCashCard.IsDefault,
                CashCard.Status,
                CashCard.RegisteredDate          AS CashCardRegisteredDate,
                PermittedCashCard.RegisteredDate AS PermissionRegisteredDate
         FROM MD_PermittedCashCard AS PermittedCashCard WITH (NOLOCK)
                  INNER JOIN MD_CashCard AS CashCard WITH (NOLOCK)
                             ON CashCard.TigerId = PermittedCashCard.TigerCashCardId
                                 AND CashCard.Firm = PermittedCashCard.Firm
         WHERE PermittedCashCard.UserId = @UserId

);