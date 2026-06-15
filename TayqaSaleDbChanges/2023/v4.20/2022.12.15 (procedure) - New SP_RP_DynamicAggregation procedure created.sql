
/****** Object:  StoredProcedure [dbo].[SP_RP_DynamicAggregation]    Script Date: 12/15/2022 5:18:26 PM ******/

CREATE OR ALTER procedure [dbo].[SP_RP_DynamicAggregation] @Query nvarchar(max), @ArgumentField nvarchar(max), @ValueField nvarchar(max), @AggregateType nvarchar(20),
                                                 @SkipCount int, @TakeCount int, @Search nvarchar(500)
as
begin

    declare @SQL nvarchar(max) = concat('select ', @ArgumentField, ' as Argument, ', @AggregateType, @ValueField, ') as Value from (', @Query, ') T ')
    if @Search is not null set @SQL = concat(@SQL, ' where ', @ArgumentField , ' like ''%',@Search,'%''')
    set @SQL = concat(@SQL, ' group by ', @ArgumentField) 


	-- Finding the total count of records returned from query with WHERE clause applied
	declare @TotalQuery nvarchar(max) 
	set @TotalQuery	= concat('select count(*) from (' , @SQL, ') T')
	declare @Total table (TotalCount int) 


	insert into @Total (TotalCount)
	exec sp_executesql @TotalQuery, N'@Query nvarchar(max), @ArgumentField nvarchar(max), @ValueField nvarchar(max), 
	@AggregateType nvarchar(20), @Search nvarchar(500)',
         @Query = @Query,
         @ArgumentField = @ArgumentField,
         @ValueField = @ValueField,
         @AggregateType = @AggregateType,
		 @Search = @Search

	set @SQL = CONCAT(@SQL, ' order by Value desc')

	if @TakeCount is not null set @SQL = CONCAT( @SQL, '  offset ', @SkipCount, ' rows fetch next ', @TakeCount, ' rows only')

	print @SQL;

	declare @QueryResult table (Argument nvarchar(1000), Value float)

	insert into @QueryResult (Argument, Value)
    exec sp_executesql @SQL, N'@Query nvarchar(max), @ArgumentField nvarchar(max), @ValueField nvarchar(max), @AggregateType nvarchar(20),
	 @SkipCount int, @TakeCount int, @Search nvarchar(500)',
         @Query = @Query,
         @ArgumentField = @ArgumentField,
         @ValueField = @ValueField,
         @AggregateType = @AggregateType,
		 @SkipCount = @SkipCount,
		 @TakeCount = @TakeCount,
		 @Search = @Search


	select * from @QueryResult, @Total
end
