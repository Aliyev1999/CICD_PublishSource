create or alter function F_SYS_GetIntTableWithSting(@items nvarchar(max))
    Returns Table
               RETURN SELECT DISTINCT CAST(Value as int) Item  FROM F_SplitList(@items, ',')
go