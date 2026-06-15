
CREATE procedure [dbo].[SP_RP_DynamicAggregationForSplineChart] @Query nvarchar(max), @Series nvarchar(max), @Legend nvarchar(max), @ValueField nvarchar(max),
                                                               @AggregateType nvarchar(max), @Search nvarchar(max) = null
as
begin

    declare @SQL nvarchar(max)

    set @SQL = concat('
	select ', @Series, ' as Series, 
	isnull(nullif(', @Legend, ', ''''), ''OtherValues'') as Legend , ', 
	@AggregateType, @ValueField, ') as Value 
	from (', @Query, ') T ')
    if @Search is not null set @SQL = concat(@SQL, ' where ', @Legend, ' like ''%', @Search, '%''')
    set @SQL = concat(@SQL, ' group by ', @Series, ', ', @Legend)

    DECLARE @columns NVARCHAR(MAX), @FinalSQL NVARCHAR(MAX);
    SET @columns = N'';

    declare @AggregatedData table
                            (
                                Series nvarchar(max),
                                Legend nvarchar(max),
                                Value  float
                            )

    insert into @AggregatedData (Series, Legend, Value)
        exec sp_executesql @SQL

    SELECT @columns += N', p.' + QUOTENAME([Legend])
    FROM (SELECT Legend
          FROM @AggregatedData AS p
          GROUP BY Legend) AS x;

    SET @FinalSQL = N'
            SELECT [Series], ' + STUFF(@columns, 1, 2, '') + ' FROM (
            SELECT [Series], [Value], [Legend]
                FROM (' + @sql + ') T ) AS j PIVOT (sum(Value) FOR [Legend] in
                   (' + STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '') + ')) AS p;';

    EXEC sp_executesql @FinalSQL, N'@Query nvarchar(max), @Series nvarchar(max), @Legend nvarchar(max), @ValueField nvarchar(max),
                                    @AggregateType nvarchar(max), @Search nvarchar(max) = null',
         @Query = @Query,
         @Series = @Series,
         @Legend = @Legend,
         @ValueField = @ValueField,
         @AggregateType = @AggregateType,
         @Search = @Search

end
