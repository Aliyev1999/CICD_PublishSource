CREATE function dbo.MN_GetPendingRequests(@waitTime DATETIME)
    Returns Table
        AS
        RETURN
            (
                SELECT COUNT(*) as Value FROM OP_RequestQueue WITH (NOLOCK) WHERE ProcessingStatus = 1 AND RegisteredDate > @waitTime AND Step != 5 and Step != 8
            )
GO