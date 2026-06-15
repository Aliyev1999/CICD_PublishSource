ALTER FUNCTION [dbo].[F_SM_GetOrderTemplates](
    @UserId INT,
    @OperationId Tinyint,
    @ClientId bigint
    )
    RETURNS @T TABLE
               (
                   TemplateId        int,
                   TemplateCode      nvarchar(100),
                   TemplateName      nvarchar(100),
                   TemplateGroupName nvarchar(100)
               )
    AS
    begin

        declare @TruckNo nvarchar(50) = (select Name from AbpUsers where Id = @UserId)

        insert into @T (TemplateId, TemplateCode, TemplateName, TemplateGroupName)
        SELECT LOGICALREF, LOGICALREF, FICHENO, N'Açıq fakturalar'
        FROM REPORTBASE_2021.[dbo].[FN_MUSTERIDE ACIQ QALAN FAKTURALARIN SIYAHISI For TAYQA](@TruckNo, @ClientId);


        -------******* SIFARIS FAKTURALARI **** -----

        insert into @T (TemplateId, TemplateCode, TemplateName, TemplateGroupName)
        SELECT LOGICALREF, LOGICALREF, FICHENO, N'Sifariş fakturaları'
        FROM REPORTBASE_2021.[dbo].[FN_MUSTERIDE SIFARIS FAKTURALARIN SIYAHISI For TAYQA]('200', @ClientId);


        return
    end
