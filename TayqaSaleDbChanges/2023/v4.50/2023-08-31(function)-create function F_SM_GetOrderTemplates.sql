CREATE FUNCTION [dbo].[F_SM_GetOrderTemplates](
    @UserId INT,
    @OperationId Tinyint,
    @ClientId bigint
    )
    RETURNS @T TABLE
               (
                   TemplateId   int,
                   TemplateCode nvarchar(100),
                   TemplateName nvarchar(100)
               )
    AS
    begin

        if @OperationId < 10
            begin
                insert into @T (TemplateId, TemplateCode, TemplateName)
                select lo.Id                                               as TemplateId,
                       json_value(rs.ImportResult, '$.ERPDocInfo.FicheNo') as TemplateCode,
                       json_value(rs.ImportResult, '$.ERPDocInfo.FicheNo') as TemplateName
                from OP_IncomingLog lo with (nolock)
                         join OP_GeneralLog gl with (nolock) on gl.RequestId = lo.Id and gl.ImportResult = 0
                         join OP_ERPIntegrationtResultLog rs with (nolock) on gl.Id = rs.GeneralId
                where DocType = @OperationId - 1
                  and lo.UserId = @UserId
                  and lo.ClientId = @ClientId
                  and ProcessDate >= dateadd(day, -3, getdate())
            end

        if @OperationId in (22, 23, 24, 25)
            insert into @T (TemplateId, TemplateCode, TemplateName)
            select distinct Template.Id, Template.Code, Template.Name
            from OP_OnlineOfferTemplateUserMapping Mapping with (nolock)
                     join OP_OnlineOfferTemplate Template with (nolock) on Template.Id = Mapping.TemplateId
            where UserId = @UserId and Template.IsActive=1 and  
			          ( (@OperationId = 25 AND SUBSTRING(Template.OperationsMask, LEN(Template.OperationsMask) - 0, 1) = '1')
				   OR (@OperationId = 24 AND SUBSTRING(Template.OperationsMask, LEN(Template.OperationsMask) - 1, 1) = '1')
                   OR (@OperationId = 23 AND SUBSTRING(Template.OperationsMask, LEN(Template.OperationsMask) - 2, 1) = '1')
                   OR (@OperationId = 22 AND SUBSTRING(Template.OperationsMask, LEN(Template.OperationsMask) - 3, 1) = '1')
				   )
				   and Template.IsActive=1
			 
        return
    end