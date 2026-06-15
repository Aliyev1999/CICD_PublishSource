
/****** Object:  UserDefinedFunction [dbo].[FN_CDE_GetAdditionalFieldsForExchangeRequest]    Script Date: 4/21/2025 3:05:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[FN_CDE_GetAdditionalFieldsForExchangeRequest](@fichNo nvarchar, @docType tinyint)
    Returns Table
        AS
        RETURN(SELECT 'Distributor_Code' AS DistributorCode, 'Client_Code' AS ClientCode)
GO
