
CREATE procedure [dbo].[SP_GetDistinctValuesFromQueryResult] @query nvarchar(max) as
begin
declare @tableId nvarchar(50) = newid()

set @tableId = REPLACE(@tableId, '-','_')

declare @CreateQuery nvarchar(max) = 'create table ##' + @tableId + ' ('declare @ColumnNames      VARCHAR(max)
select @ColumnNames = coalesce(@ColumnNames + ', ', '') + concat([Name], ' ', system_type_name)
FROM sys.dm_exec_describe_first_result_set(@query, null, 0)
set @CreateQuery = concat(@CreateQuery, @ColumnNames, ')

insert into ##', @tableId,' ', @query,'  

select distinct [ColumnName],
                Value
from (select MainResult.N.value(''local-name(.)'', ''nvarchar(max)'') as [ColumnName],
             MainResult.N.value(''text()[1]'', ''nvarchar(max)'')     as Value
      from (select *
            from ##' ,@tableId , ' 
            for xml path(''''), type) as Itself(X)
               cross apply Itself.X.nodes(''/*'') as MainResult(N)) FinalResult')

exec sp_executesql @CreateQuery
end

