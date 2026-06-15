create function F_SYS_GetDynamicComponentUsedColumnType(@componentId int)
    Returns Table
        AS
        RETURN
            (
                SELECT DATA_TYPE
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = (select top(1)  TableName from SYS_DynamicComponent where Id=@componentId)
                  AND COLUMN_NAME = (select top(1)  UsedColumn from SYS_DynamicComponent where  Id=@componentId)
            )
go