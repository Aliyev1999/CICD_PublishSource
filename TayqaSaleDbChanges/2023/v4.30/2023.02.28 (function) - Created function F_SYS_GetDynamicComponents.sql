CREATE function F_SYS_GetDynamicComponents()
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
                       STUFF(
                               (SELECT iif(d.Separator is null, ' ', d.Separator) + c.ColumnName
                                FROM SYS_DynamicComponentDisplayColumns c
                                WHERE c.ComponentId = d.Id
                                FOR XML PATH (''))
                           , 1, 1, '') AS DisplayColumns
                from SYS_DynamicComponent d
                         join SYS_DynamicComponentDisplayColumns c
                              on d.Id = c.ComponentId
                GROUP BY d.Id,
                         d.Name,
                         d.TableName,
                         d.IsActive,
                         d.UsedColumn,
                         d.DisplayName,
                         d.Description,
                         d.Condition,
                         d.Separator
            )
go