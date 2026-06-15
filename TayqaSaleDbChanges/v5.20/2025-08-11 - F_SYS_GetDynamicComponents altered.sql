ALTER    function [dbo].[F_SYS_GetDynamicComponents](@tenantId int = Null)
    Returns Table
        AS
        RETURN
        (
        SELECT d.Id,
               d.Name,
               d.TableName,
               d.IsActive,
               d.UsedColumn,
               d.DisplayName,
               d.Description,
               d.Condition,
               d.Separator,
               d.ComponentType,
               d.SelectType,
               STUFF(
                       (SELECT iif(d.Separator is null, ' ', d.Separator) + c.ColumnName
                        FROM SYS_DynamicComponentDisplayColumns c
                        WHERE c.ComponentId = d.Id
                        FOR XML PATH (''))
                   , 1, 1, '') AS DisplayColumns
        from SYS_DynamicComponent d
                 left join SYS_DynamicComponentDisplayColumns c
                           on d.Id = c.ComponentId
        where (@tenantId is null or d.TenantId = @tenantId)
        GROUP BY d.Id,
                 d.Name,
                 d.TableName,
                 d.IsActive,
                 d.UsedColumn,
                 d.DisplayName,
                 d.Description,
                 d.Condition,
                 d.Separator,
                 d.ComponentType,
                 d.SelectType

        )
go

