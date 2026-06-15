ALTER function [dbo].[MN_GetPendingRequests](@waitTime DATETIME)
    Returns Table
        AS
        RETURN
            (
				SELECT Id as Value FROM OP_RequestQueue WITH (NOLOCK) WHERE ProcessingStatus = 1 AND RegisteredDate < @waitTime  AND Step !=8 and Step!=5 AND IgnoreSuspended = 0
            )