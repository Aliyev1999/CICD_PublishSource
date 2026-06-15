CREATE function F_SYS_GetNonGridRelatedActionDynamicComponent(@componentId int, @actionId int )
    Returns Table
        AS
        RETURN
            (
                select d.Id,
                       d.Name,
                       d.TableName,
                       d.IsActive,
                       d.UsedColumn,
                       d.DisplayName,
                       d.Description,
                       d.Condition,
                       d.Separator,
                       m.SqlParameterName,
                       STUFF(
                               (SELECT iif(d.Separator is null, ' ', d.Separator) + c.ColumnName
                                FROM SYS_DynamicComponentDisplayColumns c
                                WHERE c.ComponentId = d.Id
                                FOR XML PATH (''))
                           , 1, 1, '') AS DisplayColumns
                from SYS_DynamicComponent d
                          join  SYS_NonGridRelatedActionInput m on m.ComponentId= d.Id
                         join SYS_DynamicComponentDisplayColumns c
                              on d.Id = c.ComponentId
                        where  d.Id=@componentId and m.ActionId=@actionId
                group by d.Id,
                         d.Name,
                         d.TableName,
                         d.IsActive,
                         d.UsedColumn,
                         d.DisplayName,
                         d.Description,
                         d.Condition,
                         d.Separator,
                         m.SqlParameterName
            )
go